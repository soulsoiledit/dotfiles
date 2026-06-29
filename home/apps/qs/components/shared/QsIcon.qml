import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolButton {
    id: root

    Layout.alignment: Qt.AlignHCenter

    required property int size
    required property string name

    icon.name: name
    icon.width: size
    icon.height: size

    background: null
    padding: 0
}
