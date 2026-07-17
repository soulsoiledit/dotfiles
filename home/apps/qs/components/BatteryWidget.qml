import QtQuick

import Quickshell
import Quickshell.Services.UPower

import qs.components.shared
import qs.meta
import qs.services

QsIcon {
    id: root

    readonly property double percentage: BatteryService.percentage
    readonly property int batteryState: BatteryService.state

    readonly property string index: Math.min(Math.round(10 * percentage), 10)
    readonly property string iconIndex: String(10 * index).padStart(3, "0")

    size: 24

    name: {
        switch (batteryState) {
        case UPowerDeviceState.FullyCharged:
            return "battery-full-symbolic";
        case UPowerDeviceState.Charging:
        case UPowerDeviceState.PendingCharge:
            return `battery-${iconIndex}-charging-symbolic`;
        case UPowerDeviceState.Discharging:
        case UPowerDeviceState.PendingDischarge:
            return `battery-${iconIndex}-symbolic`;
        case UPowerDeviceState.Empty:
            return "battery-empty-symbolic";
        case UPowerDeviceState.Unknown:
            return "battery-missing-symbolic";
        default:
            return "battery-missing-symbolic";
        }
    }

    icon.color: {
        switch (batteryState) {
        case UPowerDeviceState.FullyCharged:
            return Theme.fg0;
        case UPowerDeviceState.Charging:
        case UPowerDeviceState.PendingCharge:
            return index == 10 ? Theme.fg0 : Theme.ok;
        case UPowerDeviceState.Discharging:
        case UPowerDeviceState.PendingDischarge:
            if (index <= 1) {
                return Theme.error;
            } else if (index == 2) {
                return Theme.warning;
            } else {
                return Theme.fg0;
            }
        case UPowerDeviceState.Empty:
        case UPowerDeviceState.Unknown:
            return Theme.error;
        default:
            return "transparent";
        }
    }

    PowerProfileWidget {
        id: power
        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Top | Edges.Right
    }

    onClicked: power.visible = !power.visible

    QsToolTip {
        text: {
            const percentage = Math.round(root.percentage * 100, 2);

            const timeLeft = BatteryService.timeLeft;
            const hours = Math.floor(timeLeft / 3600);
            const minutes = String(Math.floor(timeLeft % 3600 / 60)).padStart(2, "0");
            const timeLeftFormatted = `${hours}:${minutes}`;

            const rateFormatted = BatteryService.rate.toFixed(1);

            return `${percentage}% (${timeLeftFormatted} at ${rateFormatted} W)`;
        }
    }
}
