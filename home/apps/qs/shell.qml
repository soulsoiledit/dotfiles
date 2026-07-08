//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication
//@ pragma DropExpensiveFonts

import Quickshell
import QtQuick

import qs.modules
import qs.services

ShellRoot {
    readonly property var idleService: IdleService
    readonly property var backlightService: BacklightService
    readonly property var powerProfileService: PowerProfileService

    Wallpaper {}
    Bar {}
    Lockscreen {}
}
