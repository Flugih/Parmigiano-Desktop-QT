#ifndef CLIPBOARDMANAGER_H
#define CLIPBOARDMANAGER_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

class QClipboard;

class ClipboardManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ClipboardManager(QObject *parent = nullptr);

    Q_INVOKABLE QString getClipboardData();
signals:

private:
    QClipboard* clipboard;
};

#endif // CLIPBOARDMANAGER_H
