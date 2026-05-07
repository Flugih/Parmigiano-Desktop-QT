#include "create_profile_source.h"

#include <qjsonobject.h>

CreateProfileSource::CreateProfileSource(QObject *parent, const QString &link)
    : BaseSource(parent, link)
{}

void CreateProfileSource::createProfile(CreateProfileRequest& model)
{
    if (_reply)
    {
        _reply->disconnect();
        _reply->abort();
        _reply->deleteLater();
        _reply = nullptr;
    }

    QJsonObject jsonObj;

    jsonObj["name"] = model.name;
    jsonObj["username"] = model.username;
    jsonObj["email"] = model.email;

    QJsonDocument jsonDoc(jsonObj);
    QByteArray jsonData = jsonDoc.toJson();

    QNetworkRequest request(QUrl(_link.toUtf8()));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    _reply = _networkManager.post(request, jsonData);

    // connect(_reply, &QNetworkReply::finished,
    //         this, &CreateProfileSource::processCode);
}

// void CreateProfileSource::processCode()
// {
//     if (!_reply) return;

//     int statusCode = _reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

//     emit createFinished(statusCode);

//     _reply->deleteLater();
//     _reply = nullptr;
// }
