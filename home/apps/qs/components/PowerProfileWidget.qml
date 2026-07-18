import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets

import qs.components.shared
import qs.meta
import qs.services

ColumnLayout {
    QsText {
        font.pointSize: 10
        color: Theme.fg0
        text: {
            const percentage = Math.round(BatteryService.percentage * 100, 2);

            const timeLeft = BatteryService.timeLeft;
            const hours = Math.floor(timeLeft / 3600);
            const minutes = String(Math.floor(timeLeft % 3600 / 60)).padStart(2, "0");
            const timeLeftFormatted = `${hours}:${minutes}`;

            const rateFormatted = BatteryService.rate.toFixed(1);

            return `${percentage}% (${timeLeftFormatted} at ${rateFormatted} W)`;
        }
    }

    Rectangle {
        Layout.preferredHeight: 2
        Layout.fillWidth: true
        color: Theme.bg2
        radius: height
    }

    QsText {
        font.pointSize: 10
        text: "Power profile:"
    }

    RowLayout {
        Repeater {
            model: [
                {
                    name: "powersave",
                    profile: PowerProfile.PowerSaver
                },
                {
                    name: "balanced",
                    profile: PowerProfile.Balanced
                },
                {
                    name: "performance",
                    profile: PowerProfile.Performance
                }
            ]

            Rectangle {
                id: profileIcon
                required property var modelData

                readonly property string currentProfile: PowerProfileService.profile
                readonly property string name: modelData.name
                readonly property int profile: modelData.profile

                width: 48
                height: width
                radius: width
                color: tooltip.hovered ? Theme.base03 : name === currentProfile ? Theme.base02 : "transparent"

                IconImage {
                    anchors.fill: parent
                    anchors.margins: 8
                    source: Quickshell.iconPath(`battery-profile-${profileIcon.name}`)
                }

                QsToolTip {
                    id: tooltip
                    text: profileIcon.name
                }

                TapHandler {
                    onTapped: PowerProfiles.profile = profileIcon.profile
                }
            }
        }
    }
}
