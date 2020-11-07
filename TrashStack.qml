import QtQuick 2.0

Item {
    id: stack
    width: 200
    height: 200

    Repeater {
        model: [45, -45]
        Rectangle {
            color: "#eb6767"
            width: 30
            height: 180
            transform: Rotation {origin.x: width / 2; origin.y: height / 2; angle: modelData}
            radius: width / 2
            anchors.centerIn: stack
        }
    }

}
