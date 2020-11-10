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
        //cout << "deadline : " << *customDeadline << endl;
        //cout << "current : " << current.toString().toStdString() << endl;
        //cout << "---------------------------------------------------------------" << endl << endl;
        QDateTime deadline = customDeadline->toDateTime();
        if( deadline.isValid() && deadline < current){
            qDebug() << "ALERTE pour " << p->property("contentText").toString();
            p->setProperty("alert", true);
        }
    }
}


