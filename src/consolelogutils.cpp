#include "consolelogutils.h"

#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QFileInfo>
#include <QDir>
#include <QDateTime>
#include <QCoreApplication>

namespace space {
namespace qyvlik {

class ConsoleLogUtilsPrivate {
public:
    ConsoleLogUtilsPrivate(QObject* parent):
        qFile(new QFile(parent))
    {}

    ~ConsoleLogUtilsPrivate()
    {
        qFile->close();
    }

    QFile* qFile;
    QString mLogFile;

    void messageHandler(QString currentTargetFilePath, QtMsgType type, const QMessageLogContext &, const QString &message_)
    {
        QString message;

        switch ( type )
        {
        case QtDebugMsg:
        {
            message = message_;
            break;
        }
        case QtWarningMsg:
        {
            message.append("Warning: ");
            message.append(message_);
            break;
        }
        case QtCriticalMsg:
        {
            message.append("Critical: ");
            message.append(message_);
            break;
        }
        case QtFatalMsg:
        {
            message.append("Fatal: ");
            message.append(message_);
            break;
        }
        default: { break; }
        }

        if ( !QFileInfo::exists( currentTargetFilePath ) )
        {
            QDir().mkpath( QFileInfo( currentTargetFilePath ).path() );
        }

        qFile->setFileName(currentTargetFilePath);
        qFile->open( QIODevice::WriteOnly | QIODevice::Append );

        QTextStream textStream( qFile );
        textStream << QDateTime::currentDateTime().toString( "yyyy-MM-dd hh:mm:ss" ) << ": " << message << endl;

        //qFile->close();
    }

};

ConsoleLogUtils::ConsoleLogUtils(QObject *parent) :
    QObject(parent),
    d_ptr(new ConsoleLogUtilsPrivate(this))
{
}

ConsoleLogUtils::~ConsoleLogUtils()
{
    delete d_ptr;
    d_ptr = Q_NULLPTR;
}

QString ConsoleLogUtils::logFile() const
{
    return d_ptr->mLogFile;
}

void ConsoleLogUtils::setLogFile(const QString &logFile)
{
    if (d_ptr->mLogFile != logFile) {
        d_ptr->mLogFile = logFile;
        Q_EMIT logFileChanged(logFile);
    }
}

void ConsoleLogUtils::write(QtMsgType type, const QMessageLogContext & context, const QString &message)
{
    if (d_ptr != Q_NULLPTR) {
        d_ptr->messageHandler(logFile(), type, context, message);
    }
}

ConsoleLogUtils *ConsoleLogUtils::instance()
{
    static ConsoleLogUtils* i = new ConsoleLogUtils(QCoreApplication::instance());
    return i;
}

static void messageHandler(QtMsgType type, const QMessageLogContext & context, const QString &message) {
    ConsoleLogUtils::instance()->write(type, context, message);
}

void ConsoleLogUtils::installMessageHandler()
{
    qInstallMessageHandler(messageHandler);
}

} // namespace qyvlik
} // namespace space
