import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.preferredWidth: parent.width * 0.35
            Layout.fillHeight: true
            color: "#17212b"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: searchRow.implicitHeight + 20
                    Layout.margins: 10
                    color: "#1c2733"
                    radius: 15

                    RowLayout {
                        id: searchRow
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 20
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10

                        spacing: 10

                        Item {
                            Layout.preferredWidth: 25
                            Layout.preferredHeight: 30

                            Image {
                                id: burgerMenuImage
                                anchors.fill: parent
                                source: "qrc:/assets/burger_menu.svg"
                                fillMode: Image.PreserveAspectFit
                            }

                            MultiEffect {
                                source: burgerMenuImage
                                anchors.fill: burgerMenuImage

                                colorization: 1
                                brightness: 1
                                colorizationColor: "#708499"
                            }

                            MouseArea {
                                id: burgerMenuArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                            }
                        }

                        TextField {
                            id: searchField
                            Layout.fillWidth: true
                            Layout.preferredHeight: implicitHeight * 1.5
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 15
                            rightPadding: 15
                            placeholderText: "Поиск 67"
                            placeholderTextColor: "#7d7d7d"
                            color: "white"
                            font.pointSize: 10
                            selectionColor: "#053ba7"
                            selectByMouse: true

                            background: Rectangle {
                                color: "#242f3d"
                                radius: 15
                            }
                        }
                    }


                    // ColumnLayout {
                    //     width: parent.width
                    //     height: childrenRect.height + 10
                    //     //anchors.margins: 10

                    //     //anchors.fill: parent
                    //     // anchors.leftMargin: 20
                    //     // anchors.rightMargin: 20
                    //     // anchors.topMargin: 10
                    //     // anchors.bottomMargin: 10
                    //     //spacing: 10


                    //     // ListView {
                    //     //     Layout.fillWidth: true
                    //     //     Layout.preferredHeight: parent.height * 0.4
                    //     //     orientation: ListView.Horizontal
                    //     // }
                    // }
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    orientation: ListView.Vertical
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#0f1621"
        }
    }
}
