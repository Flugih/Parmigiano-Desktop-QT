import QtQuick
import QtQuick.Controls

import ParmigianoDesktop.Animations 1.0

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

        background: Rectangle {
            id: fieldBackground

            width: fieldBackground.width
            height: fieldBackground.height
            color: "#18222d"
            border.color: "#333"
            border.width: 1.4
            radius: 5
        }

        onFocusChanged: {
            if (!focus && !hasError)
            {
                borderColor = "#333";
            }
            else if (!focus && hasError)
            {
                borderColor = "#FF0800";
            }
            else if (focus)
            {
                borderColor = "#3390ec";
            }
        }

        // onTextChanged: {
        //     if (borderColor !== "#3390ec")
        //     {
        //         borderColor = "#3390ec";
        //     }
        // }
    }
}
