TEMPLATE = app
TARGET = harbour-tweetian

# Application version

# Since harbour does not distinguish build numbers
# we cannot just differentiate from upstream by build number
# thus using 2.x.x from now on for sailfish port
# based on upstream 1.8.3
VERSION = "2.0.8"
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# Qt Library
QT += network

HEADERS += \
    src/qmlutils.h \
    src/thumbnailcacher.h \
    src/userstream.h \
    src/networkmonitor.h \
    src/imageuploader.h

SOURCES += main.cpp \
    src/qmlutils.cpp \
    src/thumbnailcacher.cpp \
    src/userstream.cpp \
    src/networkmonitor.cpp \
    src/imageuploader.cpp

contains(MEEGO_EDITION,harmattan){
    QT += dbus
    CONFIG += qdeclarative-boostable shareuiinterface-maemo-meegotouch share-ui-plugin share-ui-common mdatauri sailfishapp
    DEFINES += Q_OS_HARMATTAN
    RESOURCES += qml-harmattan.qrc

    include(notifications/notifications.pri)
    splash.files = splash/tweetian-splash-portrait.jpg splash/tweetian-splash-landscape.jpg
    splash.path = /opt/tweetian/splash
    INSTALLS += splash

    HEADERS += src/tweetianif.h src/harmattanutils.h
    SOURCES += src/tweetianif.cpp src/harmattanutils.cpp
}

OTHER_FILES += qtc_packaging/debian_harmattan/* \
    i18n/tweetian_*.ts \
    harbour-tweetian.desktop \
    README.md \
    qml/tweetian-harmattan/*.qml \
    qml/tweetian-harmattan/*.js \
    qml/tweetian-harmattan/ListPageCom/*.qml \
    qml/tweetian-harmattan/MainPageCom/*.qml \
    qml/tweetian-harmattan/UserPageCom/*.qml \
    qml/tweetian-harmattan/SearchPageCom/*.qml \
    qml/tweetian-harmattan/Component/*.qml \
    qml/tweetian-harmattan/Delegate/*.qml \
    qml/tweetian-harmattan/Dialog/*.qml \
    qml/tweetian-harmattan/Utils/*js \
    qml/tweetian-harmattan/Services/*.js

CONFIG += link_pkgconfig
CONFIG += c++11
packagesExist(sailfishapp) {
message("sailfishapp")
    PKGCONFIG += sailfishapp mlite5

    include(notifications/notifications.pri)

    desktopfile.files = $${TARGET}.desktop
    desktopfile.path = /usr/share/applications

    export (desktopfile)

    target.path = /usr/bin

    sailfish_icon.files = harbour-tweetian.png
    sailfish_icon.path = /usr/share/icons/hicolor/86x86/apps

    INCLUDEPATH += /usr/include/sailfishapp

    INSTALLS += target sailfish_icon desktopfile
    QT += dbus quick qml
    CONFIG += qdeclarative-boostable shareuiinterface-maemo-meegotouch share-ui-plugin share-ui-common mdatauri
    DEFINES += Q_OS_HARMATTAN
    RESOURCES += qml-harmattan.qrc

    HEADERS += src/tweetianif.h
    SOURCES += src/tweetianif.cpp

    HEADERS += src/harmattanutils.h
    SOURCES += src/harmattanutils.cpp
    OTHER_FILES += rpm/* \
                   qml/tweetian-harmattan/WorkerScript/* \
                   qml/tweetian-harmattan/SettingsPageCom/*qml

} else {
    # Please do not modify the following two lines. Required for deployment.
    include(qmlapplicationviewer/qmlapplicationviewer.pri)
    qtcAddDeployment()
}
