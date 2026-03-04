import QtQuick

SequentialAnimation {
    id: animation

    property Item borderTarget

    running: false

    ColorAnimation {
        to: "#FF0800";
        duration: 150
        easing.type: Easing.InOutQuad
        target: borderTarget;
        property: "border.color";
    }

    ColorAnimation {
        to: "#333";
        duration: 300
        easing.type: Easing.InOutQuad
        target: borderTarget;
        property: "border.color";
    }
}

// Item {
//     id: root

//     property Item borderTarget

//     function start() {
//         if (borderTarget && borderTarget.border !== undefined)
//             animation.start();
//     }

//     SequentialAnimation {
//         id: animation

//         running: false

//         ColorAnimation {
//             to: "#FF0800";
//             duration: 100
//             easing.type: Easing.InOutQuad
//             target: borderTarget;
//             property: "border.color";
//         }

//         ColorAnimation {
//             to: "#333";
//             duration: 100
//             easing.type: Easing.InOutQuad
//             target: borderTarget;
//             property: "border.color";
//         }
//     }
// }
