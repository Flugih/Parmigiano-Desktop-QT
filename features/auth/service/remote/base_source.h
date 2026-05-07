#ifndef BASE_SOURCE_H
#define BASE_SOURCE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <functional>
#include <qjsonobject.h>

class BaseSource : public QObject
{
    Q_OBJECT
public:
    explicit BaseSource(QObject *parent = nullptr, const QString& link = "");

    virtual QJsonObject getJSON();
    virtual void setJSON(QJsonObject jsonObj);

protected:
    QList<QVariantMap> _data;
    QNetworkAccessManager _networkManager;
    QNetworkReply* _reply = nullptr;
    QJsonObject currentJSON;

    QString _link;

    //virtual void processCode() = 0;
    virtual void request(const QJsonObject& jsonObj,
                         std::function<void()> func = nullptr,
                         const QMap<QString, QString>& headers = {});

private:
    void processResponse(QNetworkReply* reply);

signals:
    void processResponseFinished(QJsonObject jsonObj, int code);
};

#endif // BASE_SOURCE_H
