import QtQuick 2.0

DragArea {
    property real heapX
    property real heapY
    property real heapWidth
    property real heapHeight

    function newArea(x, y, width, height) {
        var minX = 0;
        var minY = 0;
        var maxX = maxWidth;
        var maxY = maxHeight;

        if (x < heapX + heapWidth) {
            maxY = heapY;
        }

        if (y + height > heapY) {
            minX = heapX + heapWidth;
        }

        return {minX: minX, minY: minY, maxX: maxX - width, maxY: maxY - height};
    }
}
