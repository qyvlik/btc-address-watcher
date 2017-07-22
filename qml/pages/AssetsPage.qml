import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"
import "../services"

import space.qyvlik.utils 1.0

Page {
    id: assetsPage

    title: "Assets"

    ListenBtcAddressService {
        id: listenBtcAddressService
        connection: databaseConfig
    }

    function saveBtcAddress(address, aliasName) {
        return listenBtcAddressService.saveBtcAddress(address, aliasName);
    }

    function findAllAddressList() {
        var Promise = PromiseLib.Promise;
        return new Promise(function(resolve, reject){
            listenBtcAddressService.findList({}, resolve);
        });
    }

    Dialog {
        id: deleteAddressDialog
        width: parent.width * 0.8
        standardButtons: Dialog.Ok | Dialog.Cancel
        x: (parent.width -  inputAddressDialog.width)/2
        y: (parent.height -  inputAddressDialog.height)/3

        title: "delete " + address

        property string address
        onAccepted: {
            var p = listenBtcAddressService.deleteAddress(address)
            p.then(function(effectCount){
                console.log('delete address:', address, effectCount);
                deleteAddressDialog.address = '';
                refreshAddressList();
            })
        }

        onRejected: {
            deleteAddressDialog.address = ''
        }

        function open4Address(address) {
            deleteAddressDialog.address = address;
            deleteAddressDialog.open();
        }
    }

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
            saveBtcAddress(btcAddressInput.text, btcAddressAliasNameInput.text)
            .then(function(rowsAffected){
                console.log("save address:", btcAddressInput.text, rowsAffected);
                refreshAddressList();
            })
            .catch(function(error){
                console.log("error:", error)
            })
        }

        onRejected: {
            console.log("cancel save btc address")
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
                // color: Qt.rgba(Math.random(), Math.random(), Math.random())

                Label {
                    width: parent.width
                    anchors.centerIn: parent
                    text: address
                }

                MouseArea {
                    anchors.fill: parent
                    onPressAndHold: {
                        deleteAddressDialog.open4Address(address);
                    }
                }
            }
        }

        clip: true

        model: ListModel {
            id: addressListModel
        }
    }

    function refreshAddressList() {
        var p = findAllAddressList();
        p.then(function(list){
            addressListModel.clear();
            for(var iter in list) {
                addressListModel.append(list[iter]);
            }
        });
    }

    Component.onCompleted: {
        refreshAddressList();
    }
}
