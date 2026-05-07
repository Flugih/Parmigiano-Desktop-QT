#ifndef APP_CONFIG_H
#define APP_CONFIG_H

#include <QString>

namespace AppConfig {
    //inline constexpr char baseURL[] = "https://parmigianochat.ru/api/v2/";
    inline constexpr char baseURL[] = "http://localhost:8080/";

    inline QString loginEndPoint() { return QString(baseURL) + "api/v2/auth/confirm/email"; }
    inline QString createProfileEndPoint() { return QString(baseURL) + "auth/create"; }
    inline QString verifyCodeEndPoint() { return QString(baseURL) + "auth/verify"; }
}

#endif // CONFIG_H
