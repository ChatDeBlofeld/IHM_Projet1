import QtQuick 2.0

DragArea {
    property real heapX
    property real heapY
    property real heapWidth
    property real heapHeight

    property bool onTrash: false

    signal trashed(PostIt postIt)
    signal untrashed(PostIt postIt)
    signal hoveredTrash(PostIt postIt)
    signal unHoveredTrash(PostIt postIt)

    function newArea(postIt) {
        var minX = 0;
        var minY = 0;
        var maxX = maxWidth;
        var maxY = maxHeight;

        if (postIt.x < heapX + heapWidth * 0.83) {
            maxY = heapY + heapHeight * 0.2;
        }

        if (postIt.y + postIt.height > heapY + heapHeight * 0.2) {
            minX = heapX + heapWidth * 0.83;
        }

        if (isOnTrash(postIt) && !onTrash) {
            onTrash = true;
            hoveredTrash(postIt);
        }

        if (!isOnTrash(postIt) && onTrash) {
            onTrash = false;
            unHoveredTrash(postIt);
        }

        return {minX: minX, minY: minY, maxX: maxX - postIt.width, maxY: maxY - postIt.height};
    }

    function release(postIt) {
        if (isOnTrash(postIt)) {
            trashed(postIt);
        }
    }

    function press(postIt) {
        onTrash = false;
        untrashed(postIt);
    }

    function isOnTrash(postIt) {
        return postIt.x > trashX - 3 / 4 * trashWidth && postIt.y > trashY - 3 / 4 * trashHeight;
    }

    function nextZ() {
        if( typeof nextZ.counter == 'undefined' ) {
                nextZ.counter = 100;
        }
        return nextZ.counter++;
    }

}
