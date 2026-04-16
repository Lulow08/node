import QtQuick
import qs.services

// Secondary activity overlay — renders a compact indicator alongside the primary module.
// Intended for concurrent low-priority activities (e.g., a timer ticking while media plays).
//
// Usage (future):
//   Driven by NotchState.bubbleScene or similar.
//   Should remain visually minimal: icon, no interactive elements.
//   Positioned by NotchRoot based on notch expansion state.
Item {
    id: root

    visible: NotchState.bubbleScene !== NotchState.bubbleScene.None
    // Content will be added when bubble activities are implemented
}
