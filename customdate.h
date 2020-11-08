#ifndef CUSTOMDATE_H
#define CUSTOMDATE_H

#include <QQuickItem>
#include <QDateTime>

class CustomDate : public QDateTime
{
    Q_OBJECT
public:
    CustomDate();
    CustomDate(int years, int days, int hours, int minutes, int seconds);

    QDateTime toQDateTime();



    Q_PROPERTY(int years READ years WRITE setYears NOTIFY yearsChanged)
    Q_PROPERTY(int months READ months WRITE setMonths NOTIFY monthsChanged)
    Q_PROPERTY(int days READ days WRITE setDays NOTIFY daysChanged)
    Q_PROPERTY(int hours READ hours WRITE setHours NOTIFY hoursChanged)
    Q_PROPERTY(int minutes READ minutes WRITE setMinutes NOTIFY minutesChanged)
    Q_PROPERTY(int seconds READ seconds WRITE setSeconds NOTIFY secondsChanged)

    bool getIsActive() const;
    void setIsActive(bool value);

    int years() const;
    void setYears(int years);

    int days() const;
    void setDays(int days);

    int hours() const;
    void setHours(int hours);

    int minutes() const;
    void setMinutes(int minutes);

    int seconds() const;
    void setSeconds(int seconds);

    int monts() const;
    void setMonths(int months);

private:

    bool isActive;
    int _years;
    int _months;
    int _days;
    int _hours;
    int _minutes;
    int _seconds;
};

#endif // CUSTOMDATE_H
