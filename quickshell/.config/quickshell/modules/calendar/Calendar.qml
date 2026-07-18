import QtQuick
import Quickshell

Item {
    implicitHeight: childrenRect.height
    implicitWidth: childrenRect.width
    Text {
        text: Qt.formatDate(clock.date, "dd MMM")
        color: "white"
    }
    SystemClock {
        id: clock
    }
}
