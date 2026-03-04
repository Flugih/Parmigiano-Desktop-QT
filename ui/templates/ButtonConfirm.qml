import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias mouseArea: buttonMouseArea
    property alias buttonText: buttonText.text

    Rectangle {
        id: button

        color: mouseArea.containsMouse ? "#4ea4f5" : "#3390ec"
        radius: 7
        anchors.fill: parent

        Text {
            id: buttonText

            font.pointSize: 11
            font.bold: true
            color: "white"
            anchors.centerIn: parent
        }

        MouseArea {
            id: buttonMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }
}
