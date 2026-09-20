pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

// TODO: Add entry delete and data wipe functions
Singleton {
    id: root

    property var clipboard: []
    property int decodeId
    property string decoded

    function syncClipboard() {
        cliphistList.running = true;
    }

    readonly property var clipboardPrototype: ({
            copy: function (): void {
                Quickshell.execDetached({
                    command: ["sh", "-c", `cliphist decode ${this.id} | wl-copy`]
                });
            },
            decode: function (): void {
                root.decoded = null;
                const process = this.isImage ? decodeImageProc : decodeProc;
                process.running = false;
                decodeId = this.id;
                process.running = true;
            }
        })

    Process {
        id: cliphistList
        running: true
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                const newClipboardData = [];

                for (const line of text.trim().split("\n")) {
                    if (line.length === 0) {
                        continue;
                    }

                    const separatorIndex = line.indexOf("\t");
                    const id = line.substring(0, separatorIndex).trim();
                    let preview = line.substring(separatorIndex + 1).trim();

                    let isImage = false;
                    preview = preview.replace(/^\[\[ binary data \d+ \S+B \S+ (\d+x\d+) ]]$/, (_, resolution) => {
                        isImage = true;
                        return `Image (${resolution})`;
                    });

                    let item = Object.create(clipboardPrototype);
                    item.id = id ?? -1;
                    item.preview = preview ?? "";
                    item.isImage = isImage ?? false;
                    item.key = item.preview?.toLowerCase() ?? "";

                    newClipboardData.push(item);
                }

                root.clipboard = newClipboardData;
            }
        }
    }

    Process {
        id: decodeImageProc
        command: ["sh", "-c", `cliphist decode ${root.decodeId} | base64 --wrap 0`]
        stdout: StdioCollector {
            onStreamFinished: root.decoded = `data:image/*;base64,${text}`
        }
    }

    Process {
        id: decodeProc
        command: ["cliphist", "decode", root.decodeId]
        stdout: StdioCollector {
            onStreamFinished: root.decoded = text
        }
    }
}
