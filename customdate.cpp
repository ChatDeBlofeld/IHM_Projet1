#include "customdate.h"
#include <QDate>
#include <iostream>

using namespace std;

CustomDate::CustomDate() : QObject()
{
}


CustomDate::CustomDate(int year, int month, int day, int hour, int minute, int second) : _year(year), _month(month), _day(day), _hour(hour), _minute(minute), _second(second) {
}


ostream &operator<<( ostream &output, const CustomDate &d ) {
         output << d.year() << "-" << d.month() << "-" << d.day() << " " << d.hour() << ":" << d.minute() << ":" << d.second();
         return output;
      }

QDateTime CustomDate::toDateTime()
{
    return QDateTime(QDate(_year, _month, _day), QTime(_hour, _minute, _second));
}

bool CustomDate::getIsActive() const
{
    return _isActive;
}

void CustomDate::setIsActive(bool value)
{
    _isActive = value;
}


int CustomDate::year() const
{
    return _year;
}

void CustomDate::setYear(int year)
{
    _year = year;
}

int CustomDate::month() const
{
    return _month;
}

void CustomDate::setMonth(int month)
{
    _month = month;
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


