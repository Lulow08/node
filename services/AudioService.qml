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

    // Memory optimization: Avoid full QtObject for a simple string cache
    property string _lastLine: ""

    function setupBars(count) {
        if (count > 0 && count !== barCount) {
            barCount = count;
            cavaProcess.stop(); // Reiniciamos para que CAVA tome el nuevo conteo
            cavaProcess.start();
        }
    }

    Process {
        id: cavaProcess
        command: ["cava", "-p", root._configPath]
        running: root.barCount > 0

        stdout: StdioCollector {
            waitForEnd: false

            onTextChanged: {
                if (!text)
                    return;

                const nl = text.lastIndexOf("\n", text.length - 2);
                const line = nl >= 0 ? text.slice(nl + 1).trim() : text.trim();

                if (!line || line === root._lastLine)
                    return;
                root._lastLine = line;

                const values = line.split(";");
                if (values.length < root.barCount)
                    return;

                // JS Engine handles this lightweight array creation well enough,
                // but we optimize the math inside.
                const next = new Array(root.barCount);
                for (let i = 0; i < root.barCount; i++) {
                    // Multiplication is slightly faster than division
                    const v = parseInt(values[i], 10) * 0.01;
                    next[i] = isNaN(v) ? 0 : (v > 1.0 ? 1.0 : v); // Avoid Math.min overhead
                }

                // Re-assign to trigger QML property bindings
                root.audioLevels = next;
            }
        }
    }

    // Auto-restart
    Timer {
        interval: 3000
        running: !cavaProcess.running
        repeat: false
        onTriggered: cavaProcess.running = true
    }
}
