import QtQuick 2.0

Item {
    id: stack
    width: 200 * scaling
    height: 200 * scaling
    z: 2000000
    property real scaling: 1

    Repeater {
        model: [45, -45]
        Rectangle {
            color: "#eb6767"
            width: 30 * stack.scaling
            height: 180 * stack.scaling
            transform: Rotation {origin.x: width / 2; origin.y: height / 2; angle: modelData}
            radius: width / 2
            anchors.centerIn: stack
        }
    }

}
