#ifndef WEBCAMSOURCE_H
#define WEBCAMSOURCE_H

#include <QObject>
#include <QImage>
#include <QCamera>
#include <QCameraDevice>
#include <QMediaCaptureSession>
#include <QVideoSink>
#include <QList>

// Thin wrapper around Qt Multimedia so the rest of the app only deals in
// QImage frames, matching what IgramArea/DFTArea already consume.
class WebcamSource : public QObject
{
    Q_OBJECT
public:
    explicit WebcamSource(QObject *parent = nullptr);
    ~WebcamSource();

    static QList<QCameraDevice> availableCameras();

    bool open(const QCameraDevice &device);
    void close();
    bool isOpen() const;

signals:
    void newFrame(const QImage &frame);
    void errorOccurred(const QString &message);

private slots:
    void handleVideoFrame(const QVideoFrame &frame);
    void handleCameraError(QCamera::Error error, const QString &errorString);

private:
    QCamera *m_camera = nullptr;
    QMediaCaptureSession m_session;
    QVideoSink m_sink;
};

#endif // WEBCAMSOURCE_H
