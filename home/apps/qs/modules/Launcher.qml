pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.components
import qs.components.shared
import qs.meta
import qs.services

// TODO: add clipboard history management
// TODO: add debouncing on inputs
// TODO: add smart-case
Scope {
    id: root

    IpcHandler {
        target: "launcher"
        function toggle() {
            ClipboardService.syncClipboard();
            launcherLoader.activeAsync = !launcherLoader.activeAsync;
        }
    }

    enum Modes {
        Apps = 0,
        Clipboard = 1
    }

    LazyLoader {
        id: launcherLoader
        PanelWindow { // qmllint disable uncreatable-type
            id: launcher

            property int mode: Launcher.Modes.Apps

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

            implicitWidth: launcher.screen.width / 2
            implicitHeight: launcher.screen.height / 2

            focusable: true
            color: "transparent"

            Shortcut {
                sequences: ["Escape"]
                onActivated: launcherLoader.activeAsync = false
            }

            Shortcut {
                sequences: ["Up"]
                onActivated: viewLoader.item.previous()
            }

            Shortcut {
                sequences: ["Down"]
                onActivated: viewLoader.item.next()
            }

            Rectangle {
                id: background
                anchors.fill: parent
                color: Theme.base00
                radius: 32

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 16

                    Rectangle {
                        id: searchBar
                        Layout.fillWidth: true
                        Layout.preferredHeight: searchInput.contentHeight * 1.5
                        color: Theme.base01
                        radius: 32

                        RowLayout {
                            anchors.fill: parent
                            anchors.centerIn: parent

                            QsIcon {
                                id: modeIcon
                                visible: launcher.mode !== Launcher.Modes.Apps
                                Layout.leftMargin: 16
                                size: parent.height * 0.65
                                name: "clipboard-symbolic"
                                icon.color: Theme.base05
                            }

                            TextInput {
                                id: searchInput

                                readonly property string textClean: text.trim().toLowerCase()

                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.leftMargin: 16
                                Layout.rightMargin: 16

                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter

                                focus: true
                                clip: true
                                autoScroll: true

                                font.pointSize: 14
                                color: Theme.base05

                                onAccepted: {
                                    viewLoader.item.activateSelected();
                                    launcherLoader.activeAsync = false;
                                }

                                Keys.onTabPressed: event => {
                                    if (text.startsWith("clip")) {
                                        clear();
                                        launcher.mode = Launcher.Modes.Clipboard;
                                        event.accepted = true;
                                    }
                                }

                                Keys.onBacktabPressed: event => {
                                    if (launcher.mode !== Launcher.Modes.Apps) {
                                        clear();
                                        launcher.mode = Launcher.Modes.Apps;
                                        event.accepted = true;
                                    }
                                }

                                Keys.onPressed: event => {
                                    if (event.key === Qt.Key_Backspace) {
                                        if (searchInput.text === "" && launcher.mode !== Launcher.Modes.Apps) {
                                            launcher.mode = Launcher.Modes.Apps;
                                            event.accepted = true;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Loader {
                        id: viewLoader
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        sourceComponent: {
                            if (launcher.mode === Launcher.Modes.Apps) {
                                return appGridComponent;
                            } else {
                                return clipListComponent;
                            }
                        }

                        signal itemActivated
                        onItemActivated: launcherLoader.activeAsync = false

                        Component {
                            id: appGridComponent
                            GridSelect {
                                id: appGrid
                                focus: false
                                cellWidth: width / 6
                                model: ScriptModel {
                                    objectProp: "id"
                                    values: DesktopEntryService.applications.filter(entry => entry.matchesQuery(searchInput.textClean))
                                    onValuesChanged: appGrid.currentIndex = 0
                                }

                                getText: modelData => modelData.entry.name
                                getIcon: modelData => modelData.entry.icon
                                onItemActivated: modelData => {
                                    DesktopEntryService.open(modelData);
                                    viewLoader.itemActivated();
                                }
                            }
                        }

                        Component {
                            id: clipListComponent
                            ListSelectPreview {
                                id: clipList

                                model: ScriptModel {
                                    objectProp: "id"
                                    values: ClipboardService.clipboard.filter(item => item.key.includes(searchInput.textClean))
                                    onValuesChanged: clipList.currentIndex = 0
                                }

                                listWidth: parent.width / 3
                                getListText: modelData => modelData?.preview ?? ""
                                onCurrentDataChanged: currentData?.decode()
                                onItemActivated: modelData => {
                                    modelData.copy();
                                    viewLoader.itemActivated();
                                }

                                previewDelegate: Loader {
                                    id: previewLoader

                                    sourceComponent: {
                                        if (clipList.currentItem === null) {
                                            return noPreview;
                                        }

                                        if (clipList.currentData?.isImage) {
                                            return imagePreview;
                                        } else {
                                            return textPreview;
                                        }
                                    }

                                    Component {
                                        id: noPreview
                                        QsText {
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pointSize: 16
                                            text: "No item selected"
                                        }
                                    }

                                    Component {
                                        id: imagePreview
                                        Image {
                                            anchors.fill: parent
                                            anchors.centerIn: parent
                                            anchors.margins: 16
                                            asynchronous: true
                                            fillMode: Image.PreserveAspectFit
                                            source: ClipboardService.decoded
                                        }
                                    }

                                    Component {
                                        id: textPreview
                                        Flickable {
                                            anchors.fill: parent
                                            anchors.margins: 16
                                            contentWidth: textPreviewText.width
                                            contentHeight: textPreviewText.height

                                            QsText {
                                                id: textPreviewText
                                                width: parent.width - 16
                                                wrapMode: Text.Wrap
                                                font.family: "monospace"
                                                font.pointSize: 10
                                                textFormat: Text.PlainText
                                                text: ClipboardService.decoded
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
