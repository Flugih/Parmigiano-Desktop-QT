import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias menu: contextMenu
    property Item target

    Menu {
        id: contextMenu

        implicitWidth: 200

        topPadding: 5
        bottomPadding: 5
        leftPadding: 5
        rightPadding: 5

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 60
            }

            NumberAnimation {
                property: "scale"
                from: 0.9
                to: 1.0
                duration: 60
            }
        }

        delegate: MenuItem {
            id: menuItem

            implicitWidth: 200
            implicitHeight: 35

            contentItem: Item {
                Text {
                    text: menuItem.text
                    font.pointSize: 10
                    color: "#fff"

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text:  menuItem.action.shortcut || ""
                    font.pointSize: 10
                    color: "#708499"

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            background: Rectangle {
                anchors.fill: parent
                color: menuItem.hovered ? "#323d4a" : "#212d3b"
                radius: 5

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        background: Rectangle {
            anchors.fill: parent

            color: "#212d3b"
            border.color: '#2f3e4e'
            radius: 10
        }

        Action {
            text: qsTr("Copy")
            shortcut: "Ctrl+C"

            onTriggered: {
                if (target && target.copy)
                {
                    target.copy()
                };
            }
        }

        Action {
            text: qsTr("Paste")
            shortcut: "Ctrl+V"

            onTriggered: {
                if (target && target.paste)
                {
                    target.paste()
                }
            }
        }

        Action {
            text: qsTr("Cut")
            shortcut: "Ctrl+X"

            onTriggered: {
                if (target && target.cut)
                {
                    target.cut()
                }
            }
        }

        MenuSeparator {
            topPadding: 2
            bottomPadding: 2

            contentItem: Rectangle {
                implicitWidth: 200
                implicitHeight: 1
                color: "#2f3e4e"
            }
        }

        Action {
            text: qsTr("Select all")
            shortcut: "Ctrl+A"

            onTriggered: {
                if (target && target.selectAll)
                {
                    target.selectAll()
                }
            }
        }
    }
}
