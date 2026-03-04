import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: root

    Rectangle {
        id: imageContainer

        color: "transparent"
        anchors.fill: parent

        Image {
            id: arrowBack

            sourceSize: Qt.size(30, 30)
            anchors.centerIn: parent
            source: "qrc:/assets/arrow_back.svg"
        }

        MultiEffect {
            source: arrowBack

            anchors.fill: arrowBack
            colorization: 1.0
            brightness: imageArea.containsMouse ? 1.0 : 0.0
            colorizationColor: imageArea.containsMouse ? "#fff" : "#708499"

            Behavior on colorizationColor {
                ColorAnimation {
                    duration: 200
                }
            }
        }

        MouseArea {
            id: imageArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }
}
