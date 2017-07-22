import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"

ScrollablePage {
    id: assetsPage

    title: "Settings"

    property var d: Dialog {
        id: dialog
        width: assetsPage.width * 0.8
        standardButtons: Dialog.Ok | Dialog.Cancel
        x: (assetsPage.width -  dialog.width)/2
        y: (assetsPage.height -  dialog.height)/3

        title: "delete tx data"

        onAccepted: {
            var p = blockChainService.deleteAllTx();
            p.then(function(effectCount){
                console.log("delete all tx :", effectCount);
            });


            try {
                SqliteUtils.vacuum4qml(Qt.md5(databaseConfig.identifier));
            } catch(e) {
                console.log("e:", e)
            }
        }

        onRejected: {

        }
    }

    ColumnLayout {
        anchors.fill: parent

        CheckBox {
            id: checkBox
            text: 'save tx to db'
            onCheckedChanged: {
                blockChainService.save2db = checkBox.checked
            }
        }

        Button {
            text: "delete all tx data"
            onClicked: {
                dialog.open()
            }
        }




    }
}

