#ifndef SQLITEUTILS_H
#define SQLITEUTILS_H

#include <QObject>


class QQmlEngine;

namespace space {
namespace qyvlik {


class SQLiteUtils : public QObject
{
    Q_OBJECT
public:
    explicit SQLiteUtils(QQmlEngine* engine, QObject *parent = 0);

    // [How to Reduce Your SQLite Database File Size Using Qt](http://amin-ahmadi.com/2016/05/25/sqlite-compress-qt-vacuum/)
    Q_INVOKABLE bool vacuum4qml(const QString fileName);

signals:

public slots:

private:
    QQmlEngine* qmlEngine;
};

} // namespace qyvlik
} // namespace space

#endif // SQLITEUTILS_H
