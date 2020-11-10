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
    property CustomDate deadline: CustomDate{
        year: 2020
        month: 11
        day: 8
        hour: 22
        minute: 48
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
                font.pointSize: 16 * shape.scaling
                placeholderText: qsTr("Ecrivez votre\nnote ici...")
                property color textColor: "#545454"
                color: textColor
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

            Outline {
                Layout.minimumHeight: 25 * shape.scaling
                Layout.maximumWidth: container.width
                border.width: scaling
                anchors.bottomMargin: 15 * scaling
                Layout.preferredWidth: dueDate.preferredWidth + (checker.visible ? fakePadding.width : 0);

                RowLayout {
                    id: dateContainer
                    anchors.fill: parent
                    anchors.margins: 0
                    Layout.columnSpan: 0
                    spacing: 0

                    TextField {
                        id: dueDate
                        property real preferredWidth: length == 0 ? 105 * shape.scaling
                               : contentWidth + leftPadding + rightPadding;
                        Layout.preferredWidth: preferredWidth

                        padding: 2 * shape.scaling
                        leftPadding: 8 * shape.scaling
                        rightPadding: 4 * shape.scaling
                        font.italic: true
                        font.pointSize: 12 * shape.scaling

                        color: "grey"
                        placeholderText: qsTr("Echéance...")
                        placeholderTextColor: "dark grey"

                        maximumLength: {
                            if (container.width - contentWidth < 45 * shape.scaling) {
                                return length;
                            } else {
                                return 32767;
                            }
                        }

                        background: Rectangle {
                            color: "transparent"
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
                            if (length == 0) {
                                checker.visible = false;
                            } else {
                                checker.visible = true;
                            }
                            updateDate()
                        }
                    }


                    Item {
                        id: checker
                        visible: false
                        Layout.preferredHeight: dateContainer.height * 0.8
                        Layout.preferredWidth: height
                        Layout.maximumWidth: height
                        property bool valid: false



                        Cross {
                            id: cross
                            visible: !parent.valid
                            anchors.fill: checker

                            ContextHelp {
                                id: crossHelp
                                text: "L'échéance n'a pu\nêtre interprétée.\nEssayez par\nexemple :\nSamedi 18h"
                                scaling: shape.scaling
                                color: Qt.darker(shape.color, 1.04)
                                textColor: "#eb6767"
                                triggerArea: cross
                                textArea: content
                            }

                            onVisibleChanged: if(!visible) crossHelp.visible = false
                        }

                        Check {
                            id: check
                            visible: parent.valid
                            anchors.fill: checker

                            ContextHelp {
                                id: checkHelp
                                text: "L'échéance est\nfixée au\n" + deadline.asString()
                                scaling: shape.scaling
                                color: Qt.darker(shape.color, 1.04)
                                textColor: Qt.darker(shape.color, 1.4)
                                triggerArea: check
                                textArea: content
                            }

                            onVisibleChanged: if(!visible) checkHelp.visible = false
                        }
                    }

                    Rectangle {
                        id: fakePadding
                        Layout.minimumWidth: checker.width * 1.4
                    }
                }
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
        var d = dueDate.text

        if (d !== "secret") {
            checker.valid = false;
        } else {
            checker.valid = true;
            createDate(new Date());
        }
    }

    function createDate(date) {
        deadline = Qt.createQmlObject(
                `import Backend 1.0;
                CustomDate {
                    year: ${date.getFullYear()}
                    month: ${date.getMonth() + 1}
                    day: ${date.getDate()}
                    hour: ${date.getHours()}
                    minute: ${date.getMinutes()}
                    second: ${date.getSeconds()}
                }`,
            shape);
    }
}
