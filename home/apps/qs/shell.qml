//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication
//@ pragma DropExpensiveFonts

import QtQuick

import Quickshell
import Quickshell.Io

import qs.modules
import qs.services

ShellRoot {
    IpcHandler {
        target: "shell"
        function reload(hard: bool) {
            Quickshell.reload(hard);
        }
    }

    readonly property var idleService: IdleService
    readonly property var backlightService: BacklightService
    readonly property var powerProfileService: PowerProfileService

    Wallpaper {}
    Bar {}
    Lockscreen {}
    Launcher {}
    Notifications {}
}
