#ifndef CUSTOMDATE_H
#define CUSTOMDATE_H

#include <QQuickItem>
#include <QDateTime>

class CustomDate : public QObject
{
    friend std::ostream &operator<<( std::ostream &output, const CustomDate &d );

    Q_OBJECT
    Q_PROPERTY(int year READ year WRITE setYear /*NOTIFY yearChanged*/)
    Q_PROPERTY(int month READ month WRITE setMonth /*NOTIFY monthChanged*/)
    Q_PROPERTY(int day READ day WRITE setDay /*NOTIFY dayChanged*/)
    Q_PROPERTY(int hour READ hour WRITE setHour /*NOTIFY hourChanged*/)
    Q_PROPERTY(int minute READ minute WRITE setMinute /*NOTIFY minuteChanged*/)
    Q_PROPERTY(int second READ second WRITE setSecond /*NOTIFY secondChanged*/)
public:
    CustomDate();
    CustomDate(int year, int month, int day, int hour, int minute, int second);

    CustomDate(const CustomDate &cd) : QObject(){
        _year = cd.year();
        _month = cd.month();
        _day = cd.day();
        _hour = cd.hour();
        _minute = cd.minute();
        _second = cd.second();
    }

    QDateTime toDateTime();

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
    bool _isActive;
    int _year;
    int _month;
    int _day;
    int _hour;
    int _minute;
    int _second;

};

Q_DECLARE_METATYPE(CustomDate);

#endif // CUSTOMDATE_H
