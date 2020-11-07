#include "deadlinehandler.h"
#include <QDateTime>

void DeadlineHandler::findPostits(){
    QList<QObject*> postits = parent()->findChildren<QObject*>("Postit");

    for (QObject * p : postits){
        if( p->property("deadline").toDateTime() < QDateTime::currentDateTime()){
            qDebug() << "ALERTE pour " << p->property("contentText").toString();
        }
    }


}


