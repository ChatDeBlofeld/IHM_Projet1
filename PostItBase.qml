import QtQuick 2.0

Rectangle {
    width: 200
    height: 200
    color: "#f6ff78"
    property real scaling: 1

    onScalingChanged: {
        width = 200 * scaling;
        height =  200 * scaling;
    }
}
