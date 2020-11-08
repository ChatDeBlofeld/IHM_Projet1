#ifndef DEADLINEHANDLER_H
#define DEADLINEHANDLER_H

#include <QQuickItem>
#include <QTimer>
#include <QObject>

class DeadlineHandler : public QObject
{
    Q_OBJECT
private:

public:
    explicit DeadlineHandler(QObject* parent = 0) : QObject(parent){}

    Q_INVOKABLE void findPostits();

};

#endif // DEADLINEHANDLER_H
