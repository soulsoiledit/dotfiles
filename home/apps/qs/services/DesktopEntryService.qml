pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Singleton {
    id: root

    readonly property string path: Quickshell.stateDir + "/launcher.json"

    readonly property var appPrototype: ({
            matchesWindow: function (window: var): bool {
                switch (window.appId) {
                case this.entry.startupClass:
                case this.entry.name:
                case this.entry.id:
                    return true;
                default:
                    return false;
                }
            },
            open: function (): void {
                usage.record(this.entry.id);

                const window = ToplevelManager.toplevels.values.find(w => this.matchesWindow(w));
                if (window !== undefined) {
                    window.activate();
                    return;
                }

                if (this.entry.runInTerminal) {
                    Quickshell.execDetached({
                        command: ["footclient", ...this.entry.command],
                        workingDirectory: this.entry.workingDirectory
                    });
                    return;
                }

                this.entry.execute();
            }
        })

    readonly property var applications: [...DesktopEntries.applications.values].map(entry => {
        let app = Object.create(appPrototype);
        app.entry = entry;

        const joinedKeywords = entry.keywords.join(" ");
        let wordKey = [entry.name, entry.genericName, entry.id, joinedKeywords].join(" ");

        let initialsSource = `${entry.name} ${entry.genericName}`.toLowerCase();
        let initialKey = initialsSource.split(/[-_\s]+/).map(c => c[0]).join("");

        app.keys = [wordKey, initialKey];
        app.score = usage.data[entry.id] ?? 0;

        return app;
    }).sort((a, b) => b.score - a.score)

    FileView {
        id: file
        path: root.path
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        // qmllint disable unresolved-type
        adapter: JsonAdapter {
            id: usage
            property var data: ({})
            function record(id: string) {
                usage.data[id] = Date.now();
                dataChanged();
            }
        }
    }
}
