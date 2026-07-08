pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland

import qs.meta
import qs.services
import qs.components.shared

Scope {
    id: root

    property string currentText: ""
    property bool showPassword: false
    property bool falseLocked: false

    WlSessionLock {
        id: lock

        WlSessionLockSurface {
            id: lockSurface
            color: "transparent"

            Image {
                id: wallpaper
                source: WallpaperService.path
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                visible: status === Image.Ready

                layer.enabled: true
                layer.effect: MultiEffect {
                    anchors.fill: parent
                    blurEnabled: true
                    blur: 1.0
                    blurMax: 48
                }
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 16

                QsText {
                    Layout.alignment: Qt.AlignHCenter
                    text: TimeService.longTime
                    font.pointSize: 48

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowBlur: 0.5
                    }

                    Component.onCompleted: console.debug(TimeService.longTime)
                }

                QsText {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: -16
                    Layout.bottomMargin: 32

                    text: TimeService.longDate
                    font.pointSize: 16

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowBlur: 0.5
                    }

                    Component.onCompleted: console.debug(TimeService.longDate, TimeService.datetime)
                }

                Rectangle {
                    id: passwordInput

                    implicitWidth: lockSurface.width / 4 + 24
                    implicitHeight: inputText.height * 2
                    color: Qt.alpha(Theme.bg0, 0.5)
                    radius: implicitHeight / 4

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        TextInput {
                            id: inputText

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            horizontalAlignment: TextInput.AlignLeft
                            verticalAlignment: TextInput.AlignVCenter

                            font.pointSize: 12
                            font.family: "sans-serif"

                            focus: true
                            echoMode: root.showPassword ? TextInput.Normal : TextInput.Password
                            clip: true

                            readOnly: pam.active
                            color: pam.active ? Theme.base04 : Theme.fg0

                            onTextChanged: root.currentText = text
                            onAccepted: {
                                if (root.falseLocked) {
                                    lock.locked = false;
                                    root.falseLocked = false;
                                    return;
                                }

                                pam.start();
                            }
                            Connections {
                                target: root
                                function onCurrentTextChanged() {
                                    inputText.text = root.currentText;
                                }
                            }
                        }

                        QsIcon {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                            name: `password-show-${root.showPassword ? "on" : "off"}`
                            size: inputText.font.pointSize * 2.5
                            icon.color: root.showPassword ? Theme.fg0 : Theme.base04

                            TapHandler {
                                onTapped: root.showPassword = !root.showPassword
                            }
                        }
                    }
                }
            }
        }
    }

    PamContext {
        id: pam

        onPamMessage: {
            if (responseRequired) {
                respond(root.currentText);
            }
        }

        onCompleted: result => {
            if (result == PamResult.Success) {
                lock.locked = false;
            } else {
                root.currentText = "";
            }
        }
    }

    IpcHandler {
        target: "lockscreen"

        function lock() {
            lock.locked = true;
        }

        function pseudoLock() {
            root.falseLocked = true;
            lock.locked = true;
        }
    }
}
