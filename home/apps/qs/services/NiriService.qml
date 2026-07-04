import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.WindowManager

Scope {
    id: root

    required property var screen

    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    readonly property int windowCount: ToplevelManager.toplevels.values.length
    readonly property list<Windowset> activeWorkspace: WindowManager.screenProjection(screen).windowsets.filter(a => a.active)

    property list<var> workspaces

    Process {
        id: niriMsgWorkspaces
        command: ["niri", "msg", "--json", "workspaces"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.workspaces = JSON.parse(text.trim()).sort((x, y) => x.idx - y.idx);
            }
        }
    }

    function queryWorkspaces() {
        niriMsgWorkspaces.running = true;
    }

    function updateWorkspaces() {
        Qt.callLater(queryWorkspaces);
    }

    onActiveWindowChanged: updateWorkspaces()
    onWindowCountChanged: updateWorkspaces()
    onActiveWorkspaceChanged: updateWorkspaces()
}
