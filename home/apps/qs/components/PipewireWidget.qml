import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.components.shared
import qs.meta
import qs.services

ColumnLayout {
    id: root
    spacing: 8

    component AudioNodesSection: QtObject {
        required property string name
        required property list<PwNode> nodes
    }

    readonly property list<AudioNodesSection> audioNodesSorted: [
        AudioNodesSection {
            name: "Output Devices"
            nodes: PipewireService.outputNodes
        },
        AudioNodesSection {
            name: "Playback"
            nodes: PipewireService.playbackNodes
        },
        AudioNodesSection {
            name: "Input Devices"
            nodes: PipewireService.inputNodes
        },
        AudioNodesSection {
            name: "Recording"
            nodes: PipewireService.recordingNodes
        }
    ]

    component NodeRow: ColumnLayout {
        id: nodeRow

        spacing: 8

        required property PwNode node
        readonly property string percentage: `${Math.round(node?.audio?.volume * 100)}%`
        readonly property var name: {
            if (node?.isStream) {
                return `${node.name} - ${node.properties["media.name"] ?? ""}`;
            } else {
                return node?.description ?? nodeRow.node?.name;
            }
        }

        QsText {
            id: nodeName

            font.pointSize: 10
            Layout.fillWidth: true
            elide: Text.ElideRight

            text: nodeRow.name ?? null

            QsToolTip {
                text: nodeRow.name ?? null
            }
        }

        RowLayout {
            id: bar
            Layout.fillWidth: true

            spacing: 8

            QsIcon {
                size: 16
                name: nodeRow.node?.audio?.muted ? "audio-volume-muted" : "audio-volume-high"
                icon.color: nodeRow.node?.audio.muted ? Theme.base03 : Theme.base05

                TapHandler {
                    onTapped: nodeRow.node.audio.muted = !nodeRow.node.audio.muted
                }
            }

            QsSlider {
                Layout.fillWidth: true
                implicitHeight: nodeName.font.pointSize * 2

                value: nodeRow.node?.audio?.volume ?? null
                onValueChanged: nodeRow.node.audio.volume = value

                activeTrackColor: nodeRow.node?.audio.muted ? Theme.base03 : Theme.accent
                inactiveTrackColor: Theme.base02
                snap: 5
            }

            QsText {
                Layout.preferredWidth: fontInfo.pointSize * 3.5
                font.pointSize: nodeName.font.pointSize
                horizontalAlignment: Text.AlignRight
                text: nodeRow.percentage
            }
        }
    }

    Repeater {
        model: root.audioNodesSorted

        ColumnLayout {
            id: section

            required property AudioNodesSection modelData
            spacing: 8

            QsText {
                font.pointSize: 10
                color: Theme.base03
                text: section.modelData.name
            }

            Repeater {
                model: section.modelData.nodes

                NodeRow {
                    required property var modelData
                    node: modelData
                }
            }
        }
    }
}
