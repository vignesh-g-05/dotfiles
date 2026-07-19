import QtQuick
import QtQuick.Layouts

Image {
    required property string name
    property int size: 16

    source: `root:/assets/icons/${name}`

    Layout.preferredWidth: size
    Layout.preferredHeight: size
    height: size
    width: size

    fillMode: Image.PreserveAspectFit
}
