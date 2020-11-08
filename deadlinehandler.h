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

    Q_PROPERTY(int years READ years WRITE setYears NOTIFY yearsChanged)
    Q_PROPERTY(int days READ days WRITE setDays NOTIFY daysChanged)
    Q_PROPERTY(int hours READ hours WRITE setHours NOTIFY hoursChanged)

};

#endif // DEADLINEHANDLER_H
