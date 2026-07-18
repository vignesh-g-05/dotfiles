import Quickshell

import QtQuick

Item {
    implicitHeight: childrenRect.height
    implicitWidth: childrenRect.width
    Text {
        text: Qt.formatTime(clock.date, "hh:mm A")
        color: "white"
    }
    SystemClock {
        id: clock
    }
}
