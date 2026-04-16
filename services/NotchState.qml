pragma Singleton
import QtQuick
import Quickshell

// Single source of truth for what the notch is showing.
// Observes services, applies priority rules, and exposes the resolved scene names.
// UI components must never decide what to display — they only react to this.
Singleton {
    id: root

    // Scene identifiers — matched against NotchStage's module registry
    readonly property var scene: ({
            None: "none",
            Media: "media"
            // Future: Notification, Call, Timer, etc.
        })

    // Primary slot: the main notch content
    property string primaryScene: scene.None

    // Secondary slot: compact concurrent activity (bubble)
    property string bubbleScene: scene.None

    // Priority order (index 0 = highest priority)
    readonly property var _priority: [
        // Scene.Call,
        // Scene.Notification,
        // Scene.Timer,
        scene.Media]

    // Active state per scene — add one entry per future scene type
    readonly property var _active: ({
            "media": Qt.binding(() => MediaService.isPlaying)
            // "timer": Qt.binding(() => TimerService.isRunning)
        })

    Connections {
        target: MediaService
        function onIsPlayingChanged() {
            root._resolve();
        }
    }

    Component.onCompleted: _resolve()

    function _resolve() {
        for (let i = 0; i < _priority.length; i++) {
            const scene = _priority[i];
            if (root._active[scene]) {
                if (root.primaryScene !== scene)
                    root.primaryScene = scene;
                return;
            }
        }
        if (root.primaryScene !== scene.None)
            root.primaryScene = scene.None;
    }
}
