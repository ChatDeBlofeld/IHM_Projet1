import QtQuick 2.0

Item {
    id: cross

    Repeater {
        model: [45, -45]
        Rectangle {
            color: "#eb6767"
            width: cross.width / 5
            height: cross.height
            transform: Rotation {origin.x: width / 2; origin.y: height / 2; angle: modelData}
            radius: width / 2
            anchors.centerIn: cross
        }
    }

}

