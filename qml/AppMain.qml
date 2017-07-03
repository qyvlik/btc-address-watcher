import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2
import QtQuick.Window 2.0

ApplicationWindow {
    visible: true

    width: 360 * dp
    height: 640 * dp

    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)
}
