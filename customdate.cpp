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
    return dateTime.date().year();
}

void CustomDate::setYear(int year)
{
    dateTime.setDate(QDate(year, dateTime.date().month(), dateTime.date().day()));
}

int CustomDate::month() const
{
    return dateTime.date().month();
}

void CustomDate::setMonth(int month)
{
    dateTime.setDate(QDate(dateTime.date().year(), month, dateTime.date().day()));
}

int CustomDate::day() const
{
    return dateTime.date().day();
}

void CustomDate::setDay(int day)
{
    dateTime.setDate(QDate(dateTime.date().year(), dateTime.date().month(), day));
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


