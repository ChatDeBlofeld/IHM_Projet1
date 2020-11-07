import QtQuick 2.0

Item {
    id: area
    property real maxWidth
    property real maxHeight

    function newArea(x, y, width, height) {
        return {minX: 0, minY: 0, maxX: maxWidth - width, maxY: maxHeight - height};
    }

}
