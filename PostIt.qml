import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.15
import Backend 1.0


PostItBase {
    id: shape
    objectName: "Postit"
    border.color: borderColor
    border.width: 2
    property CustomDate deadline:
        CustomDate{
            year: 2020
            month: 11
            day: 9
            hour: 00
            minute: 22
            second: 10
    }
    readonly property string contentText: content.text
    readonly property string dueDateText: dueDate.text
    property string setContentText
    property string setDueDateText
    property DragArea dragArea
    property string borderColor: "#10000000"

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

    onScalingChanged: {
        var r = dragArea.handleZoom(this);
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

        if (flag) {
            dropShadowRect.visible = false;
            border.color = "transparent";
        } else {
            dropShadowRect.visible = true;
            border.color = borderColor
        }
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
            anchors.margins: 8 * shape.scaling
            spacing: 0

            TextArea {
                id: content
                padding: 0
                wrapMode: TextEdit.Wrap
                font.pointSize: 14.5 * shape.scaling
                placeholderText: qsTr("Ecrivez votre\nnote ici...")
                color: "#545454"
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

            TextField {
                id: dueDate
                background: Outline {
                    border.width: 2 * shape.scaling
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

                onTextChanged: {
                    updateDate()
                }

                padding: 2 * shape.scaling
                leftPadding: 8 * shape.scaling
                rightPadding: 8 * shape.scaling
                font.italic: true
                font.pointSize: 12 * shape.scaling

                color: "grey"

                placeholderText: qsTr("Echéance...")
                placeholderTextColor: "dark grey"

                maximumLength: {
                    if (container.width - contentWidth < 25 * shape.scaling) {
                        return length;
                    } else {
                        return 32767;
                    }
                }

                Layout.preferredWidth: {
                    if (dueDate.length == 0) {
                        return 105 * shape.scaling;
                    } else {
                        return contentWidth + leftPadding + rightPadding;
                    }
                }

                Layout.minimumHeight: 15 * shape.scaling
                Layout.maximumWidth: container.width
            }
        }
    }


    Rectangle {
        id: dropShadowRect
        property real offset: Math.min(parent.width*0.025, parent.height*0.025)
        color: parent.borderColor
        width: parent.width
        height: parent.height
        x: offset
        y: offset
        z: -1
        radius: parent.radius + 2
    }

/*
    CustomDate{
        year: 2020
        month: 11
        day: 8
        hour: 22
        minute: 48
        second: 10
    }
*/
    function updateDate(){
//        //var dateString = deadline.toLocaleDateString();
//        deadline = Qt.createQmlObject('import Backend 1.0; CustomDate{
//        year: 2020
//        month: 11
//        day: 8
//        hour: 22
//        minute: 48
//        second: 10
//             }',
//          shape,
//          "dynamicSnippet1");
//        console.log("deadline updated : " + deadline)
        console.log("day = " + deadline.day + " year = " + deadline.year);
    }
}
