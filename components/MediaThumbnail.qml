import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import qs.config

Item {
    id: root

    // Default config
    property string thumbnail: ""
    property int size: Config.metrics.iconMedium
    property int radius: 6

    width: size
    height: size

    property string _activeUrl: ""
    property string _pendingUrl: ""
    property bool _isInitialized: false

    onThumbnailChanged: {
        if (!_isInitialized) {
            _activeUrl = thumbnail;
            _isInitialized = true;
            return;
        }
        if (thumbnail === _activeUrl)
            return;
        _pendingUrl = thumbnail;
    }

    // Preloader
    Image {
        id: imgPreload
        width: 1
        height: 1
        visible: false
        source: root._pendingUrl
        sourceSize.width: root.size
        sourceSize.height: root.size
        asynchronous: true
        cache: true

        onStatusChanged: {
            if (status === Image.Ready && root._pendingUrl !== "" && !transitionAnimation.running) {
                transitionAnimation.restart();
            }
        }
    }

    ClippingWrapperRectangle {
        id: wrapper
        anchors.fill: parent
        radius: root.radius
        color: "#1E1E1E"
        layer.enabled: true
        visible: false

        Image {
            anchors.fill: parent
            source: root._activeUrl
            sourceSize.width: root.size
            sourceSize.height: root.size
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true
        }
    }

    MultiEffect {
        id: blurEffect
        source: wrapper
        anchors.fill: wrapper
        blurEnabled: blur > 0
        maskEnabled: blur > 0
        maskSource: wrapper
        blurMax: 18
        blur: 0.0
        brightness: 0.0
    }

    transform: Scale {
        id: flipScale
        origin.x: root.width / 2
        origin.y: root.height / 2
        xScale: 1.0
    }

    SequentialAnimation {
        id: transitionAnimation

        // PHASE 1: Squeeze to center and blur
        ParallelAnimation {
            NumberAnimation {
                target: flipScale
                property: "xScale"
                to: 0.0
                duration: 300
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: blurEffect
                property: "blur"
                to: 1.0
                duration: 250
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: blurEffect
                property: "brightness"
                to: 0.1
                duration: 300
                easing.type: Easing.InCubic
            }
        }

        // PHASE 2: Invisible swap
        PropertyAction {
            target: root
            property: "_activeUrl"
            value: root._pendingUrl
        }

        // PHASE 3: Normalize
        ParallelAnimation {
            NumberAnimation {
                target: flipScale
                property: "xScale"
                to: 1.0
                duration: 400
                easing.type: Easing.OutBack
                easing.overshoot: 1.12
            }
            NumberAnimation {
                target: blurEffect
                property: "blur"
                to: 0.0
                duration: 500
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: blurEffect
                property: "brightness"
                to: 0.0
                duration: 400
                easing.type: Easing.OutQuad
            }
        }
    }
}
