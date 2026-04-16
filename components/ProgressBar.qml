import QtQuick

Item {
    id: root

    // Default config
    property real progress: 0.0
    property color barColor: "#888888"
    property int barThickness: 2
    property int barRadius: barThickness / 2

    implicitHeight: barThickness
    implicitWidth: parent.width

    Rectangle {
        width: parent.width * Math.min(1, Math.max(0, root.progress))
        height: parent.height
        radius: root.barRadius
        color: root.barColor

        Behavior on width {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutBack
            }
        }
    }
}
