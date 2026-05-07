#include "auth_repository.h"

#include "core/config/app_config.h"

#include "features/auth/service/dto/create_profile_model.h"
#include "features/auth/service/dto/login_model.h"
#include "features/auth/service/dto/verify_code_model.h"

#include "features/auth/service/remote/login_source.h"
#include "features/auth/service/remote/create_profile_source.h"
#include "features/auth/service/remote/verify_code_source.h"

#include "domain/pow_process.h"

//#include "features/auth/model/request_data.h"

#include <QNetworkInformation>
#include <QMetaEnum>
#include <qjsonobject.h>
#include <qtimer.h>

AuthRepository::AuthRepository(QObject *parent)
    : QObject{parent},
    _LoginSource(new LoginSource(nullptr, AppConfig::loginEndPoint())),
    _CreateProfileSource(new CreateProfileSource(nullptr, AppConfig::createProfileEndPoint())),
    _VerifyCodeSource(new VerifyCodeSource(nullptr, AppConfig::verifyCodeEndPoint())),
    _PoWProcess(PoWProcess::getInstance())
{
    // _LoginSource = new LoginSource(nullptr, AppConfig::loginEndPoint());
    // _CreateProfileSource = new CreateProfileSource(nullptr, AppConfig::createProfileEndPoint());
    // _VerifyCodeSource = new VerifyCodeSource(nullptr, AppConfig::verifyCodeEndPoint());
    // _PoWProcess = std::make_unique<PoWProcess>();
    // _PoWProcess = PoWProcess::getInstance();
    //_PoWProcess = new PoWProcess();

    // connect(_LoginSource, &LoginSource::loginFinished,
    //         this, &AuthRepository::handleLoginResponse);

    /*connect(_CreateProfileSource, &CreateProfileSource::createFinished,
            this, &AuthRepository::handleCreateProfileResponse);


    connect(_VerifyCodeSource, &VerifyCodeSource::verifyFinished,
            this, &AuthRepository::handleVerifyCodeResponse);*/
}

//AuthRepository::~AuthRepository() {}

AuthRepository::Status AuthRepository::handleResponseCode(int code)
{
    QMetaEnum metaEnum = QMetaEnum::fromType<AuthRepository::Status>();

    if (metaEnum.valueToKey(code) != nullptr)
    {
        AuthRepository::Status status = static_cast<AuthRepository::Status>(code);

        return status;
    }

    return AuthRepository::Status::Unknown;
}

void AuthRepository::handleErrorCodes(AuthRepository::Status status)
{
    switch (status)
    {
    case AuthRepository::Status::BadRequest:
        break;
    case AuthRepository::Status::InternalError:
        break;
    default:
        break;
    }
}

void AuthRepository::handleLoginResponse(const ResponseData& result)
{
    // if (_PoWProcess->check(jsonObj))
    // {
    //     //qDebug() << "Challenge!!!";

    //     QString challenge = jsonObj["message"].toObject()["challenge"].toString();
    //     uint8_t difficulty = jsonObj["message"].toObject()["difficulty"].toInt();

    //     auto result = _PoWProcess->solve(challenge, difficulty);

    //     if (!result.has_value())
    //     {
    //         // throw result to server and start catching response to previous request
    //     }
    //     else
    //     {
    //         // request another one challenge
    //     }
    // }

    QJsonObject jsonData = result.jsonData;
    int code = result.code;

    if (!checkForChallenge(
        jsonData,
        _LoginSource->getJSON(),
        [this](QJsonObject jsonObj, QMap<QString, QString> headers)
        {
            //LoginSource* __LoginSource = new LoginSource(nullptr, AppConfig::loginEndPoint());
            //_LoginSource->login(jsonObj, headers);
            // QTimer::singleShot(0, [this, jsonObj, headers]() {
            //     _LoginSource->login(jsonObj, headers);
            // });
            //_LoginSource->login(jsonObj, headers);
        }))
    {
        return;
    }

    AuthRepository::Status status = handleResponseCode(code);

    switch (status)
    {
    case AuthRepository::Status::Ok:
        emit authFinished(AuthRepository::Action::NavigateToVerifyCode);
        break;
    // case AuthRepository::Status::Accepted:
    //     //emit authFinished(AuthRepository::Action::NavigateToPasswordInput);
    //     break;
    // case AuthRepository::Status::NotFound:
    //     //emit authFinished(AuthRepository::Action::NavigateToCreateProfile);
    //     break;
    default:
        emit authFinished(AuthRepository::Action::DisplayError);
        //emit authFinished(AuthRepository::Action::NavigateToCreateProfile);
        //qDebug() << AuthRepository::Action::DisplayError;
        break;
    }
}

