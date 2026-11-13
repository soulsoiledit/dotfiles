import QtQuick

Item {
    id: root

    required property real value
    property real minValue: 0
    property real maxValue: 1
    property real step: 0.01

    required property color activeTrackColor
    required property color inactiveTrackColor

    readonly property real spacing: 2

    readonly property double percentage: Math.max(0, Math.min((value - minValue) / (maxValue - minValue), 1))
    readonly property real sliderWidth: root.width - root.spacing * 2 - handle.width

    signal sliderMoved(position: point)
    onSliderMoved: point => syncValue(point)
    function syncValue(position: point): void {
        const percent = Math.max(0, Math.min(position.x / width, 1));
        const unsnapped = minValue + percent * (maxValue - minValue);
        value = Math.round(unsnapped / step) * step;
    }

    Rectangle {
        id: activeTrack
        anchors.verticalCenter: handle.verticalCenter
        width: root.sliderWidth * root.percentage
        height: root.height / 4

        color: root.activeTrackColor
        topLeftRadius: height
        bottomLeftRadius: topLeftRadius
        topRightRadius: height / 4
        bottomRightRadius: topRightRadius
    }

    Rectangle {
        id: handle
        anchors.left: activeTrack.right
        anchors.leftMargin: root.spacing
        width: root.width * 0.02
        height: root.height

        color: root.activeTrackColor
        radius: height / 4
    }

    Rectangle {
        id: inactiveTrack
        anchors.left: handle.right
        anchors.leftMargin: root.spacing
        anchors.verticalCenter: handle.verticalCenter
        width: root.sliderWidth - activeTrack.width
        height: activeTrack.height

        color: root.inactiveTrackColor
        topLeftRadius: activeTrack.topRightRadius
        bottomLeftRadius: activeTrack.bottomRightRadius
        topRightRadius: activeTrack.topLeftRadius
        bottomRightRadius: activeTrack.bottomLeftRadius
    }

    DragHandler {
        target: null
        margin: 4
        xAxis.minimum: 0
        xAxis.maximum: root.width
        onCentroidChanged: {
            if (active) {
                root.sliderMoved(centroid.position);
            }
        }
    }

    TapHandler {
        margin: 4
        onPressedChanged: {
            if (pressed) {
                root.sliderMoved(point.pressPosition);
            }
        }
    }
}
