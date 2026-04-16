import QtQuick
import qs.config

// Visual shell of the notch: background, border, shape.
// Contains NotchStage but does not control its internals.
Rectangle {
    id: root

    radius: Config.metrics.radiusMedium
    color: Config.theme.backgroundPrimary
    border.color: Config.theme.borderSubtle
    border.width: Config.metrics.borderThin

    NotchStage {
        anchors {
            fill: parent
            margins: Config.notch.padding
            // Give the bottom slot its own inset so it sits flush with the border
            bottomMargin: Config.metrics.borderThin
        }
    }
}
