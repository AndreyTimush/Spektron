import QtQuick 2.3
import QtQuick.Controls 1.2
//import org.example 1.0

ApplicationWindow {
    id: listFilesScreen
    minimumWidth: 1080
    minimumHeight: 720
    height: 720
    property int fontScale: 15

    ListView {
        anchors.fill: parent
        clip: true
        model: listFilesModel
        delegate: Item {
            width: fileName.paintedWidth
            height: fileName.paintedHeight
            Text {
                id: fileName
                text: model.display
            }
        }
    }
}
