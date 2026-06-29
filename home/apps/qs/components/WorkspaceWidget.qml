pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.meta
import qs.services

ColumnLayout {
    id: root
    required property var screen
    spacing: 4

    readonly property int size: 20
    readonly property int occupiedHeight: size * 1.5
    readonly property int activeHeight: size * 2.5

    readonly property var niri: NiriService {
        screen: root.screen
    }

    Repeater {
        id: rep

        model: ScriptModel {
            objectProp: "name"
            values: root.niri.workspaces
        }

        Rectangle {
            id: workspace
            required property var modelData

            readonly property bool active: modelData.is_active
            readonly property bool occupied: modelData.active_window_id

            width: root.size
            Layout.preferredHeight: active ? root.activeHeight : occupied ? root.occupiedHeight : root.size
            radius: width

            visible: modelData.name || active || occupied
            color: active || hover.hovered ? Theme.accent : occupied ? Theme.bg2 : Theme.bg1

            HoverHandler {
                id: hover
            }

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
