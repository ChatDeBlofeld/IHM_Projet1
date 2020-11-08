import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: heap
    height: template.height * 1.41
    width: template.width * 1.41
    property DragArea creationDragArea
    property DragArea newDragArea
    property real scaling: 1

    Repeater {
        model: ["light blue", "light green", "pink"]

        PostItBase {
            color: modelData
            anchors.centerIn: parent
            scaling: heap.scaling
            transform: Rotation { origin.x: width / 2; origin.y: height / 2; angle: 25 * (1 + index)}
        }
    }

    PostIt {
        anchors.centerIn: heap
        id: template
        dragArea: heap.creationDragArea
        scaling: heap.scaling
        border.width: 0
        parent: heap.parent

        Drag.onActiveChanged: {
            if (Drag.active === false) {
                if (x > heap.x + heap.width * 0.83 || y + height < heap.y + heap.height * 0.2){
                    var c = Qt.createComponent("PostIt.qml");
                    c.createObject(heap.parent, {
                                       x: x,
                                       y: y,
                                       z: heap.newDragArea.nextZ(),
                                       setContentText: contentText,
                                       setDueDateText: dueDateText,
                                       dragArea: heap.newDragArea,
                                       scaling: scaling
                                   });
                    template.setContentText = "";
                    template.setDueDateText = "";
                }

                anchors.centerIn = heap;
            } else {
                forceActiveFocus();
                anchors.centerIn = null;
            }
        }
    }
}
