import QtQuick
import QtQuick.Controls

import ParmigianoDesktop as Logic
import ParmigianoDesktop.FeatureAuth

Window {
    id: mainWindow
    width: 1000
    height: 640
    minimumWidth: 1000
    minimumHeight: 640
    visible: true
    title: qsTr("Parmigiano Chat")
    color: "#18222d"

    readonly property var pagesURI: {
        // AUTH
        "Login": makeAuthPageURI("Login"),
        "CreateProfile": makeAuthPageURI("CreateProfile"),
        "VerifyCode": makeAuthPageURI("VerifyCode"),
        "CloudPassword": makeAuthPageURI("CloudPassword"),

        // MESSENGER
    }

    function makeAuthPageURI(pageId) {
        return "qrc:/qt/qml/ParmigianoDesktop/AuthPages/ui/auth/" + pageId + "Page.qml";
    }

    function makeMessengerPageURI(pageId) {
        return "qrc:/qt/qml/ParmigianoDesktop/MessengerPages/ui/messenger/" + pageId + "Page.qml";
    }

    Connections {
        target: Navigation

        function onNavigateTo(pageId) {
            stackView.push(pagesURI[pageId])
        }

        function onNavigateBack() {
            if (stackView.depth > 1)
            {
                stackView.pop()
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: LoginPage {}
    }
}
