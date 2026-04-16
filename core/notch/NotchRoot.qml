import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root

    anchors.top: true

    // Temporary -> depends on the notch state
    implicitWidth: Config.notch.width
    implicitHeight: Config.notch.height

    exclusiveZone: -1
    color: "transparent"

    aboveWindows: true
    focusable: true

    WlrLayershell.namespace: "notch"

    NotchBackground {
        anchors.fill: parent
    }
}
