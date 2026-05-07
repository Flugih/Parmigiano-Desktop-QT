#include "navigation_service.h"

NavigationService::NavigationService(QObject *parent)
    : QObject{parent}
{}

void NavigationService::goTo(const QString &pageId)
{
    emit navigateTo(pageId);
}

void NavigationService::goBack()
{
    emit navigateBack();
}
