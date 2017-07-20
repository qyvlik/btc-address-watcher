import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import space.qyvlik.utils 1.0

Page {
    id: assetsPage

    title: "Apps"

    GridView {
        anchors.fill: parent
        model: 16
        delegate: Item {
            width: 64* dp
            height: 64 * dp
            Rectangle {
                anchors.fill: parent
                color: Utility.randomColor()
            }
        }
    }

}
