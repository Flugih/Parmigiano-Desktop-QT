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
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            text: qsTr("Create profile") // Создайте профиль
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: qsTr("Fill in your profile information to start chatting.") // Заполните данные профиля, чтобы начать общение.
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        CustomInput {
            id: createProfileEnterName

            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.bottomMargin: 10

            fieldPlaceholderText: qsTr("Name")
        }

        CustomInput {
            id: createProfileEnterUsername

            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.bottomMargin: 15

            fieldPlaceholderText: qsTr("Tag @username")
        }

        ButtonConfirm {
            id: confirmEmailConfirmButton

            Layout.fillWidth: true
            Layout.preferredHeight: 45

            buttonText: qsTr("DONE")
            mouseArea.onClicked: {
                let name = createProfileEnterName.field.text;
                let username = createProfileEnterUsername.field.text;

                // console.log(name);

                Validate.checkValid(Validate.validateName(name), createProfileEnterName);
                Validate.checkValid(Validate.validateUsername(username), createProfileEnterUsername);
            }
        }
    }
}
