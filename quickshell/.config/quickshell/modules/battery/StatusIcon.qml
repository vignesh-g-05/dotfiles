import Quickshell.Services.UPower

import qs.components

Icon {
    property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
    property bool isCritical: UPower.displayDevice.percentage * 100 < 20

    name: isCharging ? "zap" : "fire"
    visible: isCharging || isCritical
    size: 8
}
