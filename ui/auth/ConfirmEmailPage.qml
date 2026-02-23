import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import "../js/logic.js" as Logic

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

        TextField {
            id: confirmEmailEnterEmail
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            verticalAlignment: Text.AlignVCenter
            Layout.bottomMargin: 15
            leftPadding: 15
            placeholderText: qsTr("example@mail.com")
            placeholderTextColor: "#7d7d7d"
            color: "white"
            font.pointSize: 12
            selectionColor: "#053ba7"

            property alias borderColor: emailEnterBackground.border.color

            background: Rectangle {
                id: emailEnterBackground
                width: confirmEmailEnterEmail.width
                height: confirmEmailEnterEmail.height
                color: "#18222d"
                border.color: confirmEmailEnterEmail.focus ? "#3390ec" : "#333"
                border.width: 1.4
                radius: 5
            }

            onTextChanged: {
                if (borderColor.toString() !== "#3390ec" && borderColor.toString() !== "#333")
                {
                    Logic.changeColor(confirmEmailEnterEmail, "borderColor", "#3390ec");
                }
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
                text: qsTr("CONTINUE") // ПРОДОЛЖИТЬ
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

                onClicked: {
                    let email = confirmEmailEnterEmail.text

                    if (Logic.validateEmail(email))
                    {
                        console.log("all right")
                    }
                    else
                    {
                        Logic.changeColor(confirmEmailEnterEmail, "borderColor", "#FF0800");
                    }
                }
            }
        }
    }
}
