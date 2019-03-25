#include "Util/Classes/util.h"
#include <QDir>
#include <QFile>
#include <QString>
#include <QTextStream>
#include <iostream>

using namespace std;

namespace linarcx {
QString Util::readFile(QString fileName)
{
    QFile rFile(fileName);
    if (!rFile.exists()) {
        cout << fileName.toStdString() + " Not Found!" << endl;
    }
    if (!rFile.open(QFile::ReadOnly | QFile::Text)) {
        cout << "Could not open the file!";
        return 0;
    }
    QTextStream in(&rFile);
    QString input = in.readAll();
    rFile.flush();
    rFile.close();
    return input;
}

QByteArray readFile_ByteArray(QString fileName)
{
    QFile rFile(fileName);
    if (!rFile.exists()) {
        cout << fileName.toStdString() + " Not Found!" << endl;
    }
    if (!rFile.open(QFile::ReadOnly | QFile::Text)) {
        cout << "Could not open the file!";
        return nullptr;
    }
    rFile.open(QIODevice::ReadOnly);
    QByteArray rawData = rFile.readAll();

    rFile.close();
    return rawData;
}

void writeToFile(QString input, QString mPath)
{
    QFile wFile(mPath);
    if (!wFile.open(QFile::WriteOnly | QFile::Text)) {
        cout << "Could not write to the file!";
        return;
    }
    QTextStream out(&wFile);
    out << input;
    wFile.flush();
    wFile.close();
}

QString createFile(QString mPath, QString mDir, QString mFile)
{
    QString finalPath = mPath.append(mDir);
    QDir* dir = new QDir(finalPath);
    if (!dir->exists()) {
        dir->mkpath(finalPath);
        finalPath.append(mFile);
    } else {
        finalPath.append(mFile);
    }
    return finalPath;
}

// Get Current Gregorian Date
QList<int> getCurrentTime()
{
    time_t t = time(nullptr);
    tm* timePtr = localtime(&t);
    int year = timePtr->tm_year + 1900;
    int month = timePtr->tm_mon + 1;
    int day = timePtr->tm_mday;
    QList<int> dates;
    dates.append(year);
    dates.append(month);
    dates.append(day);
}
}
