pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string datetime: Qt.formatDateTime(clock.date, "MM\ndd\n\nhh\nmm")

    readonly property string longDate: Qt.formatDateTime(clock.date, "dddd, MMMM d")
    readonly property string longTime: Qt.formatDateTime(clock.date, "hh:mm:ss")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
