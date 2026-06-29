import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: trayItem
            required property SystemTrayItem modelData

            visible: modelData.status !== Status.Passive
            width: icon.implicitSize
            height: width
            Layout.alignment: Qt.AlignHCenter

            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.AllButtons

            IconImage {
                id: icon
                anchors.centerIn: parent
                implicitSize: 24
                source: trayItem.modelData.icon
                backer.fillMode: Image.PreserveAspectFit
            }

            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.MiddleButton:
                    trayItem.modelData.activate();
                    break;
                default:
                    menuAnchor.open();
                    break;
                }
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: trayItem.modelData.menu // qmllint disable unresolved-type
                anchor.item: trayItem
            }
        }
    }
}
