import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"
import "../"

AppMain {


    id: app

    SwipeView {
        id: view
        width: app.width
        height: app.height

        ScrollablePage {

            Item {
                id: root
                width: app.width
                height: app.height
                Label {
                    // Pane Content Sizing
                    anchors.centerIn: parent
                    text: "app:(" + app.width +"," + app.height + ")"
                          + "\n" + "root:(" + root.width + "," + root.height + ")"
                }
            }
        }
    }

}
