import QtQuick 2.12
import QtQuick.Window 2.12
import Backend 1.0

Window {
    id: mainFrame
    width: 1024
    height: 720
    visible: true
    title: qsTr("Brain extender")
    // visibility: Window.FullScreen

    readonly property DragArea creationDragArea: DragArea {
        maxWidth: mainFrame.width
        maxHeight: mainFrame.height
        trashHeight: trash.height
        trashWidth: trash.width
        trashX: trash.x
        trashY: trash.y
    }

    readonly property DragArea postItDragArea: RestrictedDragArea {
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

    PostItHeap {
        id: heap
        anchors { left: parent.left; bottom: parent.bottom;}
        creationDragArea: mainFrame.creationDragArea
        newDragArea: mainFrame.postItDragArea
    }

    TrashStack {
        id: trash
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 20; bottomMargin: 20}
    }
}
