pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string directory: Quickshell.env("XDG_CACHE_HOME") + "/quickshell/launcher"
    readonly property string path: directory + "/usage.json"
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

        app.searchKey = [entry.name, entry.genericName, entry.id, entry.execString, entry.keywords.join(" "), entry.categories.join(" ")].join(" ").toLowerCase();

        let initialsSource = `${entry.name} ${entry.genericName}`.toLowerCase();
        app.searchInitials = initialsSource.split(/[-_\s]+/).map(c => c[0]).join("");

        app.score = usage.data[entry.id] ?? 0;

        return app;
    }).sort((a, b) => b.score - a.score)

    FileView {
        id: file
        path: root.path
        blockLoading: true

        watchChanges: true
        onFileChanged: reload()

        // qmllint disable unresolved-type
        adapter: JsonAdapter {
            id: usage
            property var data: ({})

            function record(id: string) {
                let newData = Object.assign({}, usage.data ?? {});
                newData[id] = Date.now();
                usage.data = newData;
                file.writeAdapter();
            }
        }

        onLoadFailed: handleFileViewError(error)
        onSaveFailed: handleFileViewError(error)

        function handleFileViewError(error) {
            switch (error) {
            case FileViewError.FileNotFound:
                Quickshell.execDetached(["mkdir", "-p", root.directory]);
                writeAdapter();
                return;
            default:
                console.warn("sorry, i'm not handling any other errors");
                return;
            }
        }
    }
}
