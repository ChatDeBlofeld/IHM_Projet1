#ifndef CUSTOMDATE_H
#define CUSTOMDATE_H

#include <QQuickItem>
#include <QDateTime>

class CustomDate : public QObject
{
    Q_OBJECT
public:
    CustomDate();

    Q_PROPERTY(int year READ year WRITE setYear NOTIFY yearChanged)
    Q_PROPERTY(int month READ month WRITE setMonth NOTIFY monthChanged)
    Q_PROPERTY(int day READ day WRITE setDay NOTIFY dayChanged)
    Q_PROPERTY(int hour READ hour WRITE setHour NOTIFY hourChanged)
    Q_PROPERTY(int minute READ minute WRITE setMinute NOTIFY minuteChanged)
    Q_PROPERTY(int second READ second WRITE setSecond NOTIFY secondChanged)

    bool getIsActive() const;
    void setIsActive(bool value);

    int year() const;
    void setYear(int year);

    int day() const;
    void setDay(int day);

    int hour() const;
    void setHour(int hour);

    int minute() const;
    void setMinute(int minute);

    int second() const;
    void setSecond(int second);

    int month() const;
    void setMonth(int month);

private:

    QDateTime dateTime;
};

#endif // CUSTOMDATE_H
