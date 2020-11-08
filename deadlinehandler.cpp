#include "deadlinehandler.h"
#include <QDateTime>
#include "customdate.h"

void DeadlineHandler::findPostits(){
    QList<QObject*> postits = parent()->findChildren<QObject*>("Postit");

    for (QObject * p : postits){
        QVariant deadline = p->property("deadline");
        CustomDate helpMe = qvariant_cast<CustomDate>(deadline);
        if( helpMe.getDateTime() < QDateTime::currentDateTime()){
            qDebug() << "ALERTE pour " << p->property("contentText").toString();
        }
    }
}


