pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Pipewire

import qs.services

Singleton {
    id: root

    PwObjectTracker {
        objects: root.audioNodes
    }

    readonly property list<PwNode> audioNodes: Pipewire.nodes.values.filter(i => i.audio !== null)
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource

    property list<PwNode> playbackNodes
    property list<PwNode> recordingNodes
    property list<PwNode> outputNodes
    property list<PwNode> inputNodes

    onSinkChanged: audioNodesChanged()
    onSourceChanged: audioNodesChanged()
    onAudioNodesChanged: Qt.callLater(updateCategories)

    function updateCategories(): void {
        const newPlaybackNodes = [];
        const newRecordingNodes = [];
        const newOutputNodes = [];
        const newInputNodes = [];

        for (const node of audioNodes) {
            if (node === null) {
                continue;
            }

            let category;
            if (node.isStream) {
                category = node.isSink ? newPlaybackNodes : newRecordingNodes;
            } else {
                category = node.isSink ? newOutputNodes : newInputNodes;
            }

            if ((sink && node.id === sink.id) || (source && node.id === source.id)) {
                category.unshift(node);
            } else {
                category.push(node);
            }
        }

        playbackNodes = newPlaybackNodes;
        recordingNodes = newRecordingNodes;
        outputNodes = newOutputNodes;
        inputNodes = newInputNodes;
    }

    function toPercentage(volume): int {
        return Math.round(volume * 100);
    }

    function toState(volume, muted): string {
        if (muted) {
            return "muted";
        } else if (volume <= 0.333) {
            return "low";
        } else if (volume <= 0.666) {
            return "medium";
        } else {
            return "high";
        }
    }

    property string name: sink?.description ?? null
    property double volume: sink?.audio?.volume ?? null
    property bool muted: sink?.audio?.muted ?? null

    property string micName: source?.description ?? null
    property double micVolume: source?.audio?.volume ?? null
    property bool micMuted: source?.audio?.muted ?? null

    readonly property int percentage: toPercentage(volume)
    readonly property string state: toState(volume, muted)

    readonly property int micPercentage: toPercentage(micVolume)
    readonly property string micState: toState(micVolume, micMuted)

    function notifyVolume(): void {
        NotificationService.notifyOsd("volume-change", [`${percentage}%`, "--icon", `audio-volume-${state}-panel`, "-h", `int:value:${percentage}`]);
    }

    function notifyMicVolume(): void {
        NotificationService.notifyOsd("mic-volume-change", [`${micPercentage}%`, "--icon", `mic-volume-${micState}`, "-h", `int:value:${micPercentage}`]);
    }

    function scheduleNotifyVolume() {
        Qt.callLater(notifyVolume);
    }

    function scheduleNotifyMicVolume() {
        Qt.callLater(notifyMicVolume);
    }

    Component.onCompleted: {
        percentageChanged.connect(scheduleNotifyVolume);
        mutedChanged.connect(scheduleNotifyVolume);

        micPercentageChanged.connect(scheduleNotifyMicVolume);
        micMutedChanged.connect(scheduleNotifyMicVolume);
    }
}
