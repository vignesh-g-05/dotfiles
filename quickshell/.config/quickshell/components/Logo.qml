import QtQuick
import QtQuick.Layouts

Image {
    source: "root:/assets/logo.svg"
    property int size: 16

    Layout.preferredWidth: size
    Layout.preferredHeight: size

    fillMode: Image.PreserveAspectFit
}
