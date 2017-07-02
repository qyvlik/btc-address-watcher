#ifndef SPACE_QYVLIK_QMLNETWORKACCESSMANAGERFACTORY_H
#define SPACE_QYVLIK_QMLNETWORKACCESSMANAGERFACTORY_H

#include <QQmlNetworkAccessManagerFactory>

namespace space {
namespace qyvlik {

class QmlNetworkAccessManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
    QmlNetworkAccessManagerFactory(maximumCacheSize = 100 * 1024 * 1024);
    virtual QNetworkAccessManager *create(QObject *parent);
private:
    qint64 mMaximumCacheSize;
};

} // namespace qyvlik
} // namespace space

#endif // SPACE_QYVLIK_QMLNETWORKACCESSMANAGERFACTORY_H
