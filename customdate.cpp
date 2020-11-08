#include "customdate.h"
#include <QDate>

CustomDate::CustomDate()
{
    isActive = false;
}


bool CustomDate::getIsActive() const
{
    return isActive;
}

void CustomDate::setIsActive(bool value)
{
    isActive = value;
}

int CustomDate::year() const
{
    return _year;
}

void CustomDate::setYear(int year)
{
    setDate(QDate(year, date().month(), date().day()));
}

int CustomDate::day() const
{
    return _day;
}

void CustomDate::setDay(int day)
{
    _day = day;
}

int CustomDate::hour() const
{
    return _hour;
}

void CustomDate::setHour(int hour)
{
    _hour = hour;
}

int CustomDate::minute() const
{
    return dateTime.time().minute();
}

void CustomDate::setMinute(int minute)
{
    dateTime.setTime(QTime(dateTime.time().hour(), minute,  dateTime.time().second()));
}

int CustomDate::second() const
{
    return dateTime.time().second();
}

void CustomDate::setSecond(int second)
{
    dateTime.setTime(QTime(dateTime.time().hour(), dateTime.time().minute(), second));
}

int CustomDate::month() const
{
    return dateTime.date().month();
}

void CustomDate::setMonth(int month)
{
    dateTime.setDate(QDate(dateTime.date().year(), month, dateTime.date().day()));
}
