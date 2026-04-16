pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int barCount: 0
    property var audioLevels: []
    property bool isRunning: cavaProcess.running

    readonly property string _configPath: "/home/lulow/.config/cava/node.conf"
    property string _lastLine: ""

    // Called by AudioVisualizer once on creation to register how many bars it needs
    function setupBars(count) {
        if (count <= 0 || count === barCount)
            return;
        barCount = count;
        // Restart cava so it outputs the new bar count
        cavaProcess.running = false;
        cavaProcess.running = true;
    }

    Process {
        id: cavaProcess
        command: ["cava", "-p", root._configPath]
        // Start only when a consumer has registered a bar count
        running: root.barCount > 0

        stdout: StdioCollector {
            waitForEnd: false

            onTextChanged: {
                if (!text)
                    return;

                // Only parse the last complete line to avoid processing stale data
                const nl = text.lastIndexOf("\n", text.length - 2);
                const line = nl >= 0 ? text.slice(nl + 1).trim() : text.trim();

                if (!line || line === root._lastLine)
                    return;
                root._lastLine = line;

                const values = line.split(";");
                if (values.length < root.barCount)
                    return;

                const next = new Array(root.barCount);
                for (let i = 0; i < root.barCount; i++) {
                    const v = parseInt(values[i], 10) * 0.01;
                    // Clamp to [0, 1] without Math.min/Math.max overhead
                    next[i] = isNaN(v) ? 0 : (v > 1.0 ? 1.0 : v);
                }

                root.audioLevels = next;
            }
        }
    }

    // Guard: if the process crashes unexpectedly, restart after a short delay.
    // This timer only fires on unexpected exits, not on intentional running = false.
    Timer {
        id: restartGuard
        interval: 3000
        repeat: false
        onTriggered: {
            if (root.barCount > 0 && !cavaProcess.running)
                cavaProcess.running = true;
        }
    }

    Connections {
        target: cavaProcess
        function onRunningChanged() {
            // Only schedule a restart if the process stopped while it should be active
            if (!cavaProcess.running && root.barCount > 0)
                restartGuard.start();
            else
                restartGuard.stop();
        }
    }
}
