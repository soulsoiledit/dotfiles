pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

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

    function open(app: var) {
        DesktopEntryService.usage.record(app.entry.id);
        const window = ToplevelManager.toplevels.values.filter(w => app.matchesWindow(w))[0];
        if (window === undefined) {
            launch(app.entry);
        } else {
            window.activate();
        }
    }

    function launch(entry: var) {
        if (entry.runInTerminal) {
            Quickshell.execDetached({
                command: ["footclient", entry.command],
                workingDirectory: entry.workingDirectory
            });
        } else {
            entry.execute();
        }
    }

    readonly property var applications: [...DesktopEntries.applications.values].map(entry => {
        let app = Object.create(appPrototype);

        app.entry = entry;

        app.keywords = entry.keywords.join(" ");
        app.searchKey = [entry.name, entry.genericName, entry.id, app.keywords].join(" ").toLowerCase();

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
