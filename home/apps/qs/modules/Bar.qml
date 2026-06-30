pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io

import qs.meta
import qs.components

Scope {
    PersistentProperties {
        id: persist
        property bool barsVisible: true
    }

    IpcHandler {
        target: "bar"

        function show(): void {
            persist.barsVisible = true;
        }

        function hide(): void {
            persist.barsVisible = false;
        }

        function toggle(): void {
            persist.barsVisible = !persist.barsVisible;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow { // qmllint disable uncreatable-type
            id: bar
            required property var modelData
            screen: modelData

            visible: persist.barsVisible

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
                        screen: bar.screen
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
