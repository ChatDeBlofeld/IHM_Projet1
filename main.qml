import QtQuick 2.12
import QtQuick.Window 2.12
import Backend 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Brain extender")
    // visibility: Window.FullScreen

    UnhandledEventsHandler {
        anchors.fill: parent
    }

    DeadlineHandler{
        id: deadlineHandler
    }

    Timer{
        interval: 1000;
        running: true;
        repeat: true;
        onTriggered: updateDeadlines()
    }

    PostItHeap {
        anchors { left: parent.left; bottom: parent.bottom;}
    }
/*
    PostIt {
        x: 50
        y: 50
    }
    */

    function updateDeadlines(){
        deadlineHandler.findPostits()
    }


}
