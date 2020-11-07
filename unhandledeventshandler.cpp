#include "unhandledeventshandler.h"

UnhandledEventsHandler::UnhandledEventsHandler()
{
    setAcceptedMouseButtons(Qt::AllButtons);
}

void UnhandledEventsHandler::mouseReleaseEvent(QMouseEvent *event)
{
    QQuickItem::mouseReleaseEvent(event);
    QQuickItem::forceActiveFocus();
}

void UnhandledEventsHandler::mousePressEvent(QMouseEvent *event)
{
    QQuickItem::mousePressEvent(event);
    QQuickItem::forceActiveFocus();
    parent()->findChildren<QObject*>("PostIt");
}
