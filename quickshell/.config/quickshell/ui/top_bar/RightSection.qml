import QtQuick.Layouts

import qs.modules.network
import qs.modules.control_center
import qs.modules.notification
import qs.modules.power_options

RowLayout {
    anchors.right: parent.right
    anchors.rightMargin: 16
    anchors.verticalCenter: parent.verticalCenter

    spacing: 16
    Network {}
    ControlCenter {}
    Notification {}
    PowerOptions {}
}
