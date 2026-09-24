pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.UPower

import qs.services

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

    function notify(): void {
        NotificationService.notifyOsd("profile-switch", ["Power Profile", profile, "--icon", `battery-profile-${profile}`]);
    }

    function scheduleNotify() {
        Qt.callLater(notify);
    }

    Component.onCompleted: profileChanged.connect(scheduleNotify)
}
