import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    Rectangle {
        width: 40
        height: 30
        color: "transparent"

        anchors.left: parent.left
        anchors.top: parent.top

        anchors.topMargin: 15
        anchors.leftMargin: 15

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

    ColumnLayout {
        width: 350
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            Layout.preferredWidth: 125
            Layout.preferredHeight: 125
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 20
            color: "#4ca2f1"
            radius: 100

            Image {
                id: avatarImage
                width: parent.width * 0.4
                height: parent.height * 0.4
                anchors.centerIn: parent
                source: "qrc:/assets/camera.svg"
            }

            MultiEffect {
                source: avatarImage
                anchors.fill: avatarImage

                colorization: 1.0
                brightness: 1.0
                colorizationColor: "#fff"
            }

            // MouseArea {
            //     id: avatarArea
            //     anchors.fill: parent
            //     hoverEnabled: true
            //     cursorShape: Qt.PointingHandCursor
            // }
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            text: "Создайте профиль"
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: "Заполните данные профиля, чтобы начать общение."
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        TextField {
            id: createProfileEnterName
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            verticalAlignment: Text.AlignVCenter
            Layout.bottomMargin: 15
            leftPadding: 15
            placeholderText: "Имя"
            placeholderTextColor: "#7d7d7d"
            color: "white"
            font.pointSize: 12
            selectionColor: "#053ba7"

            background: Rectangle {
                width: createProfileEnterName.width
                height: createProfileEnterName.height
                color: "#18222d"
                border.color: createProfileEnterName.focus ? "#3390ec" : "#333"
                border.width: 1.4
                radius: 5
            }
        }

        TextField {
            id: createProfileEnterUsername
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            verticalAlignment: Text.AlignVCenter
            Layout.bottomMargin: 25
            leftPadding: 15
            placeholderText: "Тег @username"
            placeholderTextColor: "#7d7d7d"
            color: "white"
            font.pointSize: 12
            selectionColor: "#053ba7"

            background: Rectangle {
                width: createProfileEnterUsername.width
                height: createProfileEnterUsername.height
                color: "#18222d"
                border.color: createProfileEnterUsername.focus ? "#3390ec" : "#333"
                border.width: 1.4
                radius: 5
            }
        }

        Rectangle {
            id: confirmEmailConfirmButton
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: mouseArea.containsMouse ? "#4ea4f5" : "#3390ec"
            radius: 7

            Text {
                id: customButtonText
                text: qsTr("ГОТОВО")
                font.pointSize: 11
                font.bold: true
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
