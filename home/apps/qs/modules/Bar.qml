import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.meta
import qs.components

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow { // qmllint disable uncreatable-type
            id: root
            required property var modelData
            screen: modelData

            anchors {
                top: true
                bottom: true
                left: true
            }

            implicitWidth: columns.implicitWidth + 16

            color: Theme.bg0

            ColumnLayout {
                id: columns
                uniformCellSizes: true

                anchors {
                    fill: parent
                    topMargin: 4
                    bottomMargin: columns.anchors.topMargin - 4
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

                    WorkspaceWidget {
                        screen: root.screen
                    }
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                    ClockWidget {}
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
                    spacing: 2

                    HeatWidget {}
                    RamWidget {}
                    VolumeWidget {}
                    BatteryWidget {}
                    TrayWidget {
                        spacing: parent.spacing
                    }
                }
            }
        }
    }
}
