pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root

    readonly property string device: "amdgpu_bl2"
    readonly property string backlightPath: `/sys/class/backlight/${device}`

    property alias maxBrightness: maxBacklight.value
    property alias currentBrightness: currentBacklight.value
    readonly property double percentage: maxBrightness && Math.round(100 * currentBrightness / maxBrightness)

    readonly property list<string> icons: ['󰽤', '', '', '', '', '󰃠']
    readonly property string icon: icons[Math.floor(root.percentage * icons.length / 101)]

    function notify(): void {
        NotificationService.notifyOsd("brightness-change", [`${icon} ${percentage}`, "-h", `int:value:${percentage}`]);
    }

    function scheduleNotify(): void {
        Qt.callLater(notify);
    }

    Component.onCompleted: percentageChanged.connect(scheduleNotify)

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
        onFileChanged: reload()

        readonly property int value: parseInt(text(), 10)
    }
}
