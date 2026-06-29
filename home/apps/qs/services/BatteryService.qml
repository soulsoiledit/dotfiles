pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property UPowerDevice primaryBattery: UPower.displayDevice

    readonly property double percentage: primaryBattery.percentage.toFixed(2)
    readonly property string state: primaryBattery.state
    readonly property int rate: primaryBattery.changeRate
    readonly property string timeLeft: {
        switch (state) {
        case UPowerDeviceState.FullyCharged:
        case UPowerDeviceState.Charging:
        case UPowerDeviceState.PendingCharge:
            return primaryBattery.timeToFull;
        default:
            return primaryBattery.timeToEmpty;
        }
    }
}
