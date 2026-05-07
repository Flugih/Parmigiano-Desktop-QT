#include "auth_view_model.h"

#include <QMetaEnum>

#include "features/auth/repository/auth_repository.h"

AuthViewModel::AuthViewModel(QObject *parent)
    : _AuthRepository(new AuthRepository())
{
    connect(_AuthRepository, &AuthRepository::loginFinished,
           this, &AuthViewModel::processLoginFinished);

    // connect(_AuthRepository, &AuthRepository::verifyCodeFinished,
    //         this, &AuthViewModel::processVerifyCodeFinished);

    // connect(_AuthRepository, &AuthRepository::createProfileFinished,
    //         this, &AuthViewModel::processCreateProfileFinished);
}

void AuthViewModel::processLoginFinished(const QString& message, int code) const
{
    switch (code)
    {
    case AuthViewModel::Status::Ok:
        emit const_cast<AuthViewModel*>(this)->navigateToVerifyCode();
        break;
    case AuthViewModel::Status::NotFound:
        emit const_cast<AuthViewModel*>(this)->navigateToCreateProfile();
        break;
    default:
        //emit const_cast<AuthViewModel*>(this)->displayMessage("Server connection error. Please try again later.");
        emit const_cast<AuthViewModel*>(this)->displayMessage(message);
        break;
    }
}

void AuthViewModel::processVerifyCodeFinished(const QString& message, int code) const
{

}

void AuthViewModel::processCreateProfileFinished(const QString& message, int code) const
{

}

void AuthViewModel::login(const QString &email)
{
    _AuthRepository->login(email);
}

void AuthViewModel::verifyCode(const QString& email,
                               const QString& code)
{
    _AuthRepository->verifyCode(email, code);
}

void AuthViewModel::createProfile(const QString& name,
                                  const QString& username,
                                  const QString& email)
{
    _AuthRepository->createProfile(name, username, email);
}
