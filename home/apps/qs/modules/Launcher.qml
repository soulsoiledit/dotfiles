pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

import qs.meta
import qs.components.shared
import qs.services

Scope {
    IpcHandler {
        target: "launcher"

        function toggle() {
            root.visible = !root.visible;
        }
    }

    PanelWindow { // qmllint disable uncreatable-type
        id: root

        color: "transparent"

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        implicitWidth: root.screen.width / 2
        implicitHeight: root.screen.height / 2

        focusable: true

        Component.onCompleted: root.visible = false

        onVisibleChanged: {
            if (visible) {
                grid.currentIndex = 0;
            } else {
                grid.currentIndex = -1;
            }
        }

        function activateApp(app: var) {
            DesktopEntryService.usage.record(app.entry.id);
            const window = ToplevelManager.toplevels.values.filter(w => app.matchesWindow(w))[0];
            if (window === undefined) {
                execute(app.entry);
            } else {
                window.activate();
            }
            hide();
        }

        function execute(entry: var) {
            if (entry.runInTerminal) {
                Quickshell.execDetached({
                    command: ["footclient", entry.command],
                    workingDirectory: entry.workingDirectory
                });
            } else {
                entry.execute();
            }
        }

        function hide() {
            root.visible = false;
            grid.currentIndex = 0;
            searchInput.clear();
        }

        Shortcut {
            sequences: ["Escape"]
            onActivated: root.hide()
        }

        Shortcut {
            sequences: ["Up"]
            onActivated: grid.currentIndex = Math.max(0, grid.currentIndex - 1)
        }

        Shortcut {
            sequences: ["Down"]
            onActivated: grid.currentIndex = Math.min(grid.currentIndex + 1, grid.count - 1)
        }

        Rectangle {
            id: container
            color: Theme.bg1

            anchors.fill: parent
            radius: 32

            ColumnLayout {
                id: layout
                anchors.fill: parent
                anchors.margins: 24
                spacing: 16

                Rectangle {
                    id: searchBar
                    color: Theme.base02
                    Layout.fillWidth: true
                    implicitHeight: 40
                    radius: 32

                    TextInput {
                        id: searchInput

                        readonly property string textClean: text.trim().toLowerCase()

                        anchors.fill: searchBar
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16

                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter

                        focus: true
                        clip: true
                        autoScroll: true

                        font.pointSize: 14

                        color: Theme.base05

                        onAccepted: {
                            root.activateApp(grid.model.values[grid.currentIndex]);
                        }

                        onTextChanged: Qt.callLater(() => grid.currentIndex = 0)
                    }
                }

                GridView {
                    id: grid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    focus: false

                    cellWidth: width / 6
                    cellHeight: cellWidth

                    highlightMoveDuration: 50
                    clip: true

                    model: ScriptModel {
                        objectProp: "id"
                        values: DesktopEntryService.applications.filter(entry => entry.matchesQuery(searchInput.textClean))
                    }

                    highlight: Rectangle {
                        id: itemHighlight
                        color: Theme.base03

                        width: grid.cellWidth
                        height: grid.cellHeight
                        radius: 32
                    }

                    delegate: ColumnLayout {
                        id: app

                        required property var modelData
                        required property int index

                        readonly property var entry: modelData.entry
                        readonly property string name: entry.name
                        readonly property var icon: entry.icon

                        width: grid.cellWidth
                        height: grid.cellHeight

                        TapHandler {
                            gesturePolicy: TapHandler.ReleaseWithinBounds
                            onTapped: root.activateApp(app.entry)
                        }

                        HoverHandler {
                            id: appHover
                            onHoveredChanged: if (hovered && (appHover.point.velocity.x !== 0.0 || appHover.point.velocity.y !== 0.0)) {
                                grid.currentIndex = app.index;
                            }
                        }

                        IconImage {
                            id: appIcon
                            Layout.topMargin: 8
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                            source: Quickshell.iconPath(app.icon)
                            implicitSize: Math.floor(Math.min(app.width, app.height) * 0.5)
                            asynchronous: true
                        }

                        QsText {
                            id: appName
                            Layout.fillWidth: true
                            Layout.preferredWidth: 0
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                            Layout.bottomMargin: 8
                            Layout.leftMargin: 16
                            Layout.rightMargin: Layout.leftMargin

                            text: app.name
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            horizontalAlignment: TextInput.AlignHCenter
                            elide: Text.ElideRight
                            maximumLineCount: 2

                            QsToolTip {
                                id: tooltip
                                text: appName.text
                            }
                        }
                    }
                }
            }
        }
    }
}
