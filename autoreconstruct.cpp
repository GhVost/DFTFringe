#include "autoreconstruct.h"
#include "dftarea.h"
#include "punwrap.h"
#include "myutils.h"

using namespace cv;

cv::Mat computeVisibilityMask(const std::vector<cv::Mat> &grayFrames,
                               double minRangeThreshold,
                               int morphKernelPx)
{
    if (grayFrames.empty())
        return cv::Mat();

    cv::Mat minAcc, maxAcc;
    grayFrames[0].convertTo(minAcc, CV_32F);
    maxAcc = minAcc.clone();

    for (size_t i = 1; i < grayFrames.size(); ++i) {
        cv::Mat f;
        grayFrames[i].convertTo(f, CV_32F);
        cv::min(minAcc, f, minAcc);
        cv::max(maxAcc, f, maxAcc);
    }

    cv::Mat range = maxAcc - minAcc;
    cv::Mat mask;
    cv::threshold(range, mask, minRangeThreshold, 255, cv::THRESH_BINARY);
    mask.convertTo(mask, CV_8U);

    if (morphKernelPx > 1) {
        cv::Mat kernel = cv::getStructuringElement(cv::MORPH_ELLIPSE,
                                                    cv::Size(morphKernelPx, morphKernelPx));
        cv::morphologyEx(mask, mask, cv::MORPH_CLOSE, kernel);
        cv::morphologyEx(mask, mask, cv::MORPH_OPEN, kernel);
    }

    // Keep only the largest connected blob and fill any internal holes
    // (dust / a saturated pixel shouldn't punch a hole in an otherwise valid area).
    std::vector<std::vector<cv::Point>> contours;
    cv::findContours(mask.clone(), contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_SIMPLE);
    if (contours.empty())
        return mask;

    size_t best = 0;
    double bestArea = 0;
    for (size_t i = 0; i < contours.size(); ++i) {
        double a = cv::contourArea(contours[i]);
        if (a > bestArea) {
            bestArea = a;
            best = i;
        }
    }

    cv::Mat filled = cv::Mat::zeros(mask.size(), CV_8U);
    cv::drawContours(filled, contours, (int)best, cv::Scalar(255), cv::FILLED);
    return filled;
}

FovResult detectFovCircle(const cv::Mat &grayFrame)
{
    FovResult res;
    cv::Mat gray8;
    if (grayFrame.type() != CV_8U)
        grayFrame.convertTo(gray8, CV_8U);
    else
        gray8 = grayFrame;

    cv::Mat blurred;
    cv::GaussianBlur(gray8, blurred, cv::Size(9, 9), 0);

    cv::Mat thresh;
    cv::threshold(blurred, thresh, 0, 255, cv::THRESH_BINARY | cv::THRESH_OTSU);

    std::vector<std::vector<cv::Point>> contours;
    cv::findContours(thresh, contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_SIMPLE);
    if (contours.empty())
        return res;

    size_t best = 0;
    double bestArea = 0;
    for (size_t i = 0; i < contours.size(); ++i) {
        double a = cv::contourArea(contours[i]);
        if (a > bestArea) {
            bestArea = a;
            best = i;
        }
    }

    cv::Point2f center;
    float radius = 0.f;
    cv::minEnclosingCircle(contours[best], center, radius);
    if (radius <= 0.f)
        return res;

    res.found = true;
    res.center = center;
    res.radiusPx = radius;
    return res;
}

double mmPerPixelFromFov(const FovResult &fov, double fovDiameterMM)
{
    if (!fov.found || fov.radiusPx <= 0.f)
        return 0.0;
    return fovDiameterMM / (2.0 * fov.radiusPx);
}

FilterSearchResult searchCenterFilterRadius(DFTArea *view,
                                             const QImage &representativeFrame,
                                             const cv::Mat &validMask,
                                             double rMin,
                                             double rMax,
                                             double rStep)
{
    FilterSearchResult best;
    if (!view || validMask.empty())
        return best;

    double bestScore = std::numeric_limits<double>::max();

    for (double r = rMin; r <= rMax; r += rStep) {
        QImage img = representativeFrame.copy();
        cv::Mat phase;
        try {
            phase = view->vortex(img, r);
        } catch (const std::exception &) {
            continue;
        }
        if (phase.empty() || phase.size() != validMask.size())
            continue;

        cv::Mat result = cv::Mat::zeros(phase.size(), numType);
        phase.copyTo(result, validMask);
        phase = result.clone();
        normalize(phase, phase, 0, 1., cv::NORM_MINMAX, numType, validMask);

        cv::Mat invMask = validMask.clone();
        invMask = (255 - validMask) / 255;

        cv::Mat unwrapped = cv::Mat::zeros(phase.size(), numType);
        unwrap((double *)(phase.data), (double *)(unwrapped.data),
               (char *)(invMask.data), phase.cols, phase.rows);

        cv::Mat lap;
        cv::Laplacian(unwrapped, lap, CV_64F, 3);
        cv::Scalar mean, stddev;
        cv::meanStdDev(lap, mean, stddev, validMask);
        double score = stddev[0] * stddev[0];

        if (score < bestScore) {
            bestScore = score;
            best.radius = r;
            best.score = score;
            best.ok = true;
        }
    }

    return best;
}
