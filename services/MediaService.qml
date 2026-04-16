pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string thumbnailUrl: ""
    property real playbackProgress: 0.0
    property string title: ""
    property string artist: ""
    property bool isPlaying: false

    // Cached regex for performance
    readonly property var _ytWatchRegex: /[?&]v=([a-zA-Z0-9_-]{11})/
    readonly property var _ytShortRegex: /youtu\.be\/([a-zA-Z0-9_-]{11})/

    // Persistent metadata process
    Process {
        id: metaProcess
        command: ["playerctl", "metadata", "--follow", "--format", "{{status}}~|~{{title}}~|~{{artist}}~|~{{mpris:artUrl}}~|~{{position}}~|~{{mpris:length}}~|~{{xesam:url}}"]
        running: true

        stdout: StdioCollector {
            waitForEnd: false

            onTextChanged: {
                if (!text)
                    return;

                const lines = text.trim().split("\n");
                const last = lines[lines.length - 1].trim();

                if (!last)
                    return;

                const p = last.split("~|~");
                if (p.length < 7)
                    return;

                root.isPlaying = p[0] === "Playing";
                root.title = p[1];
                root.artist = p[2];

                let artUrl = p[3];
                const pos = parseFloat(p[4]);
                const len = parseFloat(p[5]);
                const xesamUrl = p[6];

                if (xesamUrl.includes("youtube.com") || xesamUrl.includes("youtu.be")) {
                    let videoId = null;
                    const watchMatch = xesamUrl.match(root._ytWatchRegex);

                    if (watchMatch) {
                        videoId = watchMatch[1];
                    } else {
                        const shortMatch = xesamUrl.match(root._ytShortRegex);
                        if (shortMatch)
                            videoId = shortMatch[1];
                    }

                    if (videoId) {
                        artUrl = `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`;
                    }
                }

                if (root.thumbnailUrl !== artUrl) {
                    root.thumbnailUrl = artUrl;
                }

                root.playbackProgress = (len > 0 && !isNaN(pos)) ? Math.min(1, pos / len) : 0.0;
            }
        }
    }

    Timer {
        interval: 4000
        running: !metaProcess.running
        repeat: false
        onTriggered: metaProcess.running = true
    }
}
