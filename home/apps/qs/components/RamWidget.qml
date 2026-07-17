import qs.meta
import qs.components.shared
import qs.services

QsIcon {
    id: root

    readonly property var percentage: SystemService.memUsedPercentage
    visible: percentage >= 90

    name: "memory-symbolic"
    size: 20
    icon.color: Theme.error

    QsToolTip {
        text: `${root.percentage}%`
    }
}
