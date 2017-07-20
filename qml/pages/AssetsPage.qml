import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"
import "../services"

Page {
    id: assetsPage

    title: "Assets"

    Dialog {
        id: inputAddressDialog
        width: parent.width * 0.8
        standardButtons: Dialog.Ok | Dialog.Cancel
        x: (parent.width -  inputAddressDialog.width)/2
        y: (parent.height -  inputAddressDialog.height)/3

        ColumnLayout {
            id: columnLayout
            width: parent.width
            TextField {
                id: btcAddressInput
                placeholderText: "Address"
                Layout.fillWidth: true
                text: "1DzEaWjvPMKue41doV8bah21Zw1fyiQSLL"
            }
            TextField {
                id: btcAddressAliasNameInput
                placeholderText: "Alias"
                Layout.fillWidth: true
                text: "qyvlik"
            }
        }

        onAccepted: {
            blockChainService
            .saveBtcAddress(btcAddressInput.text, btcAddressAliasNameInput.text)
            .then(function(rowsAffected){
                console.log("rowsAffected:", rowsAffected)
            })
            .catch(function(error){
                console.log("error:", error)
            })
        }

        onRejected: {
            console.log("Cancel clicked")
        }
    }

    ListView {
        id: view
        anchors.fill: parent

        header: Rectangle {
            width: parent.width
            height: parent.width * 0.33

            color: "#fedefe"

            Rectangle {
                width: 48 * dp
                height: 48 * dp
                anchors.margins: 8 * dp
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                Label {
                    text: "+"
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: inputAddressDialog.open()
                }
            }
        }

        headerPositioning:  ListView.PullBackHeader

        delegate: Item {
            width: parent.width
            height: 64 * dp
            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(Math.random(), Math.random(), Math.random())
            }
        }

        clip: true

        model: ListModel {
            id: addressListModel
        }
    }
}
