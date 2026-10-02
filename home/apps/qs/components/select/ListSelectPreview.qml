pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.meta
import qs.components.shared

Select {
    id: root

    required property Component previewDelegate
    required property int listWidth

    currentIndex: list.currentIndex
    currentItem: list.currentItem

    function previous(): void {
        list.decrementCurrentIndex();
    }

    function next(): void {
        list.incrementCurrentIndex();
    }

    RowLayout {
        id: layout
        anchors.fill: parent

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
                text: root.getLabel(modelData)

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
}
