#ifndef UNHANDLEDEVENTSHANDLER_H
#define UNHANDLEDEVENTSHANDLER_H

#include <QQuickItem>

class UnhandledEventsHandler : public QQuickItem
{
public:
    UnhandledEventsHandler();

    void mouseReleaseEvent(QMouseEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
};

#endif // UNHANDLEDEVENTSHANDLER_H
