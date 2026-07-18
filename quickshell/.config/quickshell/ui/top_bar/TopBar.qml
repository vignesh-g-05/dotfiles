import QtQuick
import Quickshell

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: 16
        left: 16
        right: 16
    }

    implicitHeight: 40

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: "#222"

        LeftSection {}
        CenterSection {}
        RightSection {}
    }
}
