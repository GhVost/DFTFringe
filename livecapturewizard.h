#ifndef LIVECAPTUREWIZARD_H
#define LIVECAPTUREWIZARD_H

#include <QDialog>
#include <QImage>
#include <QCameraDevice>
#include <vector>
#include <opencv2/opencv.hpp>
#include "autoreconstruct.h"

class QComboBox;
class QRadioButton;
class QLabel;
class QPushButton;
class QProgressBar;
class QSpinBox;
class WebcamSource;

// Guided capture flow for wafer profiling on a flat-etalon interferometer:
//  1. pick the webcam and the interferometer's FOV setting (105 / 33 mm)
//  2. capture a stack of frames while the user nudges a tilt adjustment knob
//     (ambient vibration + the nudge supplies the frame-to-frame variation)
//  3. from that stack, automatically derive: the valid-surface mask (from
//     per-pixel fringe visibility), the vortex center-filter radius, and the
//     lateral mm/pixel scale (from the illuminated FOV disk size)
//  4. hand the result to the existing DFTArea/IgramArea pipeline to produce
//     a normal, exportable surface - no Zernike step involved.
class LiveCaptureWizard : public QDialog
{
    Q_OBJECT
public:
    explicit LiveCaptureWizard(QWidget *parent = nullptr);
    ~LiveCaptureWizard();

private slots:
    void onCameraSelected(int index);
    void onFrame(const QImage &frame);
    void onCameraError(const QString &message);
    void startCapture();
    void stopCaptureAndProcess();
    void acceptResult();
    void retry();

private:
    void refreshCameraList();
    void updatePreview(const QImage &frame);
    double selectedFovDiameterMM() const;
    void setResultControlsVisible(bool visible);

    WebcamSource *m_source;
    QList<QCameraDevice> m_devices;

    QComboBox *m_cameraCombo;
    QRadioButton *m_fov105;
    QRadioButton *m_fov33;
    QSpinBox *m_frameCountSpin;
    QLabel *m_preview;
    QLabel *m_instructions;
    QLabel *m_status;
    QPushButton *m_startBtn;
    QPushButton *m_stopBtn;
    QPushButton *m_acceptBtn;
    QPushButton *m_retryBtn;
    QProgressBar *m_progress;

    std::vector<cv::Mat> m_capturedGray;
    QImage m_lastFrame;
    QImage m_representativeFrame;
    bool m_capturing = false;

    cv::Mat m_computedMask;
    FilterSearchResult m_computedFilter;
    FovResult m_computedFov;
    double m_mmPerPixel = 0.0;
};

#endif // LIVECAPTUREWIZARD_H
