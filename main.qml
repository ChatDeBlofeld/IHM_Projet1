import QtQuick 2.12
import QtQuick.Window 2.12
import Backend 1.0

Window {
    id: mainFrame
    width: 640
    height: 480
    visible: true
    title: qsTr("Brain extender")
    // visibility: Window.FullScreen

    readonly property DragArea creationDragArea: DragArea {
        maxWidth: mainFrame.width
        maxHeight: mainFrame.height
    }

    readonly property DragArea postItDragArea: RestrictedDragArea {
        maxWidth: mainFrame.width
        maxHeight: mainFrame.height
        heapHeight: heap.height
        heapWidth: heap.width
        heapX: heap.x
        heapY: heap.y
    }

    UnhandledEventsHandler {
        anchors.fill: parent
    }

    PostItHeap {
        id: heap
        anchors { left: parent.left; bottom: parent.bottom;}
        creationDragArea: mainFrame.creationDragArea
        newDragArea: mainFrame.postItDragArea
    }

    PostIt {
        x: 50
        y: 50
        dragArea: mainFrame.postItDragArea
    }
}
