import QtQuick 2.0

Item {
    id: area
    property real maxWidth
    property real maxHeight
    property real trashX
    property real trashY
    property real trashWidth
    property real trashHeight

    function newArea(postIt) {
        var minX = 0;
        var minY = 0;
        var maxX = maxWidth;
        var maxY = maxHeight;

        if (postIt.x + postIt.width > trashX ) {
            maxY = trashY;
        }

        if (postIt.y + postIt.height > trashY) {
            maxX = trashX;
        }

        return {minX: minX, minY: minY, maxX: maxX - postIt.width, maxY: maxY - postIt.height};
    }

    function release(postIt) {

    }

    function press(postIt) {

    }

}
