import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: heap
    height: template.height * 1.41
    width: template.width * 1.41

    Repeater {
        model: ["light blue", "light green", "pink"]

        PostItBase {
            color: modelData
            anchors.centerIn: parent
            transform: Rotation { origin.x: width / 2; origin.y: height / 2; angle: 25 * (1 + index)}
        }
    }

    PostIt {
        anchors.centerIn: parent
        id: template

        Drag.onActiveChanged: {
            if (Drag.active === false) {
                if ((x + width / 2 - parent.width / 2)**2
                        + (y + height / 2 - parent.height / 2)**2
                        > width**2){
                    var c = Qt.createComponent("PostIt.qml");
                    c.createObject(heap.parent, {
                                       x: x + heap.x,
                                       y: y + heap.y,
                                       setContentText: contentText,
                                       setDueDateText: dueDateText
                                   });
                    template.setContentText = "";
                    template.setDueDateText = "";
                }

                anchors.centerIn = parent;
            } else {
                forceActiveFocus();
                anchors.centerIn = null;
            }
        }
    }
}
