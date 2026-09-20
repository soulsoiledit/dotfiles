pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.meta
import qs.components.shared

GridView {
    id: root

    required property var getIcon
    required property var getText

    readonly property var currentData: currentItem?.modelData // qmllint disable missing-property
    signal itemActivated(var modelData)

    function activateSelected() {
        itemActivated(currentData);
    }

    function previous() {
        moveCurrentIndexLeft();
    }

    function next() {
        moveCurrentIndexRight();
    }

    cellHeight: cellWidth
    clip: true

    highlightMoveDuration: 50
    highlight: Rectangle {
        radius: 32
        color: Theme.base01
    }

    delegate: ColumnLayout {
        width: root.cellWidth
        height: root.cellHeight

        required property var modelData
        required property int index

        spacing: 8

        IconImage {
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: parent.height * 0.5
            Layout.topMargin: 8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            source: Quickshell.iconPath(root.getIcon(parent.modelData))
            implicitSize: Math.floor(Math.min(parent.width, parent.height) * 0.5)
            asynchronous: true
        }

        QsText {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: Layout.leftMargin
            Layout.bottomMargin: 8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            font.pointSize: 10
            padding: 0
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignBottom

            maximumLineCount: 2
            wrapMode: Text.WordWrap
            elide: Text.ElideRight

            text: root.getText(parent.modelData)
            QsToolTip {
                text: parent.text
            }
        }

        TapHandler {
            onTapped: root.itemActivated(parent.modelData)
        }

        HoverHandler {
            onHoveredChanged: if (hovered) {
                root.currentIndex = parent.index;
            }
        }
    }
}
