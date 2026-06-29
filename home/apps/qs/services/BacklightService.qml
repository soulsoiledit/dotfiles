pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string device: "amdgpu_bl2"
    readonly property string backlightPath: `/sys/class/backlight/${device}`

    property alias maxBrightness: maxBacklight.value
    property alias currentBrightness: currentBacklight.value
    readonly property double percentage: maxBrightness && Math.round(100 * currentBrightness / maxBrightness)

    readonly property list<string> icons: ['󰽤', '', '', '', '', '󰃠']
    readonly property string icon: icons[Math.floor(root.percentage * icons.length / 101)]

    function notify() {
        Qt.callLater(Quickshell.execDetached, ["notify-send", `${icon} ${percentage}`, "-c", "osd", "-u", "low", "-h", `int:value:${percentage}`, "-h", "string:x-canonical-private-synchronous:brightness-change"]);
    }

    Component.onCompleted: percentageChanged.connect(notify)

    FileView {
        id: maxBacklight
        path: `${root.backlightPath}/max_brightness`
        watchChanges: true
        blockLoading: true
        onFileChanged: reload()

        readonly property int value: parseInt(text(), 10)
    }

    FileView {
        id: currentBacklight
        path: `${root.backlightPath}/brightness`
        watchChanges: true
        blockLoading: true
        onFileChanged: this.reload()

        readonly property int value: parseInt(this.text(), 10)
    }
}
