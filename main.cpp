#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QTranslator>
#include <QQmlContext>
#include <QNetworkInformation>

#include "core/ui/ui_state_manager.h"
#include "core/ui/localization_manager.h"
#include "core/ui/pmg_types.h"

#include <QThread>

void checkNetwork(UIStateManager* _UIStateManager, QNetworkInformation::Reachability reachability);

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("ParmigianoChat co");
    QCoreApplication::setOrganizationDomain("parmigianochat.ru");
    QCoreApplication::setApplicationName("ParmigianoChat");

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/assets/logo.png"));

    QQmlApplicationEngine engine;

    // Core
    auto _UIStateManager = engine.singletonInstance<UIStateManager*>("ParmigianoDesktop.CoreUI", "UIStateManager");

    LocalizationManager* _LocalizationManager = LocalizationManager::getInstance();
    _LocalizationManager->setEngine(&engine);
    _LocalizationManager->changeLanguage(Pmg::Language::RU);

    qmlRegisterUncreatableMetaObject(
        Pmg::staticMetaObject,
        "Types",
        1, 0,
        "Pmg",
        "Error. Pmg is namespace"
    );

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ParmigianoDesktop", "Main");

    if (QNetworkInformation::loadBackendByFeatures(QNetworkInformation::Feature::Reachability))
    {
        auto netInfo = QNetworkInformation::instance();

        checkNetwork(_UIStateManager, netInfo->reachability());
        QObject::connect(netInfo, &QNetworkInformation::reachabilityChanged,
                         &app, [=] (QNetworkInformation::Reachability reachability) {
            checkNetwork(_UIStateManager, reachability);
        });
    }

    return app.exec();
}

void checkNetwork(UIStateManager* _UIStateManager, QNetworkInformation::Reachability reachability) {
    if (reachability == QNetworkInformation::Reachability::Online)
    {
        _UIStateManager->setNetworkStatus(true);
    }
    else
    {
        _UIStateManager->setNetworkStatus(false);
    }
}
