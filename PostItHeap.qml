import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: heap
    height: template.height * 1.41
    width: template.width * 1.41

    signal create(content: string, dueDate: string)

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
                    create(contentText, dueDateText);
                } else {
                    anchors.centerIn = parent;
                }
            } else {
                forceActiveFocus();
                anchors.centerIn = null;
            }
        }
    }

//    PostItBase {
//        anchors.centerIn: parent
//        id: template
//        Drag.active: {
//            return backgroundArea.drag.active || contentArea.drag.active || dateArea.drag.active;
//        }

//        Drag.onActiveChanged: {
//            if (Drag.active === false) {
//                if ((x + width / 2 - parent.width / 2)**2
//                        + (y + height / 2 - parent.height / 2)**2
//                        > width**2){
//                    create(content.text, dueDate.text);
//                } else {
//                    anchors.centerIn = parent;
//                }
//            } else {
//                forceActiveFocus();
//                anchors.centerIn = null;
//            }
//        }

////        Drag.dragFinished: {
////            if () {

////            }
////        }

//        MouseArea {
//            id: backgroundArea
//            anchors.fill: parent
//            drag.target: parent
//            onClicked: {
//                forceActiveFocus();
//            }
//        }


//        ColumnLayout {
//            id: container
//            anchors.fill: parent
//            anchors.margins: 8
//            spacing: 0

//            TextArea {
//                id: content
//                padding: 0
//                wrapMode: TextEdit.Wrap
//                font.pointSize: 16
//                placeholderText: qsTr("Ecrivez votre\nnote ici...")
//                placeholderTextColor: "grey"
//                onTextChanged: {
//                    var pos = content.positionAt(1, height + 1);
//                    if (content.length > pos)
//                    {
//                        content.remove(content.length - 1, content.length);
//                    }
//                }

//                Layout.fillWidth: true
//                Layout.fillHeight: true

//                background: Rectangle {
//                    color: "transparent"
//                    MouseArea {
//                        id: contentArea
//                        anchors.fill: parent
//                        drag.target: template
//                        propagateComposedEvents: true
//                        onClicked: {
//                            content.cursorPosition = content.positionAt(mouseX, mouseY);
//                            content.forceActiveFocus();
//                        }
//                    }
//                }
//            }
//            Rectangle {
//                width: container.width
//                height: 25
////                color: "red"
//                color: "transparent"

//                RowLayout {
//                    anchors.fill: parent

//                    TextField {
//                        id: dueDate
//                        background: Outline {
//                            MouseArea {
//                                id: dateArea
//                                anchors.fill: parent
//                                drag.target: template
//                                propagateComposedEvents: true
//                                onClicked: {
//                                    dueDate.cursorPosition = dueDate.positionAt(mouseX, mouseY);
//                                    dueDate.forceActiveFocus();
//                                }
//                            }
//                        }
//                        padding: 2
//                        leftPadding: 8
//                        rightPadding: 8
//                        font.italic: true

//                        color: "grey"

//                        placeholderText: qsTr("Echéance...")
//                        placeholderTextColor: "dark grey"

//                        maximumLength: {
//                            if (container.width - contentWidth < 25) {
//                                return length;
//                            } else {
//                                return 32767;
//                            }
//                        }

//                        Layout.preferredWidth: {
//                            if (dueDate.length == 0) {
//                                return 100;
//                            } else {
//                                return contentWidth + leftPadding + rightPadding;
//                            }
//                        }

//                        Layout.minimumHeight: 15
//                        Layout.maximumWidth: container.width
//                    }
//                }
//            }
//        }
//    }
}
