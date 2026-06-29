pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property string profile: {
        switch (PowerProfiles.profile) {
        case PowerProfile.PowerSaver:
            return "powersave";
        case PowerProfile.Balanced:
            return "balanced";
        case PowerProfile.Performance:
            return "performance";
        }
    }

    Component.onCompleted: profileChanged.connect(notify)

    function notify() {
        Qt.callLater(Quickshell.execDetached, ["notify-send", "Power Profile", profile, "--icon", `battery-profile-${profile}`, "-c", "osd", "-u", "low", "-h", "string:x-canonical-private-synchronous:profile-switch"]);
    }
}
