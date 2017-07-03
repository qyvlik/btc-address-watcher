import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2
import QtQuick.LocalStorage 2.0

import "configs"
import "services"

import space.qyvlik.utils 1.0           // import PromiseLib

AppMain {

    id: app

    //    title: view.currentItem.title

    DatabaseConfig {
        id: __databaseConfig
        debug: false
    }


    BlockChainService {
        id: __blockChainService
        active: false
    }

    readonly property alias databaseConfig : __databaseConfig
    readonly property alias stackView: __stackView
    readonly property alias blockChainService: __blockChainService

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
        var Promise = PromiseLib.Promise;

        var p = new Promise(function(resolve, reject){
            console.log("here is promise!");
            lazyer.lazyDo(1000, function(){
                resolve("good");
            })
        }).then(function(value){
            console.log("value:", value);
        });
    }

}
