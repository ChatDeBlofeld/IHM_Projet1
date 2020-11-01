import QtQuick 2.0

Rectangle {
    width: 100
    height: 100
    Drag.active: dragArea.drag.activev
    color: "red"

    MouseArea {
        id: dragArea
        anchors.fill: parent

        drag.target: parent
    }
}
