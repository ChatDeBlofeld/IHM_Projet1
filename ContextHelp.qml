import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: context
    property string text
    property real scaling
    property color color
    property color textColor
    property var textArea
    property var triggerArea

    parent: textArea

    visible: false

    Timer {
        id: timer
        interval: 700; running: false; repeat: false
        onTriggered: {
            if (mouseArea.containsMouse) {
                context.visible = true;
            } else {
                context.visible = false;
            }
        }
    }

    TextArea {
        id: content
        width: textArea.width
        height: textArea.height * 0.95
        enabled: false
        font.pointSize:  14 * context.scaling
        font.weight: Font.DemiBold
        color: context.textColor
        text: context.text
        background: Rectangle {
            color: context.color
            radius: 5 * context.scaling
        }
    }

    MouseArea {
        id: mouseArea
        parent: triggerArea
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if (visible) {
                timer.restart();
            }
        }
    }
}
