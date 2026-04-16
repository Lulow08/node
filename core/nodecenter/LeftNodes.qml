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

    // Left (Mocks)
    Text {
        text: "􀸙"
        font.pixelSize: 14
        font.family: "SF Pro"
        color: "white"
    }

    Row {
        spacing: 6

        Text {
            text: "􀀁"
            font.pixelSize: 6
            font.family: "SF Pro"
            color: "#888888"
        }

        Text {
            text: "􀀁"
            font.pixelSize: 6
            font.family: "SF Pro"
            color: "#888888"
        }

        Text {
            text: "􀀁"
            font.pixelSize: 6
            font.family: "SF Pro"
            color: "#888888"
        }

        Text {
            text: "􀀁"
            font.pixelSize: 6
            font.family: "SF Pro"
            color: "#888888"
        }
    }

    // Spacer
    Item {
        Layout.fillWidth: true
    }

    // Right
    DigitalText {
        text: ClockService.currentTimeString
        textColor: Config.theme.textPrimary
        textFont: Qt.font({
            family: Config.nodes.clock.fontFamiliy,
            pixelSize: Config.nodes.clock.fontSize,
            weight: Config.nodes.clock.fontWeight,
            letterSpacing: Config.nodes.clock.letterSpacing
        })
        staggerStep: Config.nodes.clock.staggerStep

        Layout.alignment: Qt.AlignVCenter
    }
}
