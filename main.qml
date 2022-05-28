import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12

Window {
    minimumWidth: 1080
    minimumHeight: 720
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listView
        anchors.fill: parent
        model: dataBase
        clip: true
        header: headerDelegate
        footer: footerDelegate
        delegate: delegateItem
        headerPositioning: ListView.OverlayHeader
        footerPositioning: ListView.OverlayFooter
        highlightMoveDuration: 100
        highlightResizeDuration: 1
        focus: true
        highlight: Rectangle {
            color: "grey"
        }
        highlightFollowsCurrentItem: true
    }

    Component {
        id: footerDelegate
        Item {
            id: footer
            height: 50
            width: parent.width
            z: 2

            Rectangle {
                id: backgr
                anchors.fill: parent
                color: "lightgray"
            }

            Item {
                id: itemAdd
                width: parent.width / 3
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: 10

                Item {
                    width: childrenRect.width
                    height: parent.height

                    Image {
                        id: addPersonImage
                        height: parent.height
                        width: height
                        source: "qrc:/data/images/add.svg"
                    }

                    Text {
                        text: "Add"
                        anchors.left: addPersonImage.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            print("currentIndex is ", listView.currentIndex)
                        }
                    }
                }
            }

            Item {
                id: itemRemove
                width: parent.width / 3
                height: parent.height
                anchors.left: itemAdd.right
                Item {
                    width: childrenRect.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        id: removePersonImage
                        height: parent.height
                        width: height
                        source: "qrc:/data/images/remove.svg"
                    }

                    Text {
                        text: "Remove"
                        anchors.left: removePersonImage.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            dataBase.removePerson(dataBase.get(listView.currentIndex).idPerson)
                            dataBase.updateModel()
                        }
                    }
                }
            }
            Item {
                id: itemEdit
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 10
//                anchors.left: itemRemove.right

                Item {
                    width: childrenRect.width
                    height: parent.height
                    anchors.right: parent.right

                    Image {
                        id: editPersonImage
                        height: parent.height
                        width: height
                        source: "qrc:/data/images/edit.svg"
                    }

                    Text {
                        text: "Edit"
                        anchors.left: editPersonImage.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
//                        onClicked: print("id = ", surname)
                    }
                }
            }
        }
    }


    Component {
        id: headerDelegate
        Item {
            z: 2
            width: parent.width
            height: 50
            Rectangle {
                anchors.fill: parent
                color: "silver"
            }

            Label {
                id: nameLabel
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "Name"
            }

            Label {
                id: surnameLabel
                text: "Surname"
                anchors.left: nameLabel.right
                anchors.leftMargin: parent.width / 3
            }

            Label {
                id: positionLabel
                text: "Position"
                anchors.right: parent.right
                anchors.rightMargin: 10
            }

            Rectangle {
                height: 2
                color: "black"
                width: parent.width
                anchors.top: nameLabel.bottom
                anchors.topMargin: 10
            }
        }
    }

    Component {
        id: delegateItem
        Item {
            width: listView.width
            height: 50

            Label {
                id: nameText
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: name
            }

            Label {
                id: surnameText
                anchors.left: nameText.right
                anchors.leftMargin: parent.width / 3
                text: surname
            }

            Label {
                id: positionText
                text: position
                anchors.right: parent.right
                anchors.rightMargin: 10
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                    print("index = ", idPerson)
                }
            }
        }
    }
}
