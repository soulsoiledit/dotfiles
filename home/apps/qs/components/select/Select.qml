import QtQuick

FocusScope {
    id: root

    required property var model
    required property int currentIndex
    required property var currentItem
    readonly property var currentData: currentItem?.modelData // qmllint disable missing-property

    required property var getLabel

    signal itemActivated(var modelData)

    function activateSelected(): void {
        itemActivated(currentData);
    }

    function previous(): void {
    }

    function next(): void {
    }
}
