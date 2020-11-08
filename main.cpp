#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSurfaceFormat>
#include "unhandledeventshandler.h"
#include "deadlinehandler.h"
#include "customdate.h"


void testStuff(){
    CustomDate date = CustomDate();
    date.setSecond(12);
    qDebug() << "seconde : " << date.second();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    QQmlApplicationEngine engine;

    testStuff();


    qmlRegisterType<UnhandledEventsHandler>("Backend", 1, 0, "UnhandledEventsHandler");
    qmlRegisterType<DeadlineHandler>("Backend", 1, 0, "DeadlineHandler");
    qmlRegisterType<CustomDate>("Backend", 1, 0, "CustomDate");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}


