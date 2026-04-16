pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property string format: "hh:mm AP"
    property string currentTimeString: ""

    // Cached regex for stripping AM/PM
    readonly property var _amPmRegex: /\s?[aApP][mM]/

    property Timer clockTimer: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: updateTime()
    }

    function updateTime() {
        let timeRaw = Qt.formatTime(new Date(), root.format);
        root.currentTimeString = timeRaw.replace(_amPmRegex, "").trim();
    }

    Component.onCompleted: updateTime()
}
