#include "livecapturewizard.h"
#include "webcamsource.h"
#include "dftarea.h"
#include "IgramArea.h"
#include "mainwindow.h"
#include "circleoutline.h"

#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGroupBox>
#include <QComboBox>
#include <QRadioButton>
#include <QLabel>
#include <QPushButton>
#include <QProgressBar>
#include <QSpinBox>
#include <QMessageBox>
#include <QDir>
#include <QPixmap>
#include <QPainter>

static cv::Mat qImageToGrayMat(const QImage &img)
{
    QImage gray = img.convertToFormat(QImage::Format_Grayscale8);
    cv::Mat mat(gray.height(), gray.width(), CV_8UC1,
                (void *)gray.constBits(), gray.bytesPerLine());
    return mat.clone();
}

LiveCaptureWizard::LiveCaptureWizard(QWidget *parent)
    : QDialog(parent)
{
    setWindowTitle("Live Capture (Webcam)");
    resize(720, 640);

    m_source = new WebcamSource(this);
    connect(m_source, &WebcamSource::newFrame, this, &LiveCaptureWizard::onFrame);
    connect(m_source, &WebcamSource::errorOccurred, this, &LiveCaptureWizard::onCameraError);

    auto *layout = new QVBoxLayout(this);

    auto *setupBox = new QGroupBox("Setup", this);
    auto *setupLayout = new QHBoxLayout(setupBox);
    setupLayout->addWidget(new QLabel("Camera:", setupBox));
    m_cameraCombo = new QComboBox(setupBox);
    setupLayout->addWidget(m_cameraCombo, 1);

    setupLayout->addWidget(new QLabel("Zygo FOV:", setupBox));
    m_fov105 = new QRadioButton("105 mm", setupBox);
    m_fov33 = new QRadioButton("33 mm", setupBox);
    m_fov105->setChecked(true);
    setupLayout->addWidget(m_fov105);
    setupLayout->addWidget(m_fov33);

    setupLayout->addWidget(new QLabel("Frames:", setupBox));
    m_frameCountSpin = new QSpinBox(setupBox);
    m_frameCountSpin->setRange(5, 300);
    m_frameCountSpin->setValue(40);
    setupLayout->addWidget(m_frameCountSpin);
    layout->addWidget(setupBox);

    m_preview = new QLabel(this);
    m_preview->setMinimumSize(480, 360);
    m_preview->setAlignment(Qt::AlignCenter);
    m_preview->setStyleSheet("background-color: black;");
    m_preview->setText("No camera");
    layout->addWidget(m_preview, 1);

    m_instructions = new QLabel(
        "Select a camera, choose the interferometer FOV setting in use, then "
        "click Start Capture and slowly turn one of the tilt adjustment knobs "
        "on the table while frames are recorded. Ambient vibration between "
        "turns adds useful variation too.", this);
    m_instructions->setWordWrap(true);
    layout->addWidget(m_instructions);

    m_progress = new QProgressBar(this);
    layout->addWidget(m_progress);

    m_status = new QLabel("Ready.", this);
    layout->addWidget(m_status);

    auto *btnLayout = new QHBoxLayout();
    m_startBtn = new QPushButton("Start Capture", this);
    m_stopBtn = new QPushButton("Stop Now", this);
    m_acceptBtn = new QPushButton("Accept && Reconstruct", this);
    m_retryBtn = new QPushButton("Retry", this);
    m_stopBtn->setEnabled(false);
    m_acceptBtn->hide();
    m_retryBtn->hide();
    btnLayout->addWidget(m_startBtn);
    btnLayout->addWidget(m_stopBtn);
    btnLayout->addWidget(m_acceptBtn);
    btnLayout->addWidget(m_retryBtn);
    layout->addLayout(btnLayout);

    connect(m_cameraCombo, QOverload<int>::of(&QComboBox::currentIndexChanged),
            this, &LiveCaptureWizard::onCameraSelected);
    connect(m_startBtn, &QPushButton::clicked, this, &LiveCaptureWizard::startCapture);
    connect(m_stopBtn, &QPushButton::clicked, this, &LiveCaptureWizard::stopCaptureAndProcess);
    connect(m_acceptBtn, &QPushButton::clicked, this, &LiveCaptureWizard::acceptResult);
    connect(m_retryBtn, &QPushButton::clicked, this, &LiveCaptureWizard::retry);

    refreshCameraList();
}

LiveCaptureWizard::~LiveCaptureWizard()
{
    if (m_source)
        m_source->close();
}

void LiveCaptureWizard::refreshCameraList()
{
    m_devices = WebcamSource::availableCameras();
    m_cameraCombo->clear();
    for (const QCameraDevice &d : m_devices)
        m_cameraCombo->addItem(d.description());

    if (m_devices.isEmpty()) {
        m_status->setText("No camera found.");
        m_startBtn->setEnabled(false);
    } else {
        onCameraSelected(0);
    }
}

void LiveCaptureWizard::onCameraSelected(int index)
{
    if (index < 0 || index >= m_devices.size())
        return;
    if (!m_source->open(m_devices[index]))
        m_status->setText("Failed to open camera.");
}

void LiveCaptureWizard::onCameraError(const QString &message)
{
    m_status->setText("Camera error: " + message);
}

