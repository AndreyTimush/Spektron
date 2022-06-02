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
    property var idPerson
    property string arr1: ""
    property string strCountries: ""

    function findElement(myModel, text) {
            for(var i = 0; i < myModel.count; i++) {
                var element = myModel.get(i);

                if(text == element.text) {
                    console.log("Found element: ", i);
                    return element.text;
                }
            }
            return "";
        }

    Connections {
        target: dataBase

        onSendInfoPerson: {
            fieldName.text = list[0]
            fieldSurname.text = list[1]
            fieldPosition.text = list[2]
            fieldAddress.text = list[3]
            fieldPhone.text = list[4]
            fieldMartialStatus.text = list[5]
        }

        onSendCountries: {
            arr = ""
            fieldCountry.text = listCountries[0]
            for (var i = 1; i < listCountries.length; i++) {
                listModelContries.append({ttt: listCountries[i]})
            }
        }
    }

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
            anchors.right: parent.right
            anchors.bottomMargin: 80
            anchors.topMargin: 15
            spacing: 15
            model: listModelContries
            delegate: TextField {
                id: textField
                width: parent.width
                height: 50
                text: ttt != undefined ? ttt : ""
                onActiveFocusChanged: {
                    if (text != "")
                        arr += text + ","
                }

                onTextChanged: {
                    ttt = text
                    arr1 += ttt
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
            for (var i = 0; i < listModelContries.count; i++)
                strCountries += listModelContries.get(i).ttt + ","
            if (strCountries != "")
                strCountries = fieldCountry.text + "," + strCountries//.slice(0, -1)
            else
                strCountries = fieldCountry.text
            var str = idPerson + "," + fieldName.text + "," + fieldSurname.text + "," + fieldPosition.text + "," + fieldAddress.text + "," + fieldPhone.text + "," + fieldMartialStatus.text + ";" + strCountries//fieldCountries.text

            dataBase.saveChanges(str);
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
        onClicked: {
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
        id: addCountry
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

    Button {
        width: 250
        height: 50
        anchors.bottom: parent.bottom
        anchors.left: addCountry.right
        anchors.margins: 10
        text: "Remove country"
        onClicked: {
            listModelContries.remove(listModelContries.count - 2)
        }
    }
}
