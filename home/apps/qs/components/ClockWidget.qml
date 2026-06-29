import QtQuick
import QtQuick.Layouts

import qs.components.shared
import qs.services

QsText {
    Layout.alignment: Qt.AlignHCenter
    text: TimeService.datetime
    horizontalAlignment: QsText.AlignHCenter
}
