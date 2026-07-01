import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter

    Repeater {
        model: SystemTray.items

        IconImage {
            id: trayItem

            required property SystemTrayItem modelData

            visible: modelData.status !== Status.Passive
            implicitSize: 24
            source: modelData.icon
            backer.fillMode: Image.PreserveAspectFit

            Layout.alignment: Qt.AlignHCenter

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                acceptedButtons: Qt.AllButtons
                onTapped: (_, button) => {
                    switch (button) {
                    case Qt.MiddleButton:
                        trayItem.modelData.activate();
                        break;
                    default:
                        menuAnchor.open();
                        break;
                    }
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
