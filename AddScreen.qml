import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: addScreen
    minimumWidth: 1080
    minimumHeight: 720
    height: 720
    property int fontScale: 15
    property string arr: ""

    Item {
        id: labels
        width: addScreen.minimumWidth / 4
        height: childrenRect.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10

        Label {
            id: labelName
            text: "Name:"
            font.pointSize: fontScale
        }

        Label {
            id: labelSurname
            text: "Surname:"
            anchors.top: labelName.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }

        Label {
            id: labelPosition
            text: "Position:"
            anchors.top: labelSurname.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }

        Label {
            id: labelAddress
            text: "Address:"
            anchors.top: labelPosition.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }

        Label {
            id: labelPhone
            text: "Phone:"
            anchors.top: labelAddress.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }

        Label {
            id: labelMartialStatus
            text: "Martial Status:"
            anchors.top: labelPhone.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }

        Label {
            id: labelCountries
            text: "Countries:"
            anchors.top: labelMartialStatus.bottom
            anchors.topMargin: 17
            font.pointSize: fontScale
        }
    }

    Item {
        id: fields
        width: addScreen.minimumWidth / 4
        height: parent.height//childrenRect.height
        anchors.left: labels.right
        anchors.top: parent.top
        anchors.margins: 10

        TextField {
            id: fieldName
            width: parent.width
            height: 50
        }

        TextField {
            id: fieldSurname
            width: parent.width
            anchors.top: fieldName.bottom
            anchors.topMargin: 15
            height: 50
        }

        TextField {
            id: fieldPosition
            width: parent.width
            anchors.top: fieldSurname.bottom
            anchors.topMargin: 15
            height: 50
        }

        TextField {
            id: fieldAddress
            width: parent.width
            anchors.top: fieldPosition.bottom
            anchors.topMargin: 15
            height: 50
        }

        TextField {
            id: fieldPhone
            width: parent.width
            anchors.top: fieldAddress.bottom
            anchors.topMargin: 15
            height: 50
        }

        TextField {
            id: fieldMartialStatus
            width: parent.width
            height: 50
            anchors.top: fieldPhone.bottom
            anchors.topMargin: 15
        }

        ListModel {
            id: listModelContries
        }

        TextField {
            id: fieldCountry
            width: parent.width
            height: 50
            anchors.top: fieldMartialStatus.bottom
            anchors.topMargin: 15
        }

        ListView {
            id: listView
            clip: true
            width: parent.width
            height: childrenRect.height
            anchors.top: fieldCountry.bottom
            anchors.bottom: parent.bottom
            anchors.left: labels.right
            anchors.right: addScreen.right
            anchors.bottomMargin: 80
            anchors.topMargin: 15
            spacing: 15
            model: listModelContries
            delegate: Item {
                id: item
                width: parent.width
                height: 50
                property string sss: textField.text

                TextField {
                    id: textField
                    anchors.fill: parent
                    width: parent.width
                    height: parent.height
                    onActiveFocusChanged: {
                        if (text != "")
                            arr += text + ","
                    }
                }
            }
        }
    }

    Button {
        id: save
        text: "Save"
        width: 200
        height: 50
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: {
            listView.focus = false
            arr = fieldCountry.text + "," + arr.slice(0, -1)
            var str = fieldName.text + "," + fieldSurname.text + "," + fieldPosition.text + "," + fieldAddress.text + "," + fieldPhone.text + "," + fieldMartialStatus.text + ";" + arr//fieldCountries.text
            dataBase.addPerson(str)
            dataBase.updateModel();
            fieldName.text = ""
            fieldSurname.text = ""
            fieldPosition.text = ""
            fieldAddress.text = ""
            fieldPhone.text = ""
            fieldMartialStatus.text = ""
            fieldCountry.text = ""
            listModelContries.clear();
            arr = ""
        }
    }

    Button {
        id: clear
        text: "Сlear"
        width: 200
        height: 50
        anchors.bottom: parent.bottom
        anchors.left: save.right
        anchors.margins: 10
    }

    Button {
        width: 200
        height: 50
        anchors.bottom: parent.bottom
        anchors.left: clear.right
        anchors.margins: 10
        text: "Add country"
        onClicked: {
            listModelContries.append({})
        }
    }
}
