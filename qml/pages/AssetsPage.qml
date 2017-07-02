import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"

Page {
    id: assetsPage

    title: "Assets"


    ListView {
        id: view
        anchors.fill: parent

        header: Item {
            width: parent.width
            height: parent.width * 0.66
//            Rectangle {
//                anchors.fill: parent
//                color: "green"
//            }

            Label {
                anchors.centerIn: parent
                text: "Assets: " + 100 + "ETH"
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

        model: 5

    }

    Item {
        id: headerItem
        anchors.top: parent.top
        width: parent.width
        height: 48 * dp

        Rectangle {
            anchors.fill: parent
            color: "red"

            // opacity: (view.contentY + headerItem.height>0) ? 1 : 0.1
            opacity: 0.1
            Label {
                anchors.centerIn: parent
                text: view.contentY + headerItem.height
            }

        }
    }

}
