import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"
import "../"

AppMain {
    id: app
    SwipeToPopView {
        id: swipe2pop
        width: app.width
        height: app.height
        property string title: "swipe to pop"

        Rectangle {
           border.width: 1
           border.color: "#ccc"
           Button {
               anchors.centerIn: parent
               text: "Swipe to pop"
               onClicked: {
                   swipe2pop.push(swipePageCom)
               }
           }
        }
    }

    Component {
        id: swipePageCom
        Rectangle {
            border.color: "#ccc"
            border.width: 1
            Button {
                anchors.centerIn: parent
                text: "POP"
                onClicked: {
                    swipe2pop.pop()
                }
            }
        }
    }
}
