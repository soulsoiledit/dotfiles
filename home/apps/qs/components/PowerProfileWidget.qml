pragma ComponentBehavior: Bound

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
        Layout.alignment: Qt.AlignHCenter
        font.pointSize: 10
        text: "Power profile"
    }

    RowLayout {
        Repeater {
            id: icons
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
                required property var index
                required property var modelData

                readonly property string currentProfile: PowerProfileService.profile
                readonly property string name: modelData.name
                readonly property int profile: modelData.profile

                readonly property bool first: index === 0
                readonly property bool last: index === icons.count - 1
                readonly property bool active: name === currentProfile

                width: 48
                height: width

                topLeftRadius: active || first ? width : height / 5
                bottomLeftRadius: topLeftRadius
                topRightRadius: active || last ? width : height / 5
                bottomRightRadius: topRightRadius
                color: active ? Theme.accent : tooltip.hovered ? Theme.base03 : Theme.base02

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
