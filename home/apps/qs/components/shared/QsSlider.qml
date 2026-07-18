import QtQuick

import qs.meta

Rectangle {
    id: root

    required property double value

    required property int snap
    readonly property int snapMult: 100 / snap

    color: Theme.bg2
    topRightRadius: height
    bottomRightRadius: topRightRadius

    function syncVolume(point) {
        var relativePosition = Math.max(0, Math.min(point.position.x / width, 1));
        var positionRoundedTo5 = Math.round(relativePosition * snapMult) / snapMult;
        value = positionRoundedTo5;
    }

    function scheduleSyncVolume(point) {
        Qt.callLater(syncVolume, point);
    }

    Rectangle {
        id: fill
        width: root.width * root.value
        height: root.height

        color: Theme.accent
        topLeftRadius: height
        bottomLeftRadius: topLeftRadius
    }

    Rectangle {
        id: dot

        anchors.verticalCenter: parent.verticalCenter

        height: root.height * 3
        width: height
        x: root.width * root.value - width / 2

        color: Theme.accent
        radius: height
    }

    DragHandler {
        target: null

        margin: 4
        xAxis.minimum: 0
        xAxis.maximum: root.width

        onCentroidChanged: {
            if (active) {
                root.scheduleSyncVolume(centroid);
            }
        }
    }

    TapHandler {
        margin: 4
        onPressedChanged: {
            if (pressed) {
                root.scheduleSyncVolume(point);
            }
        }
    }
}
