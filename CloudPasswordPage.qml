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

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            text: "Облачный пароль"
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: "Укажите облачный пароль от вашего аккаунта - он нужен для безопасного доступа к данным."
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        TextField {
            id: cloudPasswordEnterPassword
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            verticalAlignment: Text.AlignVCenter
            Layout.bottomMargin: 15
            leftPadding: 15
            placeholderText: "Облачный пароль"
            echoMode: TextField.Password
            placeholderTextColor: "#7d7d7d"
            color: "white"
            font.pointSize: 12
            selectionColor: "#053ba7"

            background: Rectangle {
                width: cloudPasswordEnterPassword.width
                height: cloudPasswordEnterPassword.height
                color: "#18222d"
                border.color: cloudPasswordEnterPassword.focus ? "#3390ec" : "#333"
                border.width: 1.4
                radius: 5
            }
        }

        Rectangle {
            id: cloudPasswordConfirmButton
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: buttonArea.containsMouse ? "#4ea4f5" : "#3390ec"
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
                id: buttonArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }

        Text {
            text: "Забыли пароль?"
            color: "#4ea4f5"
            Layout.topMargin: 15
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            font.bold: true
            font.underline: forgotPasswordArea.containsMouse

            MouseArea {
                id: forgotPasswordArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
