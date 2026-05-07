import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import auth.remote.AuthRepository 1.0
import presentation.UIStateManager 1.0
import ParmigianoDesktop.Templates 1.0
import "qrc:/qt/qml/ParmigianoDesktop/ui/js/validate.js" as Validate

Item {
    AuthRepository {
        id: authRepository
    }

    Connections {
        target: authRepository

        function onAuthFinished(action) {
            switch(action)
            {
            case AuthRepository.NavigateToVerifyCode:
                Navigation.goTo("VerifyCode");
                break;
            default:
                break;
            }
        }
    }

    Action {
        id: buttonClickAction
        onTriggered: {
            let name = createProfileEnterName.field.text;
            let username = createProfileEnterUsername.field.text;

            let checkName = Validate.validateName(name);
            let checkUsername = Validate.validateUsername(username);

            if (checkName && checkUsername)
            {
                console.log("yes");
                authRepository.createProfile(name, username, UIStateManager.email);
            }
            else
            {
                if (!checkName)
                {
                    Validate.playWrongAnimation(createProfileEnterName);
                }

                if (!checkUsername)
                {
                    Validate.playWrongAnimation(createProfileEnterUsername);
                }
            }
        }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: {
            arrowBack.mouseArea.clicked(null);
        }
    }

    Shortcut {
        sequence: "Return" // normal human enter
        onActivated: buttonClickAction.trigger()
    }

    Shortcut {
        sequence: "Enter" // NumPad enter
        onActivated: buttonClickAction.trigger()
    }

    ColumnLayout {
        width: parent.width
        height: 60
        spacing: 0

        Layout.topMargin: 0
        Layout.margins: 0

        NetworkStatusBanner {
            id: networkBanner

            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.preferredHeight: height
            Layout.maximumHeight: 35

            visible: height > 0
        }

        RowLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height

            ArrowBack {
                id: arrowBack

                Layout.preferredWidth: 40
                Layout.preferredHeight: 30

                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.margins: 15
            }

            SwitchLanguageMenu {
                id: langSwitcher

                Layout.preferredWidth: 45
                Layout.preferredHeight: 30

                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                Layout.margins: 15
            }
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

            buttonTextDefault: qsTr("CONTINUE")
            buttonTextLoading: qsTr("LOADING")

            //buttonText: qsTr("DONE")
            mouseArea.onClicked: buttonClickAction.trigger()
        }
    }
}
