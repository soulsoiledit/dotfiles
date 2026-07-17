import qs.components.shared
import qs.meta
import qs.services

QsIcon {
    id: root

    readonly property var pipewire: PipewireService

    name: `audio-volume-${pipewire.state}-symbolic`
    size: 20
    icon.color: Theme.fg0

    QsToolTip {
        text: `${root.pipewire.name}: ${root.pipewire.percentage}%`
    }
}
