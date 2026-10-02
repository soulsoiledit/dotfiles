pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import Quickshell.Wayland

// TODO: add notification grouping
Singleton {
    id: root

    readonly property int maxHistory: 10
    readonly property string restoredKey: "isRestored"

    property alias notificationHistory: server.trackedNotifications.values
    property list<Notification> shownNotifications: []

    function notifyOsd(tag: string, args: list<var>): var {
        Quickshell.execDetached(["notify-send", "-u", "low", "-t", 1250, "-h", `string:x-canonical-private-synchronous:${tag}`, ...args]);
    }

    function hide(notification: Notification): void {
        let index = shownNotifications.indexOf(notification);
        if (index !== -1) {
            hideByIndex(index);
        }
    }

    function hideByIndex(index: int): void {
        NotificationService.shownNotifications.splice(index, 1);
    }

    function invoke(notification: Notification, index = undefined) {
        index === undefined ? hide(notification) : hideByIndex(index);

        let action = notification.actions.find(a => a.identifier === "default"); // qmllint disable unresolved-type
        if (action !== undefined) {
            action.invoke();
            const notifAppId = DesktopEntries.heuristicLookup(notification.desktopEntry).startupClass;
            if (notifAppId !== null) {
                ToplevelManager.toplevels.values.find(w => w.appId === notifAppId)?.activate();
            }
        }
    }

    NotificationServer {
        id: server

        keepOnReload: false
        persistenceSupported: true
        bodyMarkupSupported: true
        bodyHyperlinksSupported: true
        // TODO: add action buttons in the future (maybe)
        actionsSupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;
            show(notification);
            pruneHistory();
        }

        function getSynchronousTag(notification: Notification): var {
            return notification.hints["x-canonical-private-synchronous"] || notification.hints["x-dunst-stack-tag"];
        }

        function show(notification: Notification): void {
            const tag = getSynchronousTag(notification);
            if (tag !== undefined) {
                const oldIndex = root.shownNotifications.findIndex(n => tag === getSynchronousTag(n));
                if (oldIndex !== -1) {
                    const oldNotif = root.shownNotifications.splice(oldIndex, 1, notification)[0];
                    oldNotif.expire();
                    return;
                }
            }

            root.shownNotifications.push(notification);
        }

        function findDismissed(): var {
            return root.notificationHistory.find(n => !root.shownNotifications.includes(n));
        }

        function findLastDismissed(): var {
            for (let i = root.notificationHistory.length - 1; i > -1; i--) {
                const notif = root.notificationHistory[i];
                if (!root.shownNotifications.includes(notif)) {
                    return notif;
                }
            }

            return undefined;
        }

        function pruneHistory(): void {
            while (root.notificationHistory.length > root.maxHistory) {
                const notif = findDismissed();
                if (notif !== undefined) {
                    notif.expire();
                } else {
                    break;
                }
            }
        }
    }

    IpcHandler {
        target: "notify"

        function dismiss(): void {
            root.shownNotifications.pop();
        }

        function dismissAll(): void {
            while (root.shownNotifications.length > 0) {
                root.shownNotifications.pop();
            }
        }

        function restore(): void {
            const lastNotif = server.findLastDismissed();
            if (lastNotif !== undefined) {
                lastNotif[root.restoredKey] = true;
                server.show(lastNotif);
            }
        }

        function invoke(): void {
            const notif = root.shownNotifications[0];
            if (notif !== undefined) {
                root.invoke(notif);
            }
        }

        function list(): string {
            return JSON.stringify(root.shownNotifications);
        }

        function history(): string {
            return JSON.stringify(root.notificationHistory);
        }
    }
}
