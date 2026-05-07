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