void AuthRepository::handleCreateProfileResponse(const ResponseData& result)
{
    //int code = jsonObj["response_code"].toInt();
    // AuthRepository::Status status = handleResponseCode(code);

    // switch (status)
    // {
    // case AuthRepository::Status::Ok:
    //     emit authFinished(AuthRepository::Action::NavigateToVerifyCode);
    //     break;
    // default:
    //     emit authFinished(AuthRepository::Action::DisplayError);
    //     break;
    // }
}

void AuthRepository::handleVerifyCodeResponse(const ResponseData& result)
{
    // //int code = jsonObj["response_code"].toInt();
    // AuthRepository::Status status = handleResponseCode(code);

    // switch (status)
    // {
    // case AuthRepository::Status::Ok:
    //     emit authFinished(AuthRepository::Action::NavigateToMessenger);
    //     break;
    // default:
    //     emit authFinished(AuthRepository::Action::DisplayError);
    //     break;
    // }
}

QMap<QString, QString> AuthRepository::defineHeaders()
{
    QMap<QString, QString> headers;
    // _PoWProcess->setChallenge("123");
    //qDebug() << _PoWProcess->getChallenge();
    auto nonce = _PoWProcess->getNonce();
    QString challenge = _PoWProcess->getChallenge();

    if (!challenge.isEmpty())
    {
        headers["pow-challenge"] = challenge;
    }

    if (nonce.has_value())
    {
        QString value = QString::number(*nonce);
        headers["pow-nonce"] = value;
    }

    //headers["X-Debug"] = "1";
    headers["Accept-Language"] = "en";
    //headers["accept"] = "application/json";

    return headers;
}

bool AuthRepository::checkForChallenge(QJsonObject jsonResponse,
                                       const QJsonObject& jsonRequest,
                                       std::function<void(const QJsonObject& jsonObj, QMap<QString, QString> headers)> func)
{
    // if (!_PoWProcess->check(jsonResponse))
    // {
    //    return true;
    // }

    QString challenge = jsonResponse["message"].toObject()["challenge"].toString();
    uint8_t difficulty = jsonResponse["message"].toObject()["difficulty"].toInt();

    _PoWProcess->solve(challenge, difficulty);
    QMap<QString, QString> headers = defineHeaders();
    func(jsonRequest, headers);

    return false;
}

void AuthRepository::login(const QString &email)
{
    LoginRequest model{email};
    QJsonObject jsonObj = model.toJson();
    QMap<QString, QString> headers = defineHeaders();

    auto onResult = [this] (const ResponseData& result)
    {
        QString message = "";
        int code = result.code;

        if (code != 200 && code != 404)
        {
            message = "Server connection error. Please try again later.";
        }

        emit loginFinished(message, code);
    };

    RequestData reqData{onResult, jsonObj, headers};

    _LoginSource->login(reqData);
}

void AuthRepository::createProfile(const QString &name,
                                   const QString &username,
                                   const QString &email)
{
    CreateProfileRequest model;

    model.name = name;
    model.username = username;
    model.email = email;

    _CreateProfileSource->createProfile(model);
}

void AuthRepository::verifyCode(const QString &email,
                                const QString &code)
{
    VerifyCodeRequest model;

    model.email = email;
    model.code = code;

    _VerifyCodeSource->verifyCode(model);
}
