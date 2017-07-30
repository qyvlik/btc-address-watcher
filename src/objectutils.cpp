#include "objectutils.h"

#include <QDebug>
#include <QQmlApplicationEngine>

namespace space {
namespace qyvlik {

ObjectUtils::ObjectUtils(QObject *parent) : QObject(parent)
{

}

void ObjectUtils::debugQObject(QObject *obj) {
    if (obj == Q_NULLPTR) {
        qDebug() << obj;
        return;
    }

    qDebug() << obj << ", parent: " << obj->parent();
}

QObject *ObjectUtils::findClindByObjectNameFromQmlEngine(QQmlApplicationEngine *qmlEngine, QString objectName)
{
    if (qmlEngine == Q_NULLPTR) {
        return Q_NULLPTR;
    }

    QList<QObject*> rootObjects = qmlEngine->rootObjects();
    QObject* child = Q_NULLPTR;

    foreach (QObject* iter, rootObjects) {
        if (iter->inherits("QQuickItem")) {
            child = iter->findChild<QObject*>(objectName);
            break;
        }

        child = iter->findChild<QObject*>(objectName);
        if (child != Q_NULLPTR) {
            break;
        }

        QObject* contentItem = iter->property("contentItem").value<QObject*>();
        if (contentItem != Q_NULLPTR) {
            child = contentItem->findChild<QObject*>(objectName);
            break;
        }
    }
    return child;
}

} // namespace qyvlik
} // namespace space
