#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/assets/logo.png"));

    QQmlApplicationEngine engine;
    QTranslator translator;

    if(translator.load(":/ui/translations/release/ParmigianoDesktop_ru_RU.qm"))
        app.installTranslator(&translator);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ParmigianoDesktop", "Main");

    return app.exec();
}
