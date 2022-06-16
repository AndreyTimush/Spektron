import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12

Window {
    id: root
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
            color: "lightblue"
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
                width: parent.width / 4
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
                            var component = Qt.createComponent("qml/AddScreen.qml")
                            var window = component.createObject(root)
                            window.show()
                        }
                    }
                }
            }

            Item {
                id: itemListFiles
                width: parent.width / 4
                height: parent.height
                anchors.left: itemAdd.right
                Image {
                    id: listFilesImage
                    height: parent.height
                    width: height
                    source: "qrc:/data/images/listFiles.svg"
                }
                Text {
                    id: showFiles
                    text: "list files"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: listFilesImage.right
                    anchors.leftMargin: 10
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var component = Qt.createComponent("qml/ListFilesScreen.qml")
                        var window = component.createObject(root)
                        window.show()
                    }
                }
            }

            Item {
                id: itemRemove
                width: parent.width / 4
                height: parent.height
                anchors.left: itemListFiles.right
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
                width: parent.width / 4
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 10

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
                        onClicked: {
                            var component = Qt.createComponent("qml/EditScreen.qml")
                            var window = component.createObject(root)
                            window.idPerson = dataBase.get(listView.currentIndex).idPerson
                            dataBase.countries(dataBase.get(listView.currentIndex).idPerson)
                            dataBase.getPerson(dataBase.get(listView.currentIndex).idPerson)
                            window.show()
                            print("id = ", dataBase.get(listView.currentIndex).idPerson)
                        }
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
                color: "black"
            }

            Item {
                id: nameItemLabel
                width: parent.width / 3
                anchors.left: parent.left
                anchors.leftMargin: 10
                Label {
                    id: nameLabel
                    text: "Name"
                    color: "white"
                }
            }

            Item {
                id: surnameItemLabel
                width: parent.width / 3
                anchors.left: nameItemLabel.right
                anchors.leftMargin: 10

                Label {
                    id: surnameLabel
                    text: "Surname"
                    color: "white"
                }
            }

            Item {
                id: positionItemLabel
                width: parent.width / 3
                anchors.left: surnameItemLabel.right
                anchors.leftMargin: 10

                Label {
                    id: positionLabel
                    text: "Position"
                    color: "white"
                }
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

            Item {
                id: itemName
                width: parent.width / 3
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: 10
                Label {
                    id: nameText
                    text: name
                }
            }

            Item {
                id: surnameItem
                width: parent.width / 3
                height: parent.height
                anchors.left: itemName.right
                anchors.leftMargin: 10
                Label {
                    id: surnameText
                    text: surname
                }
            }

            Item {
                width: parent.width / 3
                height: parent.height
                anchors.left: surnameItem.right
                anchors.leftMargin: 10
                Label {
                    id: positionText
                    text: position
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                }

                onDoubleClicked: {
                    var component = Qt.createComponent("qml/InfoScreen.qml")
                    var window = component.createObject(root)
                    dataBase.countries(idPerson)
                    window.show()
                }
            }
        }
    }
}
