import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    PostIt {
        x: 50
        y: 50
    }

    Drawer {
        x: 200
        y: 50
    }
}
