pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property string directory: Quickshell.env("HOME") + "/pictures/wallpapers/"
    readonly property string lockscreenPath: Quickshell.env("XDG_STATE_HOME") + "/lockscreen.jpg"
    property alias path: persist.path

    PersistentProperties {
        id: persist
        property string path
        onLoaded: persist.path === "" ? root.next() : 0
    }

    function next(): void {
        timer.restart();
        shuffle.running = true;
    }

    IpcHandler {
        target: "wallpaper"

        function next(): void {
            root.next();
        }
    }

    Timer {
        id: timer
        interval: 2 * 60 * 60 * 1000
        repeat: true
        running: true
        onTriggered: shuffle.running = true
    }

    Process {
        id: shuffle
        command: ["sh", "-c", `fd -t file .  ${root.directory} | shuf -n 1`]
        stdout: StdioCollector {
            onStreamFinished: {
                const path = text.trim();
                persist.path = path;
                Quickshell.execDetached(["vips", "gaussblur", path, root.lockscreenPath, "16"]);
            }
        }
    }
}
