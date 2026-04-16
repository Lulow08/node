pragma Singleton
import QtQuick

QtObject {
    readonly property int fast: 120
    readonly property int normal: 180
    readonly property int slow: 260

    readonly property int easingStandard: Easing.OutCubic
}
