import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.WindowManager

Scope {
    id: root

    required property var screen

    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    readonly property list<Windowset> activeWorkspace: WindowManager.screenProjection(screen).windowsets.filter(a => a.active)

    property list<var> workspaces

    Process {
        id: niriCli
        command: ["niri", "msg", "--json", "workspaces"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.workspaces = JSON.parse(text.trim()).sort((x, y) => x.idx - y.idx);
            }
        }
    }

    onActiveWindowChanged: niriCli.running = true
    onActiveWorkspaceChanged: niriCli.running = true
}
