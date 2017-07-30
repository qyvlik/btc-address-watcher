#include "sqliteutils.h"

#include <QtQml/QQmlEngine>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QDir>

namespace space {
namespace qyvlik {

SQLiteUtils::SQLiteUtils(QQmlEngine *engine, QObject *parent)
    : QObject(parent),
      qmlEngine(engine)
{

}

bool SQLiteUtils::vacuum4qml(const QString fileName) {

    if (qmlEngine == Q_NULLPTR) {
        qDebug() << Q_FUNC_INFO << " return false, qmlEngine is null";
        return false;
    }

    QString offlineStoragePath = qmlEngine->offlineStoragePath();

    QString databaseFile = offlineStoragePath + QDir::separator() +
            "Databases" + QDir::separator() + fileName + ".sqlite";

    qDebug() << Q_FUNC_INFO << " databaseFile: " << databaseFile;

    static QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName(databaseFile);
    bool isOpen = db.open();

    if (!isOpen) {
        qDebug() << Q_FUNC_INFO << " database can't open";
        return false;
    }

    QSqlQuery query(db);

    query.prepare("VACUUM");

    bool result = query.exec();

    qDebug() << Q_FUNC_INFO << " exec sql result: " << result;

    if (!result) {
        qDebug() << Q_FUNC_INFO << " error:" << query.lastError();
    }

    db.close();

    return result;
}

} // namespace qyvlik
} // namespace space
