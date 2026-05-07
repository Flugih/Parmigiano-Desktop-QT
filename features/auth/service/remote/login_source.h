#ifndef LOGIN_SOURCE_H
#define LOGIN_SOURCE_H

#include <qjsonobject.h>

//#include "features/auth/service/dto/login_model.h"
#include "features/auth/model/request_data.h"
#include "base_source.h"

// namespace HTTP
// {
//     class NetworkManager;
// }

class HTTPClient;
class PoWProcess;

class LoginSource : public BaseSource
{
    Q_OBJECT
public:
    explicit LoginSource(QObject *parent = nullptr, const QString& link = "");

    // void login(LoginRequest& model,
    //            const QMap<QString, QString>& headers = {});

    void login(const RequestData& reqData);

private:
    HTTPClient* _HTTPClient;
    PoWProcess* _PoWProcess;

    int _retryAttempts = 2;
    int _currentAttempt = 0;

signals:
    //void loginFinished(const ResponseData& result);

};

#endif // LOGIN_SOURCE_H
