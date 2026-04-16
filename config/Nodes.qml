pragma Singleton
import QtQuick

QtObject {
    readonly property QtObject clock: QtObject {
        readonly property string fontFamily: Theme.fontPrimary
        readonly property int fontSize: Theme.fontSizePrimary
        readonly property int fontWeight: Font.DemiBold
        readonly property real letterSpacing: -2.4
        readonly property int staggerStep: 35
    }
}
