import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"

ScrollablePage {
    id: assetsPage

    title: "Settings"

    ColumnLayout {
        anchors.fill: parent

        CheckBox {
            id: checkBox
            text: 'save'
            anchors.centerIn: parent
            onCheckedChanged: {
                blockChainService.save2db = checkBox.checked
            }
        }
    }
}

