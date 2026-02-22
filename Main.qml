import QtQuick
import QtQuick.Controls

Window {
    id: mainWindow
    width: 1000
    height: 640
    minimumWidth: 1000
    minimumHeight: 640
    visible: true
    title: qsTr("Parmigiano Chat")
    color: "#18222d"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "VerifyCodePage.qml"
    }
}
