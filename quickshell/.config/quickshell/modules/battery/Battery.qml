import QtQuick

import Quickshell.Services.UPower

Item {
    id: root
    property int percentage: UPower.displayDevice.percentage * 100

    implicitWidth: batteryRing.width
    implicitHeight: batteryRing.height

    BatteryRing {
        id: batteryRing
    }

    Text {
        text: root.percentage
        font.pixelSize: 10
        font.bold: true
        color: "white"
        anchors.centerIn: batteryRing
    }

    StatusIcon {
        anchors.horizontalCenter: batteryRing.horizontalCenter
        anchors.bottom: batteryRing.bottom
        anchors.bottomMargin: -1
    }

    BatteryNotification {}
}
