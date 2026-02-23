cmake_minimum_required(VERSION 3.16)

project(ParmigianoDesktop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appParmigianoDesktop
    main.cpp
)

qt_add_qml_module(appParmigianoDesktop
    URI ParmigianoDesktop
    VERSION 1.0
    QML_FILES
        Main.qml
        ui/auth/ConfirmEmailPage.qml
        ui/auth/CreateProfilePage.qml
        ui/auth/CloudPasswordPage.qml
        ui/auth/MessengerPage.qml
        ui/auth/VerifyCodePage.qml
        ui/js/logic.js
    SOURCES
        core/clipboardmanager.h
        core/clipboardmanager.cpp
        core/config.h
        core/config.cpp
    RESOURCES
        Resource.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appParmigianoDesktop PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appParmigianoDesktop
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appParmigianoDesktop
    PRIVATE Qt6::Quick
)
target_link_libraries(appParmigianoDesktop PRIVATE Qt6::Core)
target_link_libraries(appParmigianoDesktop PRIVATE Qt6::Core)
target_include_directories(appParmigianoDesktop PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/core)

include(GNUInstallDirs)
install(TARGETS appParmigianoDesktop
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
