import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import ParmigianoDesktop.Templates 1.0
import "qrc:/qt/qml/ParmigianoDesktop/ui/js/validate.js" as Validate

Item {
    ColumnLayout {
        width: 350
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            text: qsTr("Your email") // Ваша почта
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: qsTr("Please enter your email address to log in.") // Пожалуйста, введите ваш адрес электронной почты для входа.
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        CustomInput {
            id: confirmEmailEnterEmail

            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.bottomMargin: 15

            fieldPlaceholderText: qsTr("example@mail.com")
        }

        ButtonConfirm {
            id: confirmEmailConfirmButton

            Layout.fillWidth: true
            Layout.preferredHeight: 45

            buttonText: qsTr("CONTINUE") // ПРОДОЛЖИТЬ
            mouseArea.onClicked: {
                let email = confirmEmailEnterEmail.field.text;
                Validate.checkValid(Validate.validateEmail(email), confirmEmailEnterEmail);
            }
        }
    }
}
