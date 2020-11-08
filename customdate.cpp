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
