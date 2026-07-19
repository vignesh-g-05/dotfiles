import QtQuick
import Quickshell.Services.UPower
import Quickshell.Io

Item {
    id: root
    property int batteryLevel: UPower.displayDevice.percentage * 100
    property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
    property int nextAlertLevel: 20

    onBatteryLevelChanged: {
        if (batteryLevel > 20 || isCharging) {
            nextAlertLevel = 20;
            return;
        }
        switch (nextAlertLevel) {
        case 20:
            nextAlertLevel = 15;
            break;
        case 15:
            nextAlertLevel = 10;
            break;
        case 10:
            nextAlertLevel = 5;
            break;
        case 5:
            nextAlertLevel = 2;
            break;
        case 2:
            nextAlertLevel = -1;
            break;
        }
    }

    Process {
        id: notificationProcess
        command: ["notify-send", "-i", "battery-caution", "-u", "critical", "Battery Low", `Battery is at ${root.batteryLevel}%`]
    }
}
