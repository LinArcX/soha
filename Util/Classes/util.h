#pragma once
#include <QString>
#include <QByteArray>

namespace linarcx {

    class Util {
        public:
            static QString readFile(QString fileName);
    };

    QByteArray readFile_ByteArray(QString fileName);
    void writeToFile(QString, QString);
    QString createFile(QString, QString, QString);

}
