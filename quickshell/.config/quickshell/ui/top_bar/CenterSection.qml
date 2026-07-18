import QtQuick.Layouts

import qs.modules.clock
import qs.modules.calendar

RowLayout {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    spacing: 16
    Calendar {}
    Clock {}
}
