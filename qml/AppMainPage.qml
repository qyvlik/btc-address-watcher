import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "pages"
import "components"
import "services"

Page {

    SwipeView {
        id: view
        width: app.width
        height: app.height
        currentIndex: tabBar.currentIndex

        AssetsPage {
        }

        AppsPage {
        }

        SettingsPage {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: view.currentIndex
        TabButton {
            text: qsTr("Assets")
        }
        TabButton {
            text: qsTr("Apps")
        }
        TabButton {
            text: qsTr("Settings")
        }
    }
}
