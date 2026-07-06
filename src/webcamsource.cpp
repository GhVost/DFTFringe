#include "webcamsource.h"
#include <QMediaDevices>

WebcamSource::WebcamSource(QObject *parent) : QObject(parent)
{
    m_session.setVideoSink(&m_sink);
    connect(&m_sink, &QVideoSink::videoFrameChanged, this, &WebcamSource::handleVideoFrame);
}

WebcamSource::~WebcamSource()
{
    close();
}

QList<QCameraDevice> WebcamSource::availableCameras()
{
    return QMediaDevices::videoInputs();
}

bool WebcamSource::open(const QCameraDevice &device)
{
    close();
    if (device.isNull())
        return false;

    m_camera = new QCamera(device, this);
    connect(m_camera, &QCamera::errorOccurred, this, &WebcamSource::handleCameraError);
    m_session.setCamera(m_camera);
    m_camera->start();
    return true;
}

void WebcamSource::close()
{
    if (m_camera) {
        m_camera->stop();
        m_session.setCamera(nullptr);
        m_camera->deleteLater();
        m_camera = nullptr;
    }
}

bool WebcamSource::isOpen() const
{
    return m_camera != nullptr && m_camera->isActive();
}

void WebcamSource::handleVideoFrame(const QVideoFrame &frame)
{
    if (!frame.isValid())
        return;
    QImage img = frame.toImage();
    if (!img.isNull())
        emit newFrame(img.copy());
}

void WebcamSource::handleCameraError(QCamera::Error error, const QString &errorString)
{
    if (error != QCamera::NoError)
        emit errorOccurred(errorString);
}
