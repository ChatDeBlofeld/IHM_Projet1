#include "deadlinehandler.h"
#include <QDateTime>
#include "customdate.h"
#include <iostream>

using namespace std;

void DeadlineHandler::findPostits(){
    QList<QObject*> postits = parent()->findChildren<QObject*>("Postit");

    for (QObject * p : postits){
        CustomDate* customDeadline = qvariant_cast<CustomDate*>(p->property("deadline"));
        QDateTime current = QDateTime::currentDateTime();
        QDateTime deadline = customDeadline->toDateTime();
        if( customDeadline->isValid() && deadline < current){
            p->setProperty("alert", true);
        }
    }
}


