import QtQuick

SequentialAnimation {
    id: animation

    property Item shakeTarget

    running: false

    NumberAnimation {
        to: shakeTarget.x + 10
        duration: 70
        easing.type: Easing.InOutQuad
        target: shakeTarget
        property: "x"
    }

    NumberAnimation {
        to: shakeTarget.x - 10
        duration: 70
        easing.type: Easing.OutBounce
        target: shakeTarget
        property: "x"
    }

    NumberAnimation {
        to: shakeTarget.x + 10
        duration: 70
        easing.type: Easing.InOutQuad
        target: shakeTarget
        property: "x"
    }

    NumberAnimation {
        to: shakeTarget.x
        duration: 150
        easing.type: Easing.OutBounce
        target: shakeTarget
        property: "x"
    }
}
