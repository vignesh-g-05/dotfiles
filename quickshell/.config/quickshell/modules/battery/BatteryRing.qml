import QtQuick
import QtQuick.Shapes

import Quickshell.Services.UPower

Shape {
    id: root

    property real level: UPower.displayDevice.percentage
    property int percentage: level * 100
    property color backgroundColor: "white"
    property int totalSweep: 275
    property real startAngle: 135

    property color progressColor: {
        if (UPower.displayDevice.state === UPowerDeviceState.Charging)
            return "lightgreen";

        if (percentage > 70)
            return "lightgreen";

        if (percentage > 40)
            return "yellow";

        if (percentage > 20)
            return "orange";

        return "red";
    }

    anchors.centerIn: parent
    width: 26
    height: width
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
        id: backgroundRing
        strokeWidth: 3
        capStyle: ShapePath.RoundCap
        strokeColor: root.backgroundColor
        fillColor: "transparent"
        PathAngleArc {
            centerX: root.width / 2
            centerY: root.height / 2
            radiusX: (root.width - backgroundRing.strokeWidth) / 2
            radiusY: radiusX

            startAngle: root.startAngle
            sweepAngle: root.totalSweep
        }
    }

    ShapePath {
        id: progressRing
        strokeWidth: 3
        capStyle: ShapePath.RoundCap
        strokeColor: root.progressColor
        fillColor: "transparent"
        PathAngleArc {
            centerX: root.width / 2
            centerY: root.height / 2
            radiusX: (root.width - progressRing.strokeWidth) / 2
            radiusY: radiusX

            startAngle: root.startAngle
            sweepAngle: root.totalSweep * root.level
        }
    }

    Behavior on level {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }
}
