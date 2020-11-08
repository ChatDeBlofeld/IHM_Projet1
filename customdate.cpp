#include "customdate.h"
#include <QDate>

CustomDate::CustomDate()
{
    isActive = false;
}

CustomDate::CustomDate(int years, int days, int hours, int minutes, int seconds) : _years(years), _days(days), _hours(hours), _minutes(minutes), _seconds(seconds){
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

int CustomDate::years() const
{
    return _years;
}

void CustomDate::setYears(int years)
{
    setDate(QDate(years, date().month(), date().day()));
}

int CustomDate::days() const
{
    return _days;
}

void CustomDate::setDays(int days)
{
    _days = days;
}

int CustomDate::hours() const
{
    return _hours;
}

void CustomDate::setHours(int hours)
{
    _hours = hours;
}

int CustomDate::minutes() const
{
    return _minutes;
}

void CustomDate::setMinutes(int minutes)
{
    _minutes = minutes;
}

int CustomDate::seconds() const
{
    return _seconds;
}

void CustomDate::setSeconds(int seconds)
{
    _seconds = seconds;
}

int CustomDate::monts() const
{
    return _months;
}

void CustomDate::setMonths(int months)
{
    _months = months;
}
