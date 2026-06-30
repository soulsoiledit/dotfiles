pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    readonly property var json: JSON.parse(stylixPalette.text())
    readonly property color base00: `#${json.base00}`
    readonly property color base01: `#${json.base01}`
    readonly property color base02: `#${json.base02}`
    readonly property color base03: `#${json.base03}`
    readonly property color base04: `#${json.base04}`
    readonly property color base05: `#${json.base05}`
    readonly property color base06: `#${json.base06}`
    readonly property color base07: `#${json.base07}`
    readonly property color base08: `#${json.base08}`
    readonly property color base09: `#${json.base09}`
    readonly property color base0A: `#${json.base0A}`
    readonly property color base0B: `#${json.base0B}`
    readonly property color base0C: `#${json.base0C}`
    readonly property color base0D: `#${json.base0D}`
    readonly property color base0E: `#${json.base0E}`
    readonly property color base0F: `#${json.base0F}`

    readonly property color bg0: base00
    readonly property color bg1: base01
    readonly property color bg2: base02

    readonly property color fg0: base05

    readonly property color accent: base0B

    readonly property color error: base08
    readonly property color warning: base0A
    readonly property color ok: base0B
    readonly property color hint: base0D

    FileView {
        id: stylixPalette
        path: `${Quickshell.env("XDG_CONFIG_HOME")}/stylix/palette.json`
        watchChanges: true
        blockLoading: true
        onFileChanged: reload()
    }
}
