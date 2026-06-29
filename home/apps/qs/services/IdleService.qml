pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Wayland

Singleton {
    id: root

    readonly property list<string> lockCmd: ["loginctl", "lock-session"]
    readonly property list<string> dpmsOffCmd: ["niri", "msg", "action", "power-off-monitors"]
    readonly property list<string> sleepCmd: ["systemctl", "sleep"]

    IdleMonitor {
        timeout: 5 * 60
        onIsIdleChanged: isIdle && Quickshell.execDetached(root.lockCmd)
    }

    IdleMonitor {
        timeout: 10 * 60
        onIsIdleChanged: isIdle && Quickshell.execDetached(root.dpmsOffCmd)
    }

    IdleMonitor {
        timeout: 30 * 60
        onIsIdleChanged: isIdle && Quickshell.execDetached(root.sleepCmd)
    }
}
