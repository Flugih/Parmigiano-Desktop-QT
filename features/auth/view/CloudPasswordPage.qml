import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import ParmigianoDesktop.Templates 1.0
import "qrc:/qt/qml/ParmigianoDesktop/ui/js/validate.js" as Validate

Item {
    ArrowBack {
        id: arrowBack

        width: 40
        height: 30

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.leftMargin: 15
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
            text: qsTr("Cloud password") // Облачный пароль
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: qsTr("Enter your cloud password for your account, which is required for secure access to your data.") // Укажите облачный пароль от вашего аккаунта - он нужен для безопасного доступа к данным.
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        CustomInput {
            id: cloudPasswordEnterPassword

            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.bottomMargin: 15

            fieldPlaceholderText: qsTr("Cloud password") // Облачный пароль
        }

        ButtonConfirm {
            id: cloudPasswordConfirmButton

            Layout.fillWidth: true
            Layout.preferredHeight: 45

            buttonText: qsTr("DONE") // ГОТОВО
            mouseArea.onClicked: {
                let password = cloudPasswordEnterPassword.field.text;
                Validate.checkValid(Validate.validatePassword(password), cloudPasswordEnterPassword)
            }
        }

        Text {
            text: qsTr("Forgot your password?") // Забыли пароль?
            color: "#4ea4f5"
            Layout.topMargin: 10
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
