pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string datetime: Qt.formatDateTime(clock.date, "MM\ndd\n\nhh\nmm")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
