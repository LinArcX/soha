#TEMPLATE = app

QT += qml quick quickcontrols2
CONFIG += c++11
#console

SOURCES += $$files(*.cpp, true) $$files(*.c, true)
HEADERS += $$files(*.h, true)
RESOURCES += $$files(*.qrc, true)

# CXXFLAGS
#QMAKE_CXXFLAGS += #-Werror=old-style-cast #-static-libgcc -static-libstdc++

# Default rules for deployment.
#include(AppConf/deployment.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

#unix:{
#    INCLUDEPATH += "$$PWD/Util/Libs/include/libcalendars"
#    LIBS += "$$PWD/Util/Libs/lib/libcalendars.a"
#}

windows {
    RC_FILE = soha.rc
}
