import QtQuick
import qs.modules

Item {
    id: root

    property Component currentComponent
    property Component nextComponent

    function setModule(component) {
        if (currentLoader.sourceComponent === component)
            return

        nextComponent = component
        transition.start()
    }

    Loader {
        id: currentLoader
        anchors.fill: parent
        // Temporal
        sourceComponent: MediaModule {}
    }

    Loader {
        id: nextLoader
        anchors.fill: parent
        opacity: 0
    }

    SequentialAnimation {
        id: transition

        ScriptAction {
            script: {
                nextLoader.sourceComponent = nextComponent
            }
        }

        ParallelAnimation {
            NumberAnimation { target: currentLoader; property: "opacity"; to: 0; duration: 120 }
            NumberAnimation { target: nextLoader; property: "opacity"; to: 1; duration: 160 }
            NumberAnimation { target: currentLoader; property: "scale"; to: 0.96; duration: 120 }
            NumberAnimation { target: nextLoader; property: "scale"; from: 0.96; to: 1; duration: 160 }
        }

        ScriptAction {
            script: {
                currentLoader.sourceComponent = nextComponent
                currentLoader.opacity = 1
                currentLoader.scale = 1

                nextLoader.sourceComponent = null
                nextLoader.opacity = 0
            }
        }
    }
}
