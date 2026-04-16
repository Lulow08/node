import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs.services

RowLayout {
    spacing: 8

    anchors {
        fill: parent
        leftMargin: 16
        rightMargin: 16
    }

    // Built once; Qt.font({}) in a binding expression allocates on every evaluation
    readonly property font _clockFont: Qt.font({
        family: Config.nodes.clock.fontFamily,
        pixelSize: Config.nodes.clock.fontSize,
        weight: Config.nodes.clock.fontWeight,
        letterSpacing: Config.nodes.clock.letterSpacing
    })

    // Left (Mocks)
    Text {
        text: "􀸙"
        font.pixelSize: 14
        font.family: "SF Pro"
        color: Config.theme.textPrimary
    }

    Row {
        spacing: 6
        Repeater {
            model: 4
            Text {
                text: "􀀁"
                font.pixelSize: 6
                font.family: "SF Pro"
                color: Config.theme.textSecondary
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }

    CascadeText {
        text: ClockService.currentTimeString
        textColor: Config.theme.textPrimary
        textFont: parent._clockFont
        staggerStep: Config.nodes.clock.staggerStep

        Layout.alignment: Qt.AlignVCenter
    }
}
