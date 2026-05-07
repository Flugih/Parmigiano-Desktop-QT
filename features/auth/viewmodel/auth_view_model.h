#ifndef AUTH_VIEW_MODEL_H
#define AUTH_VIEW_MODEL_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

class AuthRepository;

class AuthViewModel : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit AuthViewModel(QObject *parent = nullptr);
    ~AuthViewModel() = default;

private:
    AuthRepository* _AuthRepository;

    enum Status {
        Unknown = 0,
        Ok = 200,
        Accepted = 202,
        BadRequest = 400,
        NotFound = 404,
        InternalError = 500
    };

    void processLoginFinished(const QString& message, int code) const;
    void processVerifyCodeFinished(const QString& message, int code) const;
    void processCreateProfileFinished(const QString& message, int code) const;

signals:
    void navigateToVerifyCode();
    void navigateToCreateProfile();
    void displayMessage(const QString& message);

public slots:
    void login(const QString& email);

    void verifyCode(const QString& email,
                    const QString& code);

    void createProfile(const QString& name,
                       const QString& username,
                       const QString& email);
};

#endif // AUTH_VIEW_MODEL_H
