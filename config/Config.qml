pragma Singleton
import QtQuick

QtObject {
    readonly property var theme: Theme
    readonly property var metrics: Metrics
    readonly property var modules: Modules
    readonly property var nodes: Nodes
    readonly property var notch: Notch
    readonly property var animations: Animations
}
