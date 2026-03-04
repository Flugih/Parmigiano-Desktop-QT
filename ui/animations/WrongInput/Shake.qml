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


// Item {
//     id: root

//     function start() {
//         animation.start();
//     }

//     SequentialAnimation {
//         id: animation

//         running: false

//         NumberAnimation {
//             to: 10
//             duration: 70
//             easing.type: Easing.InOutQuad
//             target: parent
//             property: "x"
//         }

//         NumberAnimation {
//             to: -10
//             duration: 120
//             easing.type: Easing.OutBounce
//             target: parent
//             property: "x"
//         }

//         NumberAnimation {
//             to: 0
//             duration: 150
//             easing.type: Easing.OutBounce
//             target: parent
//             property: "x"
//         }
//     }
// }
