#include "auth_context.h"

AuthContext AuthContext::_instancePtr;

AuthContext::AuthContext(QObject *parent)
    : QObject{parent}
{}

QObject *AuthContext::singletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return new AuthContext();
}

QString AuthContext::getEmail()
{
    return _email;
}

void AuthContext::setEmail(const QString &email)
{
    if (_email != email)
    {
        _email = email;
        emit emailChanged(_email);
    }
}
