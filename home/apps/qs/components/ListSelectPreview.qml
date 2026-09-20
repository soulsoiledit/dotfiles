pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.meta
import qs.components.shared

RowLayout {
    id: root

    required property var model
    required property var getListText
    required property Component previewDelegate
    required property int listWidth

    property alias currentIndex: list.currentIndex
    readonly property alias currentItem: list.currentItem
    readonly property var currentData: currentItem?.modelData // qmllint disable missing-property

    signal itemActivated(var modelData)

    function activateSelected() {
        itemActivated(currentData);
    }

    function previous() {
        list.decrementCurrentIndex();
    }

    function next() {
        list.incrementCurrentIndex();
    }

    spacing: 16

    ListView {
        id: list

        Layout.preferredWidth: root.listWidth
        Layout.fillHeight: true

        model: root.model
        spacing: 8

        clip: true

        highlightMoveDuration: 50
        highlight: Rectangle {
            color: Theme.base01
            radius: 32
        }

        delegate: QsText {
            required property var modelData
            required property var index

            width: list.width
            padding: 8
            elide: Text.ElideRight

            textFormat: Text.PlainText
            text: root.getListText(modelData)

            TapHandler {
                onTapped: root.itemActivated(parent.modelData)
            }

            HoverHandler {
                onHoveredChanged: if (hovered) {
                    list.currentIndex = parent.index;
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Theme.base01
        radius: 32

        Loader {
            anchors.fill: parent
            clip: true
            sourceComponent: root.previewDelegate
        }
    }
}
