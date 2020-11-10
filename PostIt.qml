import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.15
import Backend 1.0


PostItBase {
    id: shape
    objectName: "Postit"

    border.color: borderColor
    border.width: 2
    property CustomDate deadline: CustomDate{
        year: 0
        month: 0
        day: 0
        hour: 0
        minute: 0
        second: 0
    }
    readonly property string contentText: content.text
    readonly property string dueDateText: dueDate.text
    property string setContentText
    property string setDueDateText
    property DragArea dragArea
    property string borderColor: "#10000000"
    property bool alert: false

    property bool active: Drag.active

    onXChanged: {
        updateArea();
    }

    onYChanged: {
        updateArea();
    }

    function updateArea() {
        if (active) {
            var r = dragArea.newArea(this);
            backgroundArea.drag.minimumX = r.minX;
            backgroundArea.drag.minimumY = r.minY;
            backgroundArea.drag.maximumX = r.maxX;
            backgroundArea.drag.maximumY = r.maxY;
        }
    }

    onContentTextChanged: {
        setContentText = contentText;
    }

    onDueDateTextChanged: {
        setDueDateText = dueDateText;
    }

    onSetContentTextChanged: {
        if (contentText != setContentText)
            content.text = setContentText;
    }

    onSetDueDateTextChanged: {
        if (dueDateText != setDueDateText)
            dueDate.text = setDueDateText
    }

    onScalingChanged: {
        var r = dragArea.handleZoom(this);
    }

    Drag.active: {
        return backgroundArea.drag.active || contentArea.drag.active || dateArea.drag.active;
    }

    Drag.onActiveChanged: {
        if (Drag.active === true) {
            forceActiveFocus();
            dragArea.press(this);
            shape.z = dragArea.nextZ();
        } else  {
            dragArea.release(this);
        }
    }

    function readOnly(flag) {
        content.readOnly = flag;
        dueDate.readOnly = flag;

        if (flag) {
            dropShadowRect.visible = false;
            border.color = "transparent";
            timerAlert.stop();
            alertArea.visible = false;

            if (contentText === "") {
                content.visible = false;
            }

            if (dueDateText === "") {
                dateContainer.visible = false;
            }
            checker.visible = false;
        } else {
            if (alert) {
                timerAlert.start()
            }

            if (dueDateText !== "") {
                checker.visible = true;
            }

            content.visible = true;
            dateContainer.visible = true;
            dropShadowRect.visible = true;
            border.color = borderColor
        }
    }

    MouseArea {
        id: backgroundArea
        z: 10
        anchors.fill: parent
        drag.target: parent
        drag.filterChildren: true
        onClicked: {
            shape.z = dragArea.nextZ();
            forceActiveFocus();
        }

        ColumnLayout {
            id: container
            anchors.fill: parent
            anchors.margins: 8 * shape.scaling
            spacing: 0

            TextArea {
                id: content
                padding: 0
                wrapMode: TextEdit.Wrap
                font.pointSize: 16 * shape.scaling
                placeholderText: qsTr("Ecrivez votre\nnote ici...")
                property color textColor: "#545454"
                color: textColor
                placeholderTextColor: "grey"
                onTextChanged: {
                    var pos = content.positionAt(1, height + 1);
                    if (content.length > pos)
                    {
                        content.remove(content.length - 1, content.length);
                    }
                }

                Layout.fillWidth: true
                Layout.fillHeight: true

                background: Rectangle {
                    color: "transparent"
                    MouseArea {
                        id: contentArea
                        anchors.fill: parent
                        propagateComposedEvents: true
                        onClicked: {
                            content.cursorPosition = content.positionAt(mouseX, mouseY);
                            content.forceActiveFocus();
                            shape.z = dragArea.nextZ();
                        }
                    }
                }
            }

            Outline {
                id: dateContainer
                Layout.minimumHeight: 25 * shape.scaling
                Layout.maximumWidth: container.width
                border.width: scaling
                anchors.bottomMargin: 15 * scaling
                Layout.preferredWidth: dueDate.preferredWidth + (checker.visible ? fakePadding.width : 0);
                Layout.alignment: Qt.AlignBottom

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 0
                    Layout.columnSpan: 0
                    spacing: 0

                    TextField {
                        id: dueDate
                        property real preferredWidth: length == 0 ? 105 * shape.scaling
                               : contentWidth + leftPadding + rightPadding;
                        Layout.preferredWidth: preferredWidth

                        padding: 2 * shape.scaling
                        leftPadding: 8 * shape.scaling
                        rightPadding: 4 * shape.scaling
                        font.italic: true
                        font.pointSize: 12 * shape.scaling

                        color: "grey"
                        placeholderText: qsTr("Echéance...")
                        placeholderTextColor: "dark grey"

                        maximumLength: {
                            if (container.width - contentWidth < 45 * shape.scaling) {
                                return length;
                            } else {
                                return 32767;
                            }
                        }

                        background: Rectangle {
                            color: "transparent"
                            MouseArea {
                                id: dateArea
                                anchors.fill: parent
                                propagateComposedEvents: true
                                onClicked: {
                                    dueDate.cursorPosition = dueDate.positionAt(mouseX, mouseY);
                                    dueDate.forceActiveFocus();
                                    shape.z = dragArea.nextZ();
                                }
                            }
                        }

                        onTextChanged: {
                            if (length == 0) {
                                checker.visible = false;
                            } else {
                                checker.visible = true;
                            }
                            updateDate()
                        }
                    }


                    Item {
                        id: checker
                        visible: false
                        Layout.preferredHeight: dateContainer.height * 0.8
                        Layout.preferredWidth: height
                        Layout.maximumWidth: height
                        property bool valid: false



                        Cross {
                            id: cross
                            visible: !parent.valid
                            anchors.fill: checker

                            ContextHelp {
                                id: crossHelp
                                text: "L'échéance n'a pu\nêtre interprétée.\nEssayez par\nexemple :\nSamedi 18h"
                                scaling: shape.scaling
                                color: Qt.darker(shape.color, 1.04)
                                textColor: "#eb6767"
                                triggerArea: cross
                                textArea: content
                            }

                            onVisibleChanged: if(!visible) crossHelp.visible = false
                        }

                        Check {
                            id: check
                            visible: parent.valid
                            anchors.fill: checker

                            ContextHelp {
                                id: checkHelp
                                text: "L'échéance est\nfixée au\n" + deadline.asString()
                                scaling: shape.scaling
                                color: Qt.darker(shape.color, 1.04)
                                textColor: Qt.darker(shape.color, 1.4)
                                triggerArea: check
                                textArea: content
                            }

                            onVisibleChanged: if(!visible) checkHelp.visible = false
                        }
                    }

                    Rectangle {
                        id: fakePadding
                        Layout.minimumWidth: checker.width * 1.4
                    }
                }
            }
        }
    }


    Rectangle {
        id: dropShadowRect
        property real offset: Math.min(parent.width*0.025, parent.height*0.025)
        color: parent.borderColor
        width: parent.width
        height: parent.height
        x: offset
        y: offset
        z: -1
        radius: parent.radius + 2
    }

    Rectangle {
        id: alertArea
        anchors.fill: parent
        color: "#eb6767"
        visible: false
    }

    onAlertChanged: {
        if (alert) {
            if (!content.readOnly) {
                timerAlert.start();
                shape.z = dragArea.nextZ();
            }
        } else {
            timerAlert.stop();
            alertArea.visible = false;
        }
    }

    Timer {
        id: timerAlert
        interval: 500
        repeat: true

        onTriggered: {
            alertArea.visible = !alertArea.visible;
        }
    }

    function nextDay(date) {
      const copy = new Date(Number(date))
      copy.setDate(date.getDate() + 1)
      return copy;
    }

    function getHourMinute(str) {
        var tokens

        tokens = str.split(/[h:]/);

        var hour = tokens[0];
        var minute = -1;
        if(tokens[1] !== "") minute = tokens[1];

        return [hour, minute];
    }

    function updateDate(){ 
        var str = dueDate.text.toLowerCase().trim();
        alert = false;
        const current = new Date();


        var year, month, day, hour, minute, second;

        //default values
        hour = 9;
        minute = second = 0;
        year = month = day = -1; // -1 means unset
        /*
        var d = new Date();
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        var day = d.getDate();
        var hour = 45;
        var minute = 0;
        var second = 0;
        */

        //Date longue:  (le )?[0-9]{1,2} [a-zA-Zéû]+ (([0-9]{4})?)( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?
        //Date:         (le )?[0-9]{1,2}[./][0-9]{1,2}([./][0-9]{4})?( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?
        //Jour semaine: [a-zA-Z]+( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?
        //Heure:        [0-9]{1,2}[:h]([0-9]{1,2})?

        // TODO : define rules here

        //Regexes for the different formats
        var longDateRegex = /^(le )?[0-9]{1,2} [a-zA-Zéû]+ (([0-9]{2,4})?)( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?$/g;
        var dateRegex = /^(le )?[0-9]{1,2}[./][0-9]{1,2}([./][0-9]{2,4})?( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?$/g;
        var weekDayRegex = /^[a-zA-Z]+( (à )?[0-9]{1,2}[:h]([0-9]{1,2})?)?$/g;
        var hourRegex = /^[0-9]{1,2}[:h]([0-9]{1,2})?/g;

        checker.valid = false;
        var error = false;
        //console.log("current date: " + current.toString());

        str.replace("le ", "");
        str.replace("à ", "");
        if(longDateRegex.test(str)){
            //checker.valid = true;
            console.log("long date detected");

        }else if(dateRegex.test(str)){
            //checker.valid = true;
            var tokens = str.split(" ");
            if (tokens.length > 1) {
                var r = getHourMinute(tokens[1]);

                hour = r[0];
                minute = r[1];
            }

            tokens = tokens[0].split(/[./]/);
            day = tokens[0];
            month = tokens[1];
            year =  tokens[2] < 100 ? 2000 + parseInt(tokens[2]) : tokens[2];
        }else if(weekDayRegex.test(str)){
            //checker.valid = true;
            console.log("week day detected");
            var weekDays = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"];
            var tokens = str.split(" ");
            var index = weekDays.indexOf(tokens[0])
            if(index !== -1){
                day = index + 1;
                if(tokens[1] !== ""){
                    var hourIndex = tokens[1] ==="à"? 2 : 1;
                    var r = getHourMinute(tokens[hourIndex])
                    hour = r[0];
                    minute = r[1];
                }
            }else{
                error = true;
            }


        }else if(hourRegex.test(str)){
            //checker.valid = true;
            console.log("hour detected");
            var r = getHourMinute(str);
            hour = r[0];
            minute = r[1];

            //console.log("hour: " + hour + "minute: " + minute);

        }else{
            error = true;
        }


        if(error){
            checker.valid = false;
        }else{
            if(day === -1){
                if(current.getHours() > hour || (current.getHours() === hour && current.getMinutes() >= minute)){
                    //day = (current.getTime() + 1*60*60*1000).getDay() //add a day (thank you javascript)
                    const nextDayCopy = nextDay(current);
                    day = nextDayCopy.getDate();
                    month = nextDayCopy.getMonth() + 1; //add 1 to transition to QDateTime
                    year = nextDayCopy.getFullYear();
                }else{
                    day = current.getDate();
                    month = current.getMonth() + 1;
                    year = current.getFullYear();
                }

            }


            console.log("year: " + year + " month: " + month + " day: " + day + " hour: " + hour + " minute: " + minute);

            deadline = Qt.createQmlObject(
                `import Backend 1.0;
                CustomDate {
                    year: ${year}
                    month: ${month}
                    day: ${day}
                    hour: ${hour}
                    minute: ${minute}
                    second: ${second}
                }`,
                shape);

            checker.valid = deadline.isValid();
        }



    }
}
