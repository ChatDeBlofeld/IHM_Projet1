import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

PostItBase {
    id: shape
    readonly property string contentText: content.text
    readonly property string dueDateText: dueDate.text
    property string setContentText
    property string setDueDateText
    property DragArea dragArea

    property bool active: Drag.active

    onXChanged: {
        updateArea();
    }

    onYChanged: {
        updateArea();
    }

    function updateArea() {
        if (active) {
            var r = dragArea.newArea(this);
            backgroundArea.drag.minimumX = r.minX;
            backgroundArea.drag.minimumY = r.minY;
            backgroundArea.drag.maximumX = r.maxX;
            backgroundArea.drag.maximumY = r.maxY;
        }
    }

    onContentTextChanged: {
        setContentText = contentText;
    }

    onDueDateTextChanged: {
        setDueDateText = dueDateText;
    }

    onSetContentTextChanged: {
        if (contentText != setContentText)
            content.text = setContentText;
    }

    onSetDueDateTextChanged: {
        if (dueDateText != setDueDateText)
            dueDate.text = setDueDateText
    }

    Drag.active: {
        return backgroundArea.drag.active || contentArea.drag.active || dateArea.drag.active;
    }

    Drag.onActiveChanged: {
        if (Drag.active === true) {
            forceActiveFocus();
            dragArea.press(this);
            shape.z = dragArea.nextZ();
        } else  {
            dragArea.release(this);
        }
    }

    function readOnly(flag) {
        content.readOnly = flag;
        dueDate.readOnly = flag;
    }

    MouseArea {
        id: backgroundArea
        anchors.fill: parent
        drag.target: parent
        drag.filterChildren: true
        onClicked: {
            shape.z = dragArea.nextZ();
            forceActiveFocus();
        }

        ColumnLayout {
            id: container
            anchors.fill: parent
            anchors.margins: 8
            spacing: 0

            TextArea {
                id: content
                padding: 0
                wrapMode: TextEdit.Wrap
                font.pointSize: 16
                placeholderText: qsTr("Ecrivez votre\nnote ici...")
                placeholderTextColor: "grey"
                onTextChanged: {
                    var pos = content.positionAt(1, height + 1);
                    if (content.length > pos)
                    {
                        content.remove(content.length - 1, content.length);
                    }
                }

                Layout.fillWidth: true
                Layout.fillHeight: true

                background: Rectangle {
                    color: "transparent"
                    MouseArea {
                        id: contentArea
                        anchors.fill: parent
                        propagateComposedEvents: true
                        onClicked: {
                            content.cursorPosition = content.positionAt(mouseX, mouseY);
                            content.forceActiveFocus();
                            shape.z = dragArea.nextZ();
                        }
                    }
                }
            }
            Rectangle {
                width: container.width
                height: 25
    //                color: "red"
                color: "transparent"

                RowLayout {
                    anchors.fill: parent

                    TextField {
                        id: dueDate
                        background: Outline {
                            MouseArea {
                                id: dateArea
                                anchors.fill: parent
                                propagateComposedEvents: true
                                onClicked: {
                                    dueDate.cursorPosition = dueDate.positionAt(mouseX, mouseY);
                                    dueDate.forceActiveFocus();
                                    shape.z = dragArea.nextZ();
                                }
                            }
                        }
                        padding: 2
                        leftPadding: 8
                        rightPadding: 8
                        font.italic: true

                        color: "grey"

                        placeholderText: qsTr("Echéance...")
                        placeholderTextColor: "dark grey"

                        maximumLength: {
                            if (container.width - contentWidth < 25) {
                                return length;
                            } else {
                                return 32767;
                            }
                        }

                        Layout.preferredWidth: {
                            if (dueDate.length == 0) {
                                return 100;
                            } else {
                                return contentWidth + leftPadding + rightPadding;
                            }
                        }

                        Layout.minimumHeight: 15
                        Layout.maximumWidth: container.width
                    }
                }
            }
        }
    }
}
