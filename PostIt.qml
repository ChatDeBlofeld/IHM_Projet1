import QtQuick 2.0

PostItBase {
    Drag.active: dragArea.drag.activev

    MouseArea {
        id: dragArea
        anchors.fill: parent

        drag.target: parent
    }
}
