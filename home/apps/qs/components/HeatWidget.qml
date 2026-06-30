import qs.meta
import qs.components.shared
import qs.services

QsIcon {
    id: root

    readonly property var temperature: SystemService.temperature
    visible: temperature >= 95

    name: "temp-symbolic"
    size: 20
    icon.color: Theme.error

    QsToolTip {
        target: root
        targetHovered: root.hovered
        text: `${root.temperature} ℃`
    }
}
