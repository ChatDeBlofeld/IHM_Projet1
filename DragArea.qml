import QtQuick 2.0

Item {
    id: area
    property real maxWidth
    property real maxHeight
    property real trashX
    property real trashY
    property real trashWidth
    property real trashHeight

    property bool onTrash: false

    signal hoveredTrash()
    signal unHoveredTrash()

    function newArea(postIt) {
        var minX = 0;
        var minY = 0;
        var maxX = maxWidth;
        var maxY = maxHeight;

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

    }

    function release(postIt) {

    }

    function press(postIt) {

    }

    function isOnTrash(postIt) {
        return postIt.x > trashX - 3 / 4 * trashWidth && postIt.y > trashY - 3 / 4 * trashHeight;
    }

    function nextZ() {
        return 1000000;
    }


}