void LiveCaptureWizard::updatePreview(const QImage &frame)
{
    QPixmap pix = QPixmap::fromImage(frame).scaled(
        m_preview->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    m_preview->setPixmap(pix);
}

void LiveCaptureWizard::onFrame(const QImage &frame)
{
    m_lastFrame = frame;
    updatePreview(frame);

    if (!m_capturing)
        return;

    m_capturedGray.push_back(qImageToGrayMat(frame));
    m_progress->setValue((int)m_capturedGray.size());
    m_status->setText(QString("Capturing... %1 / %2 frames")
                           .arg(m_capturedGray.size())
                           .arg(m_progress->maximum()));

    if ((int)m_capturedGray.size() >= m_progress->maximum())
        stopCaptureAndProcess();
}

void LiveCaptureWizard::startCapture()
{
    QMessageBox::information(this, "Turn the tilt knob",
        "Now slowly and steadily turn one of the tilt adjustment knobs on the "
        "interferometer table while frames are captured. Keep going for the "
        "whole capture - table vibration between turns helps too.\n\n"
        "Click OK to begin.");

    m_capturedGray.clear();
    m_capturing = true;
    m_progress->setRange(0, m_frameCountSpin->value());
    m_progress->setValue(0);
    m_startBtn->setEnabled(false);
    m_stopBtn->setEnabled(true);
    m_cameraCombo->setEnabled(false);
    setResultControlsVisible(false);
    m_status->setText("Capturing...");
}

void LiveCaptureWizard::stopCaptureAndProcess()
{
    m_capturing = false;
    m_stopBtn->setEnabled(false);

    if (m_capturedGray.size() < 3) {
        QMessageBox::warning(this, "Not enough frames",
            "Need at least 3 frames to reconstruct anything useful. Try again.");
        m_startBtn->setEnabled(true);
        m_cameraCombo->setEnabled(true);
        return;
    }

    m_status->setText("Computing mask, FOV scale and filter radius...");
    QApplication::processEvents();

    m_computedMask = computeVisibilityMask(m_capturedGray);
    m_computedFov = detectFovCircle(m_capturedGray.back());
    m_mmPerPixel = mmPerPixelFromFov(m_computedFov, selectedFovDiameterMM());
    m_representativeFrame = m_lastFrame;

    DFTArea *view = DFTArea::get_Instance();
    m_computedFilter = searchCenterFilterRadius(view, m_representativeFrame, m_computedMask);

    // Overlay the computed mask on the preview so the user can sanity-check it.
    QImage overlay = m_representativeFrame.convertToFormat(QImage::Format_ARGB32);
    for (int y = 0; y < overlay.height() && y < m_computedMask.rows; ++y) {
        const uchar *maskRow = m_computedMask.ptr<uchar>(y);
        QRgb *line = reinterpret_cast<QRgb *>(overlay.scanLine(y));
        for (int x = 0; x < overlay.width() && x < m_computedMask.cols; ++x) {
            if (maskRow[x] == 0) {
                QColor c(line[x]);
                c.setRed(c.red() / 3);
                c.setGreen(c.green() / 3);
                line[x] = c.rgba();
            }
        }
    }
    updatePreview(overlay);

    QString scaleText = m_mmPerPixel > 0
        ? QString("%1 mm/pixel").arg(m_mmPerPixel, 0, 'f', 5)
        : "FOV disk not found - scale unavailable";

    m_status->setText(QString("Filter radius=%1  (%2 valid samples)  Scale: %3")
                           .arg(m_computedFilter.radius, 0, 'f', 1)
                           .arg(m_capturedGray.size())
                           .arg(scaleText));

    setResultControlsVisible(true);
}

void LiveCaptureWizard::acceptResult()
{
    if (m_representativeFrame.isNull() || m_computedMask.empty()) {
        QMessageBox::warning(this, "Nothing to accept", "Capture and process a stack first.");
        return;
    }

    QString tempPath = QDir::temp().filePath("dftfringe_livecapture.png");
    if (!m_representativeFrame.save(tempPath, "PNG")) {
        QMessageBox::warning(this, "Failed", "Could not write temporary capture image.");
        return;
    }

    if (!MainWindow::me || !MainWindow::me->m_igramArea) {
        QMessageBox::warning(this, "Failed", "Main window not available.");
        return;
    }

    IgramArea *igramArea = MainWindow::me->m_igramArea;
    if (!igramArea->openImage(tempPath, true)) {
        QMessageBox::warning(this, "Failed", "Could not load the captured frame.");
        return;
    }

    DFTArea *view = DFTArea::get_Instance();
    CircleOutline outside(m_computedFov.found
                               ? QPointF(m_computedFov.center.x, m_computedFov.center.y)
                               : QPointF(m_computedMask.cols / 2.0, m_computedMask.rows / 2.0),
                           m_computedFov.found ? m_computedFov.radiusPx
                                                : std::min(m_computedMask.cols, m_computedMask.rows) / 2.0);
    view->setAutoMask(m_computedMask, outside);
    view->dftCenterFilter(m_computedFilter.radius);
    view->makeSurface();

    QString msg = m_mmPerPixel > 0
        ? QString("Surface reconstructed.\nLateral scale: %1 mm/pixel (%2 mm FOV setting).")
              .arg(m_mmPerPixel, 0, 'f', 5)
              .arg(selectedFovDiameterMM())
        : "Surface reconstructed.\nFOV disk was not detected, so lateral mm/pixel scale is unavailable.";
    QMessageBox::information(this, "Live Capture", msg);

    accept();
}

void LiveCaptureWizard::retry()
{
    m_capturedGray.clear();
    setResultControlsVisible(false);
    m_startBtn->setEnabled(true);
    m_cameraCombo->setEnabled(true);
    m_progress->setValue(0);
    m_status->setText("Ready.");
}

void LiveCaptureWizard::setResultControlsVisible(bool visible)
{
    m_acceptBtn->setVisible(visible);
    m_retryBtn->setVisible(visible);
}

double LiveCaptureWizard::selectedFovDiameterMM() const
{
    return m_fov105->isChecked() ? 105.0 : 33.0;
}
