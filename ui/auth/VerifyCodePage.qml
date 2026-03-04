import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import ParmigianoDesktop as Logic
import ParmigianoDesktop.Animations 1.0
import ParmigianoDesktop.Templates 1.0
import "qrc:/qt/qml/ParmigianoDesktop/ui/js/validate.js" as Validate

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
            text: qsTr("Confirmation code") // Код подтверждения
            font.bold: true
            color: "white"
            font.pointSize: 18
        }

        Label {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 30
            text: qsTr("Enter the verification code to confirm your account.") // Введите полученный проверочный код для подтверждения вашей учётной записи.
            color: "#708499"
            font.pointSize: 11
            wrapMode: Text.WordWrap
        }

        Shake {
            id: fieldsShake

            shakeTarget: rowCodeFields
        }

        RowLayout {
            id: rowCodeFields

            Layout.fillWidth: true
            Layout.bottomMargin: 35
            Layout.alignment: Qt.AlignCenter
            Layout.leftMargin: 25
            Layout.rightMargin: 25
            spacing: 15

            Repeater {
                id: repeaterCodeFields
                model: 6

                Shake {
                    id: fieldShake

                    shakeTarget: repeaterCodeFields
                }


                delegate: TextField {
                    required property int index

                    property alias animationPulse: fieldPulse

                    id: codeField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 0
                    Layout.preferredHeight: implicitHeight * 1.2
                    selectionColor: "#053ba7"
                    font.pointSize: 20
                    color: "white"
                    maximumLength: 1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    cursorVisible: false
                    //activeFocusOnTab: false

                    BorderPulse {
                        id: fieldPulse

                        borderTarget: codeFieldBackground
                    }

                    background: Rectangle {
                        id: codeFieldBackground

                        width: codeField.width
                        height: codeField.height
                        color: "#18222d"
                        border.color: codeField.focus ? "#3390ec" : "#333"
                        border.width: 1.4
                        radius: 5
                    }

                    // ClipboardManager {
                    //     id: clipboardManager
                    // }

                    function getDigitalsFromString(string) {
                        let digitals = [];

                        for (let i = 0; i < string.length; ++i)
                        {
                            let ch = string[i];

                            if (ch > '0' && ch < '9')
                            {
                                digitals.push(ch);
                            }
                        }

                        return digitals;
                    }

                    // Returning num which referred to the end of the code
                    function focusAtEnd() {
                        for (let i = 0; i < repeaterCodeFields.count; ++i)
                        {
                            let target = repeaterCodeFields.itemAt(i);

                            if (!target.text)
                            {
                                return i;
                            }
                        }

                        return repeaterCodeFields.count - 1;
                    }

                    function setFocusAtEnd() {
                        let focus = focusAtEnd();
                        let target = repeaterCodeFields.itemAt(focus);

                        if (target)
                        {
                            target.forceActiveFocus()
                        }
                    }

                    // Set necessary focus on clicking to any field
                    MouseArea {
                        id: codeFieldArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            setFocusAtEnd()
                        }
                    }

                    // Parsing pressed button 1-9 and BACKSPACE (just input)
                    Keys.onPressed: (event) => {
                        // 1-9
                        if (event.key > Qt.Key_0 && event.key < Qt.Key_9)
                        {
                            if (index !== (repeaterCodeFields.count - 1))
                            {
                                nextItemInFocusChain(true).forceActiveFocus();
                            }

                            return;
                        }

                        // BACKSPACE
                        if (event.key === Qt.Key_Backspace)
                        {
                            if ((index !== (repeaterCodeFields.count - 1) && index !== 0)
                                || (index === (repeaterCodeFields.count - 1) && text.length === 0))
                            {
                                let target = repeaterCodeFields.itemAt(index - 1);

                                target.text = "";
                                target.forceActiveFocus();
                            }

                            return;
                        }

                        if (event.key === Qt.Key_Backspace &&
                            (event.modifiers & Qt.ControlModifier))
                        {
                            console.log("Нажата комбинация Ctrl+Backspace");
                        }

                        // CTRL+V / Paste
                        if (event.matches(StandardKey.Paste))
                        {
                            if (index === repeaterCodeFields.count - 1) return;

                            let clipboardText = Logic.clipboardManager.getClipboardData();
                            let digitals = getDigitalsFromString(clipboardText);

                            digitals = digitals.slice(0, repeaterCodeFields.count - index);

                            for (let i = 0; i < digitals.length; ++i)
                            {
                                let target = repeaterCodeFields.itemAt(i + index);

                                if (target)
                                {
                                    target.text = String(digitals[i]);
                                }
                            }

                            setFocusAtEnd();
                        }
                    }

                    onFocusChanged: {
                        if (focus && index == 0)
                        {
                            setFocusAtEnd();
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

        ButtonConfirm {
            id: verifyCodeConfirmButton

            Layout.fillWidth: true
            Layout.preferredHeight: 45

            buttonText: qsTr("DONE")
            mouseArea.onClicked: {
                let valid = Validate.verifyCodeValid(repeaterCodeFields);

                if (valid)
                {
                    console.log("all good");
                }
                else
                {
                    fieldsShake.start();

                    for (let i = 0; i < repeaterCodeFields.count; ++i)
                    {
                        let target = repeaterCodeFields.itemAt(i);

                        if (target)
                        {
                            target.animationPulse.start();
                            target.focus = false;
                        }
                    }
                }
            }
        }
    }
}
