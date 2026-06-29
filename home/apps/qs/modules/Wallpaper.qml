import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.services

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow { // qmllint disable uncreatable-type
            id: root

            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }

            required property var modelData
            screen: modelData

            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore

            color: "transparent"

            readonly property string path: WallpaperService.path

            onPathChanged: {
                if (root.path === "") {
                    return;
                }
                nextWallpaper.source = root.path;
            }

            Image {
                id: currentWallpaper
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                visible: status === Image.Ready
            }

            Image {
                id: nextWallpaper
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                opacity: 0.0
                asynchronous: true

                onStatusChanged: {
                    if (status == Image.Ready) {
                        wallpaperAnimation.start();
                    }
                }
            }

            SequentialAnimation {
                id: wallpaperAnimation

                NumberAnimation {
                    target: nextWallpaper
                    property: "opacity"
                    to: 1.0
                    duration: 500
                    easing.type: Easing.InOutQuad
                }

                ScriptAction {
                    script: {
                        currentWallpaper.source = nextWallpaper.source;
                        nextWallpaper.opacity = 0.0;
                        nextWallpaper.source = "";
                    }
                }
            }
        }
    }
}
