/******************************************************************************
**
**  Support code for automated live-capture reconstruction:
**   - per-pixel valid-surface mask from fringe visibility across a frame stack
**   - illuminated FOV disk detection -> lateral mm/pixel scale
**   - automatic center-filter radius search for the vortex demodulator
**
****************************************************************************/
#ifndef AUTORECONSTRUCT_H
#define AUTORECONSTRUCT_H

#include <opencv2/opencv.hpp>
#include <QImage>
#include <vector>

class DFTArea;

// Per-pixel (max-min) intensity range across the stack, thresholded, then
// cleaned up (largest connected component, holes filled). 255 = valid surface,
// 0 = no fringe modulation ever seen at that pixel (outside part / no light).
cv::Mat computeVisibilityMask(const std::vector<cv::Mat> &grayFrames,
                               double minRangeThreshold = 15.0,
                               int morphKernelPx = 5);

struct FovResult {
    bool found = false;
    cv::Point2f center{0, 0};
    float radiusPx = 0.f;
};

// Detects the bright illuminated circular field against the dark surround
// that is characteristic of a Zygo-style flat-etalon FOV.
FovResult detectFovCircle(const cv::Mat &grayFrame);

// physical FOV diameter (105 or 33 mm) / detected pixel diameter
double mmPerPixelFromFov(const FovResult &fov, double fovDiameterMM);

struct FilterSearchResult {
    bool ok = false;
    double radius = 10.0;
    double score = 0.0; // lower is smoother/better
};

// Sweeps the vortex center-filter radius on a representative frame, scoring
// each candidate by the roughness (Laplacian variance) of the unwrapped phase
// inside mask, and returns the smoothest one. view is only used for its
// public vortex() method - no other state is touched.
FilterSearchResult searchCenterFilterRadius(DFTArea *view,
                                             const QImage &representativeFrame,
                                             const cv::Mat &validMask,
                                             double rMin = 2.0,
                                             double rMax = 40.0,
                                             double rStep = 1.0);

#endif // AUTORECONSTRUCT_H
