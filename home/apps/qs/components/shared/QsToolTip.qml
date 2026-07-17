pragma ComponentBehavior: Bound

import QtQuick

import Quickshell

import qs.meta

HoverHandler {
    id: root

    required property string text
    readonly property int padding: 10

    property LazyLoader popup: LazyLoader {
        activeAsync: root.hovered

        PopupWindow {
            id: popup
            visible: true

            anchor.item: root.target
            anchor.rect.x: root.target.width / 2
            anchor.rect.y: root.target.height

            implicitWidth: tooltipText.width + root.padding * 2
            implicitHeight: tooltipText.height + root.padding * 2

            color: "transparent"

            Rectangle {
                id: back
                anchors.fill: parent
                color: Qt.alpha(Theme.bg0, 0.9)
                border.color: Qt.alpha(Theme.bg2, 0.9)
                radius: 4

                QsText {
                    id: tooltipText
                    anchors.centerIn: parent
                    font.pointSize: 10
                    color: Theme.fg0
                    text: root.text
                }
            }
        }
    }
}
