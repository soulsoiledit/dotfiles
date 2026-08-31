pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string path: Quickshell.stateDir + "/launcher.json"
    readonly property alias usage: usage

    readonly property var appPrototype: ({
            matchesQuery: function (query: string): double {
                return query.length === 0 || this.searchKey.includes(query) || this.searchInitials.includes(query);
            },
            matchesWindow: function (window: var): bool {
                return window.appId === this.entry.startupClass || window.appId === this.entry.name || window.appId === this.entry.id;
            }
        })

    readonly property var applications: [...DesktopEntries.applications.values].map(entry => {
        let app = Object.create(appPrototype);

        app.entry = entry;
        app.searchKey = [entry.name, entry.genericName, entry.id, entry.execString, entry.keywords.join(" ")].join(" ").toLowerCase();

        let initialsSource = `${entry.name} ${entry.genericName}`.toLowerCase();
        app.searchInitials = initialsSource.split(/[-_\s]+/).map(c => c[0]).join("");

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
