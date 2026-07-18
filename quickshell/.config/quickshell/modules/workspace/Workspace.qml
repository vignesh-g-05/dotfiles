import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 4

    Repeater {
        model: 5

        Rectangle {
            id: workspaceDot
            required property int index
            property int visibleWorkspace: ((Hyprland.focusedWorkspace.id - 1) % 5)
            color: "white"
            width: visibleWorkspace === index ? 20 : 5
            height: 5
            radius: 5

            Behavior on width {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
