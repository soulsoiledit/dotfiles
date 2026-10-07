pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.WindowManager

Scope {
    id: root

    required property var screen
    property list<var> workspaces

    Process {
        id: niriMsgWorkspaces
        command: ["niri", "msg", "--json", "workspaces"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.workspaces = JSON.parse(text.trim()).sort((x, y) => x.idx - y.idx);
            }
        }
    }

    function queryWorkspaces(): void {
        niriMsgWorkspaces.running = true;
    }

    function updateWorkspaces(): void {
        Qt.callLater(queryWorkspaces);
    }

    Instantiator {
        model: WindowManager.screenProjection(root.screen).windowsets
        delegate: Connections {
            required property Windowset modelData
            target: modelData
            function onActiveChanged() {
                root.updateWorkspaces();
            }
        }
    }

    Connections {
        target: ToplevelManager
        function onActiveToplevelChanged() {
            root.updateWorkspaces();
        }
    }

    Connections {
        target: ToplevelManager.toplevels
        function onValuesChanged() {
            root.updateWorkspaces();
        }
    }
}
