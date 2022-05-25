import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12

Window {
    width: 1080
    height: 720
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listView
        width: parent.width
        height: childrenRect.height
        model: dataBase
        clip: true
        delegate: Item {
            width: parent.width
            height: 50
            Label {
                id: nameText
                text: name
            }

            Label {
                id: surnameText
                anchors.left: nameText.right
                anchors.leftMargin: 10
                text: surname
            }

            Button {
                anchors.left: surnameText.right
                anchors.leftMargin: 10
                text: "delete"
            }

//            Rectangle {
//                anchors.fill: parent
//                color: "red"
//            }
        }
    }

//    TableView {
//        width: parent.width
//        height: parent.height / 1.5
//        model: dataBase
//        TableViewColumn {
//            role: "name"    // These roles are roles names coincide with a C ++ model
//            title: "name"
//        }

//        TableViewColumn {
//            role: "surname"    // These roles are roles names coincide with a C ++ model
//            title: "surname"
//        }

//        TableViewColumn {
//            role: "position"  // These roles are roles names coincide with a C ++ model
//            title: "position"
//        }
//        TableViewColumn {
//            role: "address"  // These roles are roles names coincide with a C ++ model
//            title: "address"
//        }
//        TableViewColumn {
//            role: "phone"  // These roles are roles names coincide with a C ++ model
//            title: "phone"
//        }
//        TableViewColumn {
//            role: "martialStatus"  // These roles are roles names coincide with a C ++ model
//            title: "martialStatus"
//        }
//    }
}
