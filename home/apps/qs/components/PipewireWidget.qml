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

    component NodeRow: RowLayout {
        id: nodeRow

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
            Layout.preferredWidth: fontInfo.pointSize * 24
            elide: Text.ElideRight

            text: nodeRow.name ?? null

            QsToolTip {
                text: nodeRow.name ?? null
            }
        }

        QsSlider {
            Layout.preferredWidth: nodeName.fontInfo.pointSize * 12
            Layout.preferredHeight: 3

            value: nodeRow.node?.audio?.volume ?? null
            onValueChanged: nodeRow.node.audio.volume = value
            snap: 5
        }

        QsText {
            font.pointSize: nodeName.font.pointSize
            Layout.preferredWidth: fontInfo.pointSize * 4

            text: nodeRow.percentage

            horizontalAlignment: Text.AlignRight
        }

        QsIcon {
            size: 16
            name: nodeRow.node?.audio?.muted ? "audio-volume-muted" : "audio-volume-high"
            icon.color: Theme.fg0

            TapHandler {
                onTapped: nodeRow.node.audio.muted = !nodeRow.node.audio.muted
            }
        }
    }

    Repeater {
        model: root.audioNodesSorted

        ColumnLayout {
            id: section

            required property AudioNodesSection modelData

            QsText {
                font.pointSize: 10
                color: Theme.base03
                text: section.modelData.name + ":"
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
