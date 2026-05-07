#include "base_source.h"

#include <QJsonDocument>
#include <QNetworkInformation>
#include <qjsonobject.h>
#include <QTimer>
#include <qthread.h>

BaseSource::BaseSource(QObject *parent, const QString &link)
    : QObject{parent}, _link(link)
{}

void BaseSource::request(const QJsonObject& jsonObj,
                         std::function<void()> func,
                         const QMap<QString, QString>& headers)
{
    // if (_reply)
    // {
    //     //_reply->disconnect();
    //     _reply->abort();
    //     _reply->deleteLater();
    //     _reply = nullptr;
    // }

    QJsonDocument jsonDoc(jsonObj);

    QByteArray jsonData = jsonDoc.toJson();

    QNetworkRequest request(QUrl(_link.toUtf8()));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    if (!headers.isEmpty())
    {
        for(auto [name, value] : headers.asKeyValueRange())
        {
            request.setRawHeader(name.toUtf8(), value.toUtf8());
        }
    }

    request.setRawHeader("X-Request-ID", "123123");

    QNetworkReply* reply = _networkManager.post(request, jsonData);
    qDebug() << reply;

    if (func) connect(reply, &QNetworkReply::finished, this, func);
    else connect(reply, &QNetworkReply::finished, this, [=]() {
        processResponse(reply);
    });

    QList<QByteArray> headerList = request.rawHeaderList();
    foreach (const QByteArray &head, headerList)
    {
        qDebug() << head << ":" << request.rawHeader(head);
    }

    qDebug() << jsonObj;
    qDebug() << _link;
    qDebug() << "";
}

QJsonObject BaseSource::getJSON()
{
    return currentJSON;
}

void BaseSource::setJSON(QJsonObject jsonObj)
{
    if (currentJSON != jsonObj) currentJSON = jsonObj;
}

void BaseSource::processResponse(QNetworkReply* reply)
{

    //qDebug() << "Base method";
    if (!reply) return;

    QByteArray data = reply->readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);
    QJsonObject jsonObj = jsonDoc.object();

    // if (jsonObj["message"].toObject().contains("challenge"))
    // {
    //     qDebug() << "CHALLENGE!!!";
    // }

    int code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    qDebug() << code;
    emit processResponseFinished(jsonObj, code);

    reply->deleteLater();
    reply = nullptr;
}
