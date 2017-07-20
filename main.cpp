#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "src/qmlnetworkaccessmanagerfactory.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setApplicationDisplayName("btc-address-watcher");
    app.setApplicationName("btc-address-watcher");
    app.setApplicationVersion("0.0.1");
    app.setOrganizationDomain("qyvlik.space");
    app.setOrganizationName("qyvlik.space");

    QQmlApplicationEngine engine;

    engine.setNetworkAccessManagerFactory(new space::qyvlik::QmlNetworkAccessManagerFactory);
    engine.addImportPath("qrc:/qmlModules");

    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    int execResult = app.exec();

    return execResult;
}

