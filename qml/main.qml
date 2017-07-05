import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2
import QtQuick.LocalStorage 2.0

import "configs"
import "services"

import space.qyvlik.utils 1.0           // import PromiseLib
import space.qyvlik.sqml 1.0

AppMain {

    id: app

    //    title: view.currentItem.title

    DatabaseConfig {
        id: __databaseConfig
        debug: false
    }


    Component {
        id: blockChainServiceCom
        BlockChainService {
            active: true
        }
    }

    readonly property alias databaseConfig : __databaseConfig
    readonly property alias stackView: __stackView
    readonly property alias blockChainService: app.__blockChainService

    property BlockChainService __blockChainService

    StackView {
        id: __stackView
        anchors.fill: parent
        initialItem: AppMainPage {
            width: __stackView.width
            height: __stackView.height
        }
    }

    Lazyer {
        id: lazyer
    }


    Component.onCompleted: {
        lazyer.lazyDo(500, function(){
            app.__blockChainService = blockChainServiceCom.createObject(app);
            console.info("createObject blockChainService:", app.__blockChainService);
        });
    }
}
