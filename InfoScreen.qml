import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    minimumWidth: 1080;
    minimumHeight: 720;

    Connections {
        target: dataBase

        function onGetCountries(name) {
            for (var i=0; i < name.length; i++)
                nameCountries.append({"cntryName": name[i]})
        }
    }

    ListModel {
        id: nameCountries
    }

    ListView {
        anchors.fill: parent
        model: dataBase
        interactive: false

        ColumnLayout {
            Item {
                width: childrenRect.width
                height: childrenRect.height
                Label {
                    id: labelAddress
                    text: "address: "
                }

                Text {
                    anchors.left: labelAddress.right
                    text: address
                }
            }

            Item {
                width: childrenRect.width
                height: childrenRect.height
                Label {
                    id: labelTelephone
                    text: "telephone: "
                }

                Text {
                    anchors.left: labelTelephone.right
                    text: phone
                }
            }

            Item {
                width: childrenRect.width
                height: childrenRect.height
                Label {
                    id: labelMartialStatus
                    text: "martial status: "
                }

                Text {
                    anchors.left: labelMartialStatus.right
                    text: martialStatus
                }
            }

            Item {
                width: childrenRect.width
                height: childrenRect.height

                ListView {
                    anchors.fill: parent
                    model: nameCountries
                    Text {
                        text: cntryName
                    }
                }
            }
        }
    }
}
