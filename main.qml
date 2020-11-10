import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Backend 1.0

Window {
    id: mainFrame
    width: 1024
    height: 720
    visible: true
    title: qsTr("Brain extender")
//    visibility: Window.FullScreen

    readonly property DragArea creationDragArea: DragArea {
        maxWidth: mainFrame.width
        maxHeight: mainFrame.height
        trashHeight: trash.height
        trashWidth: trash.width
        trashX: trash.x
        trashY: trash.y

        onHoveredTrash: {
            trash.scale = 1.5;
        }

        onUnHoveredTrash: {
            trash.scale = 1;
        }
    }

    readonly property RestrictedDragArea postItDragArea: RestrictedDragArea {
        maxWidth: mainFrame.width
        maxHeight: mainFrame.height
        heapHeight: heap.height
        heapWidth: heap.width
        heapX: heap.x
        heapY: heap.y
        trashHeight: trash.height
        trashWidth: trash.width
        trashX: trash.x
        trashY: trash.y

        onTrashed: {
            postIt.anchors.centerIn = trash;
            postIt.readOnly(true);
            trash.scale = 1;
        }
        onUntrashed: {
            postIt.anchors.centerIn = null;
            postIt.readOnly(false);
        }

        onHoveredTrash: {
            trash.scale = 1.5;
        }

        onUnHoveredTrash: {
            trash.scale = 1;
        }
    }

    UnhandledEventsHandler {
        anchors.fill: parent
    }

    DeadlineHandler{
        id: deadlineHandler
    }

    Timer{
        interval: 5000;
        running: true;
        repeat: true;
        onTriggered: updateDeadlines()
    }

    PostItHeap {
        id: heap
        anchors { left: parent.left; bottom: parent.bottom;}
        creationDragArea: mainFrame.creationDragArea
        newDragArea: mainFrame.postItDragArea
    }

    RowLayout {
        anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 40}
        z: 3000000

        Text {
            font.pointSize: 16
            color: "grey"
            text: qsTr("Zoom")
        }

        Slider {
            from: 0.5
            to: 1.75
            value: 1

            onValueChanged: {
                heap.scaling = value;
                trash.scaling = value;
                var children = mainFrame.contentItem.children;
                for (var i = 0; i < children.length; i++) {
                    if (children[i].hasOwnProperty("scaling")) {
                        children[i].scaling = value;
                    }
                }

                valueDisplay.text = +(Math.round(value + "e+2")).toString() + "%"
            }
        }

        Text {
            id: valueDisplay
            font.pointSize: 16
            font.italic: true
            color: "grey"
            text: "100%"
        }
    }


    TrashStack {
        id: trash
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 0.2 * width; bottomMargin: 0.2 * height}
    }

    function updateDeadlines(){
            deadlineHandler.findPostits()
    }


}
