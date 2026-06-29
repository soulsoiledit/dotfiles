import QtQuick
import QtQuick.Controls

import qs.meta

ToolTip {
    id: root
    popupType: ToolTip.Window

    x: parent.width / 2
    y: parent.height / 2 + 4
    padding: 10

    background: Rectangle {
        color: Qt.alpha(Theme.bg0, 0.9)
        border.color: Qt.alpha(Theme.bg2, 0.9)
        radius: 4
    }

    contentItem: QsText {
        font.pointSize: 10
        color: Theme.fg0
        text: root.text
    }
}
