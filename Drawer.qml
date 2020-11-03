import QtQuick 2.0

Rectangle {
    id: drawer
    width: 120
    height: 70
    color: "brown"

    property var isExtended: false

    Rectangle {
        id: knob
        width: 20
        height: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom : parent.bottom
        anchors.bottomMargin: 5
        color: "yellow"
        border.color: "black"
        border.width: 2
        radius: width*0.5
    }

    Rectangle{
        id: bottom
        width: parent.width - 20
        height: parent.height - 70
        color: "#381700"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }


    MouseArea {
        id: clickArea
        anchors.fill: parent
        onClicked: {
            if(mouse.button == Qt.LeftButton){
                if(isExtended){
                    drawer.height -= 150
                    isExtended = false;
                }else {
                    drawer.height += 150
                    isExtended = true;
                }
            }
        }
    }
}
