#include "customdate.h"
#include <QDate>

CustomDate::CustomDate()
{
    isActive = false;
}

CustomDate::CustomDate(int year, int day, int hour, int minute, int second) : _year(year), _day(day), _hour(hour), _minute(minute), _second(second){
    isActive = true;
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
    return dateTime.date().year();
}

void CustomDate::setYear(int year)
{
    dateTime.setDate(QDate(year, date().month(), date().day()));
}

int CustomDate::day() const
{
    return dateTime.date().day();
}

void CustomDate::setDay(int day)
{
    dateTime.setDate(QDate(date().year(), date().month(), day));
}

int CustomDate::hour() const
{
    return dateTime.time().hour();
}

void CustomDate::setHour(int hour)
{
    dateTime.setTime(QTime(hour, dateTime.time().minute(), dateTime.time().second()));
}

int CustomDate::minute() const
{
    return _minute;
}

void CustomDate::setMinute(int minute)
{
    _minute = minute;
}

int CustomDate::second() const
{
    return _second;
}

void CustomDate::setSecond(int second)
{
    _second = second;
}

int CustomDate::monts() const
{
    return _month;
}

void CustomDate::setMonth(int month)
{
    _month = month;
}
