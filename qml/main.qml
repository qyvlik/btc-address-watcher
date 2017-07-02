import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "pages"

AppMain {

    id: app

    SwipeView {
        id: view
        width: app.width
        height: app.height

        AssetsPage {
            width: app.width
            height: app.height
        }

        Page {
            width: app.width
            height: app.height
            background: Rectangle {
                color: "yellow"
            }
        }

        Rectangle {
            color: "green"
            width: app.width
            height: app.height
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
