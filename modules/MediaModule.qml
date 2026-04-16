import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

// Displays media state: thumbnail, audio visualizer, and playback progress.
// bottomTarget: Item — receives the ProgressBar as a reparented child so it
// can be positioned outside the main content area (e.g., flush with the notch border).
Item {
    id: root

    // Explicit injection point for bottom-edge elements.
    // Set by NotchContentHost; never inferred from the visual tree.
    property Item bottomTarget: null

    anchors.fill: parent

    MediaThumbnail {
        anchors {
            left: parent.left
            top: parent.top
        }
        width: Config.modules.media.thumbnailSize
        height: Config.modules.media.thumbnailSize
        radius: Config.modules.media.thumbnailRadius
        thumbnail: MediaService.thumbnailUrl
    }

    AudioVisualizer {
        anchors {
            right: parent.right
            top: parent.top
        }
        service: AudioService
        barCount: Config.modules.media.visualizerBarCount
        barColor: Config.modules.media.visualizerBarColor
        barWidth: Config.modules.media.visualizerBarWidth
        maxBarHeight: Config.modules.media.maxVisualizerBarHeight
        barSpacing: Config.modules.media.visualizerBarSpacing
        barSensitivity: Config.modules.media.visualizerBarSensitivity
    }

    // ProgressBar lives in the bottom slot — reparented after the target is ready
    ProgressBar {
        id: progressBar
        barColor: Config.modules.media.progressBarColor
        barThickness: Config.modules.media.progressBarThicknessSmall
        progress: MediaService.playbackProgress
    }

    // Reparent once we have a valid target; clean up when this module is destroyed
    Component.onCompleted: {
        if (root.bottomTarget) {
            progressBar.parent = root.bottomTarget;
            progressBar.anchors.left  = root.bottomTarget.left;
            progressBar.anchors.right = root.bottomTarget.right;
        }
    }

    Component.onDestruction: {
        // Prevent a dangling item in the bottom slot after this module unloads
        if (progressBar.parent === root.bottomTarget)
            progressBar.parent = null;
    }
}
