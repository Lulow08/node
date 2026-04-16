import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

Item {
    anchors.fill: parent

    // Thumbnail
    MediaThumbnail {
        anchors.left: parent.left
        anchors.top: parent.top

        width: Config.modules.media.thumbnailSize
        height: Config.modules.media.thumbnailSize
        radius: Config.modules.media.thumbnailRadius
        thumbnail: MediaService.thumbnailUrl
    }

    // Visualizer
    AudioVisualizer {
        anchors.right: parent.right
        anchors.top: parent.top

        service: AudioService
        barCount: Config.modules.media.visualizerBarCount
        barColor: Config.modules.media.visualizerBarColor
        barWidth: Config.modules.media.visualizerBarWidth
        maxBarHeight: Config.modules.media.maxVisualizerBarHeight
        barSpacing: Config.modules.media.visualizerBarSpacing
        barSensitivity: Config.modules.media.visualizerBarSensitivity
    }

    // Initialize BottomSLot
    Component.onCompleted: {
        if (root.bottomSlot) {
            progress.parent = root.bottomSlot;
        }
    }

    // Progress bar
    ProgressBar {
        id: progress
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        barColor: Config.modules.media.progressBarColor
        barThickness: Config.modules.media.progressBarThicknessSmall
        progress: MediaService.playbackProgress
    }
}
