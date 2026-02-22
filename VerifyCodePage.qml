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
            text: "Код подтверждения"
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: "Введите полученный проверочный код для подтверждения вашей учётной записи."
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.bottomMargin: 35
            Layout.alignment: Qt.AlignCenter
            Layout.leftMargin: 25
            Layout.rightMargin: 25
            spacing: 15

            Repeater {
                id: repeater
                model: 6

                TextField {
                    required property int index

                    id: codeField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 0
                    Layout.preferredHeight: implicitHeight * 1.3
                    selectionColor: "#053ba7"
                    font.pointSize: 20
                    color: "white"
                    maximumLength: 1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    cursorVisible: false

                    background: Rectangle {
                        width: codeField.width
                        height: codeField.height
                        color: "#18222d"
                        border.color: codeField.focus ? "#3390ec" : "#333"
                        border.width: 1.4
                        radius: 5
                    }

                    // Returning num which referred to the end of the code
                    function focusAtEnd() {
                        for (let i = 0; i < repeater.count; ++i)
                        {
                            let target = repeater.itemAt(i);

                            if (!target.text)
                            {
                                return i;
                            }
                        }
                    }

                    // Set necessary focus on clicking to any field
                    MouseArea {
                        id: codeFieldArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            let focus = focusAtEnd();
                            let target = repeater.itemAt(focus);

                            if(target)
                            {
                                target.forceActiveFocus()
                            }
                        }
                    }

                    // Parsing pressed button 1-9 and BACKSPACE (just input)
                    Keys.onPressed: (event) => {
                        // 1-9
                        if (event.key > Qt.Key_0 && event.key < Qt.Key_9)
                        {
                            if (index !== (repeater.count - 1))
                            {
                                nextItemInFocusChain(true).forceActiveFocus();
                            }

                            return;
                        }

                        // BACKSPACE
                        if (event.key === Qt.Key_Backspace)
                        {
                            if ((index !== (repeater.count - 1) && index !== 0)
                                || (index === (repeater.count - 1) && text.length === 0))
                            {
                                let target = repeater.itemAt(index - 1);

                                target.text = "";
                                target.forceActiveFocus()
                            }

                            return;
                        }

                        if (event.matches(StandardKey.Paste))
                        {
                            //console.log("123");
                            let focus = focusAtEnd();
                            let target = repeater.itemAt(focus);



                            if (index === (repeater.count - 1))
                            return;
                        }
                    }

                    // Disable tab/backTab inside code fields
                    Keys.onBacktabPressed: (event) => {}
                    Keys.onTabPressed: (event) => {}

                    // Only digitals
                    validator: IntValidator {}

                    // Disable cursor on inputing
                    cursorDelegate: Item {
                        visible: false
                    }
                }
            }
        }

        Rectangle {
            id: verifyCodeConfirmButton
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
    }
}
