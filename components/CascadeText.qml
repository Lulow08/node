import QtQuick

Item {
    id: root

    // Default config
    property string text: ""
    property color textColor: "white"
    property font textFont: Qt.font({
        family: "BDO Grotesk",
        pixelSize: 13,
        weight: Font.Medium
    })
    property int staggerStep: 35

    implicitWidth: layout.width
    implicitHeight: layout.height

    Row {
        id: layout
        spacing: 2

        Repeater {
            // Rebuilds only if the string length changes (e.g. "9:59" -> "10:00")
            model: root.text.length

            CascadeChar {
                character: root.text.charAt(index) || ""
                fontConfiguration: root.textFont
                color: root.textColor

                // Right-to-Left cascade calculation
                staggerDelay: (root.text.length - 1 - index) * root.staggerStep
            }
        }
    }
}
