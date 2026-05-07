#include "verify_code_source.h"

#include <QJsonObject>
#include <QUrlQuery>

VerifyCodeSource::VerifyCodeSource(QObject *parent, const QString& link)
    : BaseSource(parent, link)
{}

void VerifyCodeSource::verifyCode(VerifyCodeRequest &model)
{
    if (_reply)
    {
        _reply->disconnect();
        _reply->abort();
        _reply->deleteLater();
        _reply = nullptr;
    }

    QJsonObject jsonObj;

    jsonObj["email"] = model.email;
    jsonObj["code"] = model.code;

    QJsonDocument jsonDoc(jsonObj);
    QByteArray jsonData = jsonDoc.toJson();

    QNetworkRequest request(QUrl(_link.toUtf8()));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    _reply = _networkManager.post(request, jsonData);

    // connect(_reply, &QNetworkReply::finished,
    //         this, &VerifyCodeSource::processCode);
}

// void VerifyCodeSource::processCode()
// {
//     if (!_reply) return;

//     int statusCode = _reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

//     emit verifyFinished(statusCode);

//     _reply->deleteLater();
//     _reply = nullptr;
// }
