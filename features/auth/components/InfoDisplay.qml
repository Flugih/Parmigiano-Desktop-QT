import QtQuick
import QtQuick.Controls
import QtQuick.Window

Item {
    id: root

    property alias messageWidth: infoDisplay.width
    property string displyText: ""

    anchors.fill: parent

    Timer {
        id: showMessageTimer
        interval: 250
        running: false
        repeat: false

        onTriggered: {
            infoDisplay.messageState = "display"
        }
    }

    function show(text) {
        //console.log("display");
        displyText = text;
        if (infoDisplay.messageState == "display")
        {
            infoDisplay.messageState = "hidden";
            showMessageTimer.start();
        }
        else
        {
            infoDisplay.messageState = "display";
        }
    }

    function hide() {
        infoDisplay.messageState = "hidden";
    }

    Rectangle {
        id: infoDisplay

        property string messageState: "hidden" // hidden/display
        state: messageState

        width: Math.min(Window.window ? Window.window.width * 0.4 : 300, mainText.implicitWidth + 80)

        height: 45
        color: "#212d3b"
        border.color: '#2f3e4e'
        radius: 10
        visible: false

        x: (Window.width - infoDisplay.width) / 2
        y: Window.height //- (infoDisplay.height + 25)

        Behavior on y {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCirc
            }
        }

        Behavior on visible {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCirc
            }
        }

        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: infoDisplay
                    visible: false
                    y: Window.height
                }
            },

            State {
                name: "display"
                PropertyChanges {
                    target: infoDisplay
                    visible: true
                    y: Window.height - (infoDisplay.height + 25)
                }
            }
        ]

        Row {
            id: displayRow

            anchors.fill: parent

            spacing: 15
            anchors.leftMargin: 15
            anchors.rightMargin: 15

            Text {
                id: mainText

                text: qsTr(displyText)
                color: "#fff"
                font.pointSize: 10
                width: displayRow.width - okButton.width - displayRow.spacing - displayRow.leftPadding - displayRow.rightPadding

                anchors.verticalCenter: parent.verticalCenter

                elide: Text.ElideRight
            }

            Rectangle {
                id: okButton

                color: okButtonMouseArea.containsMouse ? Qt.rgba(0.2, 0.56, 0.92, 0.15) : "transparent"
                radius: 5

                width: 35
                height: parent.height - 16
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }

                Text {
                    id: okButtonText

                    text: qsTr("OK")
                    font.pointSize: 10
                    color: "#3390ec"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea {
                    id: okButtonMouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        infoDisplay.messageState = "hidden";
                    }
                }
            }
        }
    }
}
