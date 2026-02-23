#include "clipboardmanager.h"

#include <QClipboard>

ClipboardManager::ClipboardManager(QObject *parent)
    : QObject{parent}
{}

QString ClipboardManager::getClipboardData()
{
    return clipboard->text();
}
