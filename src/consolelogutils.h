#ifndef CONSOLELOGUTILS_H
#define CONSOLELOGUTILS_H

#include <QObject>

namespace space {
namespace qyvlik {

class ConsoleLogUtilsPrivate;
class ConsoleLogUtils : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString logFile READ logFile WRITE setLogFile NOTIFY logFileChanged)
public:
    explicit ConsoleLogUtils(QObject *parent = 0);
    ~ConsoleLogUtils();

    QString logFile() const;

    void setLogFile(const QString &logFile);

    void write(QtMsgType type, const QMessageLogContext &context, const QString &message);

    static ConsoleLogUtils *instance();

    static void installMessageHandler();

signals:
    void logFileChanged(const QString& logFile);

public slots:

private:
    ConsoleLogUtilsPrivate* d_ptr;
};

} // namespace qyvlik
} // namespace space

#endif // CONSOLELOGUTILS_H
