import QtQuick 2.0

DragArea {
    property real heapX
    property real heapY
    property real heapWidth
    property real heapHeight

    signal trashed(PostIt postIt)
    signal untrashed(PostIt postIt)

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
            hoveredTrash();
        }

        if (!isOnTrash(postIt) && onTrash) {
            onTrash = false;
            unHoveredTrash();
        }

        return {minX: minX, minY: minY, maxX: maxX - postIt.width, maxY: maxY - postIt.height};
    }

    function handleZoom(postIt) {
        if (postIt.x + postIt.width > maxWidth) {
            postIt.x = maxWidth - postIt.width - 1;
        }

        if (postIt.y + postIt.height > maxHeight) {
            postIt.y = maxHeight - postIt.height - 1;
        }

        var dx = postIt.x - heapX - heapWidth * 0.83;
        var dy = heapY + heapHeight * 0.2 - postIt.y - postIt.height;

        if (dx < 0 && dy < 0) {
            postIt.x -= dx > dy ? dx-5 : 0;
            postIt.y += dy >= dx ? dy-5 : 0;
        }

        dx = trashX - postIt.x - postIt.width;
        dy = trashY - postIt.y - postIt.height;

        if (dx < 0 && dy < 0) {
            postIt.x += dx > dy ? dx-5 : 0;
            postIt.y += dy >= dx ? dy-5 : 0;
        }
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



    function nextZ() {
        if( typeof nextZ.counter == 'undefined' ) {
                nextZ.counter = 100;
        }
        return nextZ.counter++;
    }

}
