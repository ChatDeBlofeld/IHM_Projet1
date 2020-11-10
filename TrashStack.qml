import QtQuick 2.0

Item {
    id: stack
    width: 200 * scaling
    height: 200 * scaling
    z: 2000000
    property real scaling: 1

    Cross {
        width: parent.width
        height: parent.height
    }

}
