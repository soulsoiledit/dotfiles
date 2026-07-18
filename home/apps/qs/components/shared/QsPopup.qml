import QtQuick

import Quickshell

import qs.meta

PopupWindow {
    id: root

    grabFocus: true

    implicitWidth: panel.width
    implicitHeight: panel.height
    color: "transparent"

    default property Item content
    readonly property int padding: 10

    Rectangle {
        id: panel
        implicitWidth: root.content.width + root.padding * 2
        implicitHeight: root.content.height + root.padding * 2

        color: Qt.alpha(Theme.bg0, 0.9)
        border.color: Qt.alpha(Theme.bg2, 0.9)
        radius: 4

        data: [root.content]
    }

    Component.onCompleted: {
        root.content.anchors.centerIn = panel;
    }
}
