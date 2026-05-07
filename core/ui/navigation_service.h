#ifndef NAVIGATION_SERVICE_H
#define NAVIGATION_SERVICE_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

class NavigationService : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit NavigationService(QObject *parent = nullptr);
    virtual ~NavigationService() = default;

    //Q_INVOKABLE void replaceTo(const QString& pageId);
    // Q_INVOKABLE void goTo(const QString& pageId);
    // Q_INVOKABLE void goBack();

signals:
    //void navigateReplaceTo(const QString& pageId);
    void navigateTo(const QString& pageId);
    void navigateBack();

public slots:
    void goTo(const QString& pageId);
    void goBack();
};

#endif // NAVIGATION_SERVICE_H
