# Auth feature

## Overview

The feature is responsible for the full user authentication cycle, including:
- login and registration
- password recovery
- profile creation

The feature also:
- stores the authorization/registration state
- interacts with the HTTP server
- handles and displays network status
- notifies the user about errors (server and client-side)
- supports interface language changes

## Structure

- view/ — QML (Login, Register)
- viewmodel/ — UI logic and states
- model/ — Data structs (User, Token)
- repository/ — service interface
- service/ — API requests
- components/ — UI components inside auth

## Data Flow

view → viewmodel → repository → service(API)

The answer comes back the same way.

## Dependencies

- core/app_config
- core/clipboard_manager
- core/localization_manager
- core/pmg_types
- core/http_client

## Rules & Constraints
## Common Scenarios
### Login Flow

1. User enters data on the login screen
2. login calls ViewModel (login)
3. ViewModel sends a request through repository → service(API)
4. Depending on the response:
   - → verifyCode (if confirmation is required)
   - → cloudPassword (if an additional password is required)
   - → createProfile (if the profile has not yet been created)
   - → messenger (if the login is successful

### Verify Code Flow

1. The user enters the verification code
2. verifyCode calls the ViewModel
3. A request is sent to the server
4. If successful: 
   - → messenger

### Cloud Password Flow

1. User enters a cloud password
2. cloudPassword calls ViewModel
3. The check goes through repository → service
4. If successful: 
   - → messenger

### Create Profile Flow

1. User fills in profile data
2. createProfile calls ViewModel
3. Data is sent to the server
4. If successful: 
   - → messenger

---

### Error Handling

All possible causes of errors and the events that occur with them

#### Network Errors

- When sending a request to the server fails (timeout, request failure):
 	- a notification is displayed at the bottom of the screen
 	- text: **"Server connection error. Please try again later."**

#### Internet Connection State

- When there is no internet connection:
    - a system message about the connection loss appears at the top of the screen

- When the connection is restored:
 	- the message is updated with the message **"Connection restored"**
 	- then it automatically disappears (moves back)

## Navigation

- login → verifyCode
- login → cloudPassword
- login → createProfile


- verifyCode → messenger
- cloudPassword → messenger
- createProfile → messenger

