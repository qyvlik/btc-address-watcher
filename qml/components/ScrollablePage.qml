//~ ScrollablePage.qml
import QtQuick 2.8
import QtQuick.Controls 2.1

Page {
    id: page

    default property alias content: __pane.contentItem

    readonly property alias pane: __pane

    Flickable {
        anchors.fill: parent
        contentWidth: __pane.width
        contentHeight: __pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: __pane
            width: page.width
            background: Item { }            // for transparent background
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
