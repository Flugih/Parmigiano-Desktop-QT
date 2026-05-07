import QtQuick
import QtQuick.Controls

import ParmigianoDesktop.FeatureAuth 1.0

Item {
    id: root

    property alias borderColor: fieldBackground.border.color
    property alias fieldPlaceholderText: field.placeholderText
    property alias fieldEchoMode: field.echoMode
    property alias wrongAnimation: wrongInputAnimation
    property alias field: field

    property bool hasError: false

    ParallelAnimation {
        id: wrongInputAnimation

        running: false

        BorderPulse {
            id: fieldPulse

            borderTarget: fieldBackground
        }

        Shake {
            id: fieldShake

            shakeTarget: root
        }
    }

    TextField {
        id: field

        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: 15
        placeholderTextColor: "#7d7d7d"
        color: "white"
        font.pointSize: 12
        selectionColor: "#053ba7"

        TapHandler {
            acceptedButtons: Qt.RightButton
            onTapped: contextMenu.menu.popup()
        }

        TextContextMenu {
            id: contextMenu

            target: field
        }

        background: Rectangle {
            id: fieldBackground

            width: fieldBackground.width
            height: fieldBackground.height
            color: "#18222d"
            border.color: "#2f3e4e"
            border.width: 1.4
            radius: 5
        }

        function colorDefine(focus, hasError) {
            if (!focus && !hasError)
            {
                borderColor = "#2f3e4e";
            }
            else if (!focus && hasError)
            {
                borderColor = "#ff0800";
            }
            else if (focus)
            {
                borderColor = "#3390ec";
            }
        }

        onFocusChanged: {
            colorDefine(focus, hasError);
        }

        onTextChanged: {
            colorDefine(focus, hasError);
        }
    }
}
