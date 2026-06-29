pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property int id: 0

    readonly property string thermalZonePath: `/sys/class/thermal/thermal_zone${id}/temp`
    readonly property double temperature: Math.round(parseInt(thermalZone.text(), 10) / 1000)

    readonly property string meminfoPath: "/proc/meminfo"
    readonly property double memUsedPercentage: {
        var re = (/(\S+):\s+(\d+)/);
        var meminfoMap = new Map(meminfo.text().split("\n").map(a => re.exec(a)?.slice(1)).filter(Boolean));

        var total = meminfoMap.get("MemTotal") ?? 1;
        var available = meminfoMap.get("MemAvailable") ?? 0;
        var used = total - available;

        return Math.round(1000 * used / total) / 10;
    }

    FileView {
        id: thermalZone
        path: root.thermalZonePath
    }

    FileView {
        id: meminfo
        path: root.meminfoPath
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            thermalZone.reload();
            meminfo.reload();
        }
    }
}
