import QtQuick
import qs.config

Rectangle {
    id: root

    radius: Config.metrics.radiusMedium

    color: Config.theme.backgroundPrimary
    border.color: Config.theme.borderSubtle
    border.width: Config.metrics.borderThin

    Item {
        id: contentArea
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: Config.notch.padding
        }
        anchors.bottom: bottom.top
    }

    Item {
        id: bottomSlot
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: Config.notch.padding
            rightMargin: Config.notch.padding
            bottomMargin: Config.metrics.borderThin
        }
        height: implicitHeight
    }

    NotchContentHost {
        anchors.fill: contentArea
        property Item bottomSlot: bottomSlot
    }
}
