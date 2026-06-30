import QtQuick

import Quickshell

import qs.meta

PopupWindow {
    id: root

    required property Item target
    required property bool targetHovered
    required property string text
    readonly property int padding: 10

    visible: targetHovered

    anchor.item: target
    anchor.rect.x: target.width / 2
    anchor.rect.y: target.height

    implicitWidth: text.width + root.padding * 2
    implicitHeight: text.height + root.padding * 2

    color: "transparent"

    Rectangle {
        id: back
        anchors.fill: parent
        color: Qt.alpha(Theme.bg0, 0.9)
        border.color: Qt.alpha(Theme.bg2, 0.9)
        radius: 4

        QsText {
            id: text
            anchors.centerIn: parent
            font.pointSize: 10
            color: Theme.fg0
            text: root.text
        }
    }
}
