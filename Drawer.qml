import QtQuick 2.0

Rectangle {
    readonly property int _WIDTH : 120
    readonly property int _FRONT_PANNEL_HEIGHT : 70
    readonly property int _INSIDE_DEPTH : 150
    readonly property int _INSIDE_BORDER_WIDTH : 10

    property var isExtended: false


    id: drawer
    width: _WIDTH
    height: _FRONT_PANNEL_HEIGHT

    color: "brown"



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
        width: parent.width - _INSIDE_BORDER_WIDTH * 2
        height: parent.height - _FRONT_PANNEL_HEIGHT
        color: "#381700"
        anchors.top: parent.top
        anchors.topMargin: _INSIDE_BORDER_WIDTH
        anchors.horizontalCenter: parent.horizontalCenter
    }


    MouseArea {
        id: clickArea
        anchors.fill: parent
        onClicked: {
            if(mouse.button == Qt.LeftButton){
                if(isExtended){
                    drawer.height -= _INSIDE_DEPTH
                    isExtended = false;
                }else {
                    drawer.height += _INSIDE_DEPTH
                    isExtended = true;
                }
            }
        }
    }
}
