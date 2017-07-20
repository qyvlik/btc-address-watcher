#include "qmlnetworkaccessmanagerfactory.h"

#include <QNetworkAccessManager>
#include <QNetworkDiskCache>
#include <QStandardPaths>

namespace space {
namespace qyvlik {

QmlNetworkAccessManagerFactory::QmlNetworkAccessManagerFactory(qint64 maximumCacheSize):
    QQmlNetworkAccessManagerFactory(),
    mMaximumCacheSize(maximumCacheSize)
{}

QNetworkAccessManager *QmlNetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager *nam = new QNetworkAccessManager(parent);
    QNetworkDiskCache* diskCache = new QNetworkDiskCache(nam);

    QString cachePath = QStandardPaths::displayName(QStandardPaths::CacheLocation);

    diskCache->setCacheDirectory(cachePath);
    diskCache->setMaximumCacheSize(this->mMaximumCacheSize);   // 这里设置的缓存大小为 100 MB

    nam->setCache(diskCache);

    return nam;
}

} // namespace qyvlik
} // namespace space
