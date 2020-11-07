#ifndef CREATEPOSTITHANDLER_H
#define CREATEPOSTITHANDLER_H

#include <QObject>

class CreatePostItHandler : public QObject
{
    Q_OBJECT
public:
    CreatePostItHandler();
public slots:
    void create(const QString& content, const QString& dueDate);
};

#endif // CREATEPOSTITHANDLER_H
