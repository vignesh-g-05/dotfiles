import QtQuick.Layouts

import qs.components

import qs.modules.workspace

RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: 16
    anchors.verticalCenter: parent.verticalCenter

    spacing: 16
    Logo {}
    Workspace {}
}
