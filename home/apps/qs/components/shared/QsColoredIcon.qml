import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import Quickshell

Item {
    id: root

    required property int size
    required property string name
    required property color color

    Layout.alignment: Qt.AlignHCenter

    width: size
    height: implicitWidth

    Image {
        id: icon
        visible: false
        anchors.fill: parent
        source: Quickshell.iconPath(root.name)
        fillMode: Image.PreserveAspectCrop
    }

    MultiEffect {
        id: iconWhite
        visible: false
        source: icon
        anchors.fill: icon
        brightness: 1.0
    }

    MultiEffect {
        id: iconColor
        source: iconWhite
        anchors.fill: iconWhite
        colorization: 1.0
        colorizationColor: root.color
    }
}
