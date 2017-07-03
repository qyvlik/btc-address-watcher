import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"

ScrollablePage {
    id: assetsPage

    title: "Settings"

    ColumnLayout {
        anchors.fill: parent

        Button {
            id: button
            property bool save2db: false
            text: "Start: " + save2db




            onClicked: {
                save2db = !save2db;
            }
        }
    }
}

