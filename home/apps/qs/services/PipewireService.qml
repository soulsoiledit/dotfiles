pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    PwObjectTracker {
        objects: [root.sink]
    }

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNodeAudio audio: sink?.audio ?? null

    readonly property string name: sink?.description ?? null
    readonly property double value: audio?.volume ?? null
    readonly property bool muted: audio?.muted ?? null

    readonly property int percentage: Math.round(value * 100)
    readonly property string state: {
        if (muted) {
            return "muted";
        } else if (percentage <= 33) {
            return "low";
        } else if (percentage <= 66) {
            return "medium";
        } else {
            return "high";
        }
    }

    function notify() {
        Qt.callLater(Quickshell.execDetached, ["notify-send", `${percentage}%`, "--icon", `audio-volume-${state}`, "-c", "osd", "-u", "low", "-h", `int:value:${percentage}`, "-h", "string:x-canonical-private-synchronous:volume-change"]);
    }

    Component.onCompleted: {
        percentageChanged.connect(notify);
        mutedChanged.connect(notify);
    }
}
