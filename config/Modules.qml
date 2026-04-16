pragma Singleton
import QtQuick

QtObject {
    readonly property QtObject media: QtObject {
        // Media Thumbnail
        readonly property int thumbnailSize: Metrics.iconMedium
        readonly property int thumbnailRadius: Metrics.radiusSmall

        // Audio Visualizer
        readonly property int visualizerBarCount: 6
        readonly property color visualizerBarColor: Theme.textPrimary
        readonly property int visualizerBarWidth: 2
        readonly property int maxVisualizerBarHeight: 24
        readonly property real visualizerBarSpacing: 1.6
        readonly property real visualizerBarSensitivity: 0.8

        // Progress Bar
        readonly property color progressBarColor: Theme.textSecondary
        readonly property int progressBarThicknessSmall: 2
        readonly property int progressBarThicknessMedium: 4
    }
}
