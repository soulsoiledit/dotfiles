pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import Quickshell.Widgets

import qs.components.shared
import qs.meta
import qs.services

// TODO: fade and slide transitions
PanelWindow { // qmllint disable uncreatable-type
    id: root

    readonly property int maxIconSize: 32
    readonly property int maxWidth: Math.floor(root.screen.width * 0.15)
    readonly property int maxHeight: Math.floor(root.screen.height * 0.25)

    implicitWidth: maxWidth
    implicitHeight: notifLayout.implicitHeight
    WlrLayershell.layer: WlrLayer.Overlay
    color: "transparent"

    anchors {
        top: true
        right: true
    }

    margins { // qmllint disable unresolved-type unqualified
        top: 8
        right: 8
    }

    ColumnLayout {
        id: notifLayout
        width: parent.width
        spacing: 8

        Repeater {
            model: ScriptModel {
                objectProp: "id"
                values: [...NotificationService.shownNotifications]
            }

            Rectangle {
                id: background

                required property Notification modelData
                required property int index

                Layout.fillWidth: true
                implicitHeight: Math.min(notifRow.implicitHeight, root.maxHeight) + 2 * notifRow.anchors.margins

                radius: 32
                color: Theme.base00
                border.color: switch (modelData.urgency) {
                case NotificationUrgency.Low:
                    return Theme.base02;
                case NotificationUrgency.Normal:
                    return Theme.accent;
                case NotificationUrgency.Critical:
                    return Theme.base08;
                }

                Timer {
                    id: hideTimer
                    running: parent.modelData?.[NotificationService.restoredKey] !== true
                    interval: {
                        if (parent.modelData?.expireTimeout >= 0) {
                            return Math.max(0, parent.modelData?.expireTimeout);
                        }

                        switch (parent.modelData?.urgency) {
                        case NotificationUrgency.Low:
                            return 2500;
                        case NotificationUrgency.Normal:
                            return 5000;
                        case NotificationUrgency.Critical:
                            return 0;
                        }
                    }

                    onTriggered: NotificationService.hideByIndex(parent.index)
                }

                TapHandler {
                    onTapped: NotificationService.invoke(parent.modelData, parent.index)
                }

                Loader {
                    id: progressBar
                    readonly property var value: parent.modelData.hints["value"]
                    active: typeof value === "number"
                    anchors.fill: parent

                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        width: Math.floor(parent.width * parent.value / 100)

                        radius: background.radius
                        color: Theme.base01
                    }
                }

                RowLayout {
                    id: notifRow
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 8

                    Loader {
                        id: icon
                        active: background.modelData?.image || background.modelData?.appIcon
                        visible: active
                        Layout.preferredHeight: Math.min(textCol.height * 1.5, root.maxIconSize)
                        Layout.preferredWidth: Layout.preferredHeight
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                        sourceComponent: IconImage {
                            anchors.fill: parent
                            source: background.modelData?.image || Quickshell.iconPath(background.modelData?.appIcon, true) || background.modelData?.appIcon
                        }
                    }

                    ColumnLayout {
                        id: textCol
                        Layout.fillWidth: true

                        QsText {
                            id: textSummary
                            Layout.fillWidth: true

                            font.bold: true
                            font.pointSize: 10
                            textFormat: Text.MarkdownText
                            wrapMode: Text.WordWrap

                            text: background.modelData?.summary
                        }

                        QsText {
                            id: textBody
                            Layout.fillWidth: true
                            visible: background.modelData?.body

                            font.pointSize: 10
                            textFormat: Text.MarkdownText
                            wrapMode: Text.WordWrap

                            text: background.modelData?.body
                        }
                    }
                }
            }
        }
    }
}
