import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.components

PanelWindow {
    id: root

    anchors.top: true
    implicitWidth: Screen.width

    implicitHeight: Config.notch.height
    exclusiveZone: Config.notch.height

    color: "transparent"
    focusable: true

    GridLayout {
        anchors.fill: parent
        columns: 3
        columnSpacing: 0

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            LeadNodes {
                anchors.left: parent.left
            }
        }

        Item {
            Layout.preferredWidth: Config.notch.width
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TrailNodes {
                anchors.right: parent.right
            }
        }
    }
}
