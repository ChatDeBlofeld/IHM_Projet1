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
        id: base
        model: ["pink", "light green", "light blue"]


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
        color: "#f6ff78"

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
                                       scaling: scaling,
                                       color: color
                                   });
                    template.setContentText = "";
                    template.setDueDateText = "";
                    color = nextColor();

                    for(var i = 2; i >= 0; i--) {
                        base.itemAt(i).color = nextColor();
                    }
                }

                anchors.centerIn = heap;
            } else {
                forceActiveFocus();
                anchors.centerIn = null;
            }
        }
    }

    function nextColor() {
        if( typeof nextColor.colors == 'undefined' ) {
                nextColor.colors = ["light blue", "light green", "pink", "#f6ff78"];
         }

        if (typeof nextColor.index == 'undefined') {
            nextColor.index = 0;
        }

        if (typeof nextColor.shift == 'undefined') {
            nextColor.shift = 0;
        }

        if (nextColor.index === nextColor.colors.length) {
            nextColor.shift++;
        }

        nextColor.shift = nextColor.shift % nextColor.colors.length;
        nextColor.index = nextColor.index % nextColor.colors.length;



        return nextColor.colors[(nextColor.shift + nextColor.index++) % nextColor.colors.length];
    }
}
