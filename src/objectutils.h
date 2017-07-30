#ifndef DEBUGOBJECT_H
#define DEBUGOBJECT_H

#include <QObject>

class QQmlApplicationEngine;

namespace space {
namespace qyvlik {

class ObjectUtils : public QObject
{
    Q_OBJECT
public:
    explicit ObjectUtils(QObject *parent = 0);

    Q_INVOKABLE void debugQObject(QObject* obj);

   static QObject* findClindByObjectNameFromQmlEngine(QQmlApplicationEngine* qmlEngine, QString objectName);

signals:

public slots:
private:
    QQmlApplicationEngine* engine;
};

} // namespace qyvlik
} // namespace space

#endif // DEBUGOBJECT_H
