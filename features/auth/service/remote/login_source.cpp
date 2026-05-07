#include "login_source.h"

#include <QJsonObject>
#include <QUrlQuery>
#include <qtimer.h>

#include "core/network/http_client.h"
#include "features/auth/model/response_data.h"
#include "domain/pow_process.h"

LoginSource::LoginSource(QObject *parent, const QString &link)
    : BaseSource(parent, link),
    //_HTTPClient(HTTPClient::getInstance()),
    _HTTPClient(new HTTPClient()),
    _PoWProcess(PoWProcess::getInstance())
{
    //connect(this, &BaseSource::processResponseFinished, this, &LoginSource::loginFinished);
}

// void LoginSource::login(LoginRequest& dto, const QMap<QString, QString>& headers)
// {
//     QJsonObject jsonObj;

//     //jsonObj["email"] = model.email;
//     // if (!model.password.isEmpty() && model.password != "")
//     //     jsonObj["password"] = model.password;

//     jsonObj.insert("email", dto.email);

//     setJSON(jsonObj);

//     _HTTPClient->sendRequest(
//         HTTPClient::RequestTypes::POST,
//         jsonObj,
//         _link,
//         headers,
//         [this] (const QJsonObject& jsonData, uint16_t code) {
//             ResponseData result;
//             result.jsonData = jsonData;
//             result.code = code;

//             emit loginFinished(result);
//         });

//     //qDebug() << jsonObj;

//     //request(jsonObj, [this] () { processCode(); });
//     //request(jsonObj, nullptr, headers);

//     // QJsonDocument jsonDoc(jsonObj);

//     // //qDebug() << jsonDoc.toJson();

//     // QByteArray jsonData = jsonDoc.toJson();

//     // QNetworkRequest request(QUrl(link_.toUtf8()));
//     // request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

//     // _reply = _networkManager.post(request, jsonData);

//     // connect(_reply, &QNetworkReply::finished,
//     //         this, &LoginSource::processCode);
// }

void LoginSource::login(const RequestData& reqData)
{
    if (_currentAttempt >= _retryAttempts)
    {
        return;
    }

    _currentAttempt++;

    _HTTPClient->sendRequest(
        HTTPClient::RequestTypes::POST,
        reqData.jsonObj,
        _link,
        reqData.headers,
        [this, reqData] (const QJsonObject& jsonObj, uint16_t code) {
            // Checking for PoW, solve PoW and retry request if it need
            // If all right call up callback
            if (jsonObj["message"].toObject().contains("challenge") || code == 202)
            {
                QString challenge = jsonObj["message"].toObject()["challenge"].toString();
                uint8_t difficulty = jsonObj["message"].toObject()["difficulty"].toInt();

                _PoWProcess->solve(challenge, difficulty);

                auto nonce = _PoWProcess->getNonce();
                QString value = QString::number(*nonce);

                QMap<QString, QString> headers = reqData.headers;
                headers["pow-challenge"] = challenge;
                headers["pow-nonce"] = value;

                RequestData RetryReqData;
                RetryReqData.jsonObj = reqData.jsonObj;
                RetryReqData.callback = reqData.callback;
                RetryReqData.headers = headers;

                login(RetryReqData);
            }
            else
            {
                ResponseData result;
                result.jsonData = jsonObj;
                result.code = code;

                reqData.callback(result);
            }

            //qDebug() << jsonObj;

            //emit loginFinished(result);
        });
}
