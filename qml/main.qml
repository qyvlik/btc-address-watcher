import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2
import QtQuick.LocalStorage 2.0

import "configs"

AppMain {

    id: app

    //    title: view.currentItem.title

    DatabaseConfig {
        id: __databaseConfig
        debug: false
    }

    readonly property alias databaseConfig : __databaseConfig
    readonly property alias stackView: __stackView

    StackView {
        id: __stackView
        anchors.fill: parent
        initialItem: AppMainPage {
            width: __stackView.width
            height: __stackView.height
        }
    }
}
