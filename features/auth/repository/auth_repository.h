#ifndef AUTH_REPOSITORY_H
#define AUTH_REPOSITORY_H

#include <QObject>
#include <QString>
#include <functional>

//#include "features/auth/model/request_data.h"
#include "features/auth/model/response_data.h"

class LoginSource;
class CreateProfileSource;
class VerifyCodeSource;
class PoWProcess;

class AuthRepository : public QObject
{
    Q_OBJECT
public:
    enum Status {
        Unknown = 0,
        Ok = 200,
        Accepted = 202,
        BadRequest = 400,
        NotFound = 404,
        InternalError = 500
    };
    Q_ENUM(Status) //

    enum Action {
        NavigateToMessenger,
        NavigateToVerifyCode,
        NavigateToPasswordInput,
        NavigateToCreateProfile,
        DisplayError
    };
    Q_ENUM(Action) //

    explicit AuthRepository(QObject *parent = nullptr);
    virtual ~AuthRepository() = default;

private:
    LoginSource* _LoginSource;
    CreateProfileSource* _CreateProfileSource;
    VerifyCodeSource* _VerifyCodeSource;
    //std::unique_ptr<PoWProcess> _PoWProcess;
    PoWProcess* _PoWProcess; //

    AuthRepository::Status handleResponseCode(int code);
    void handleErrorCodes(AuthRepository::Status status); //

    void handleLoginResponse(const ResponseData& result);
    void handleCreateProfileResponse(const ResponseData& result);
    void handleVerifyCodeResponse(const ResponseData& result);
    QMap<QString, QString> defineHeaders();

    bool checkForChallenge(QJsonObject jsonResponse,
                           const QJsonObject& jsonRequest,
                           std::function<void(const QJsonObject& jsonObj, QMap<QString, QString> headers)> func = nullptr); //

signals:
    void authFinished(AuthRepository::Action); //

    void loginFinished(const QString& message, int code);
    void createProfileFinished(const QString& message, int code);
    void verifyCodeFinished(const QString& message, int code);

public slots:
    void login(const QString& email);

    void createProfile(const QString& name,
                       const QString& username,
                       const QString& email);

    void verifyCode(const QString& email,
                    const QString& code);

};

#endif // AUTH_REPOSITORY_H
