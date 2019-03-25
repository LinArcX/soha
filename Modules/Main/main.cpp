#include "Util/Classes/util.h"
#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFont>
#include <QGuiApplication>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QTextStream>
#include <ctime>
#include <iostream>
#include <map>

#include "Modules/Main/presenter/myDate.h"
//#include <libcalendars/cl-julian.h>
//#include <libcalendars/cl-gregorian.h>
//#include <libcalendars/cl-solar-hijri.h>
//#include <libcalendars/cl-islamic-civil.h>

#include "Util/libs/libcalendars/cl-gregorian.h"
#include "Util/libs/libcalendars/cl-islamic-civil.h"
#include "Util/libs/libcalendars/cl-julian.h"
#include "Util/libs/libcalendars/cl-solar-hijri.h"

using namespace std;
using namespace linarcx;

QStringList trimmingArguments(QString month, QString day)
{
    if (month.startsWith("0")) {
        month = month.remove(QRegExp("^[0]*"));
    }
    if (day.startsWith("0")) {
        day = day.remove(QRegExp("^[0]*"));
    }
    QStringList list;
    list.append(day);
    list.append(month);
    return list;
}

void extractSolarEvents(QString day, QString month)
{
    QFile file(":/Events/PersianSolar.json");
    if (!file.exists())
        cout << "PersianSolar File Not Found!" << endl;
    file.open(QIODevice::ReadOnly);
    QByteArray rawData = file.readAll();
    QJsonDocument doc(QJsonDocument::fromJson(rawData));
    QJsonObject jObj = doc.object();

    QJsonValue selected = jObj[month];
    foreach (const QString& key, selected.toObject().keys()) {
        if (key == day) {
            QJsonValue value = selected.toObject().value(key);
            cout << "Solar Events: " << value.toString().toStdString() << endl;
        }
    }
}

void extractNationalEvents(QString day, QString month)
{
    QFile file(":/Events/PersianNational.json");
    if (!file.exists())
        cout << "PersianNational File Not Found!" << endl;
    file.open(QIODevice::ReadOnly);
    QByteArray rawData = file.readAll();
    QJsonDocument doc(QJsonDocument::fromJson(rawData));
    QJsonObject jObj = doc.object();

    QJsonValue selected = jObj[month];
    foreach (const QString& key, selected.toObject().keys()) {
        if (key == day) {
            QJsonValue value = selected.toObject().value(key);
            cout << "National Events: " << value.toString().toStdString() << endl;
        }
    }
}

void extractPersonageEvents(QString day, QString month)
{
    QFile file(":/Events/PersianPersonage.json");
    if (!file.exists())
        cout << "PersianPersonage File Not Found!" << endl;
    file.open(QIODevice::ReadOnly);
    QByteArray rawData = file.readAll();
    QJsonDocument doc(QJsonDocument::fromJson(rawData));
    QJsonObject jObj = doc.object();

    QJsonValue selected = jObj[month];
    foreach (const QString& key, selected.toObject().keys()) {
        if (key == day) {
            QJsonValue value = selected.toObject().value(key);
            cout << "Personage Events: " << value.toString().toStdString() << endl;
        }
    }
}

void extractWorldEvents(QString day, QString month)
{
    QFile file(":/Events/World.json");
    if (!file.exists())
        cout << "World File Not Found!" << endl;
    file.open(QIODevice::ReadOnly);
    QByteArray rawData = file.readAll();
    QJsonDocument doc(QJsonDocument::fromJson(rawData));
    QJsonObject jObj = doc.object();

    QJsonValue selected = jObj[month];
    foreach (const QString& key, selected.toObject().keys()) {
        if (key == day) {
            QJsonValue value = selected.toObject().value(key);
            cout << "World Events: " << value.toString().toStdString() << endl;
        }
    }
}

void extractLonarEvents(QString day, QString month)
{
    QFile file(":/Events/PersianLonar.json");
    if (!file.exists())
        cout << "PersianLonar File Not Found!" << endl;
    file.open(QIODevice::ReadOnly);
    QByteArray rawData = file.readAll();
    QJsonDocument doc(QJsonDocument::fromJson(rawData));
    QJsonArray jArray = doc.array();
    QJsonObject jObj = doc.object();

    QJsonValue selected = jObj[month];
    foreach (const QString& key, selected.toObject().keys()) {
        if (key == day) {
            QJsonValue value = selected.toObject().value(key);
            cout << "PersianLonar Events: " << value.toString().toStdString() << endl;
        }
    }
}

void generatePersianLonarEvents(QJsonArray& rootArray, QString year)
{
    QByteArray rawData = readFile_ByteArray(":/Events/PersianLonar.json");
    QJsonDocument jDoc(QJsonDocument::fromJson(rawData));
    QJsonObject jObject = jDoc.object();

    uint32_t jdn = 0;
    int16_t hyear = static_cast<int16_t>(year.toInt());
    uint8_t hmonth;
    uint16_t hday;
    sh_to_jdn(&jdn, hyear, hmonth, hday);

    int16_t jiy;
    uint8_t jim;
    uint16_t jid;
    jdn_to_is(jdn, &jiy, &jim, &jid);

    for (auto iter = jObject.begin(); iter != jObject.end(); ++iter) {
        QString Date = "";
        QString Title = "";
        bool isHoliday;
        QString jKey = iter.key();
        QJsonValue jValue = iter.value();
        QJsonArray jValueArray = jValue.toArray();

        foreach (const QJsonValue& val, jValueArray) {
            QString eventKey = val.toObject().keys().at(0);
            QString isHolidayKey = val.toObject().keys().at(1);

            uint32_t jdn = 0;
            uint8_t hjmonth = static_cast<uint8_t>(jKey.toInt());
            uint16_t hjday = static_cast<uint16_t>(eventKey.toUInt());
            is_to_jdn(&jdn, jiy, hjmonth, hjday);

            int16_t jsy;
            uint8_t jsm;
            uint16_t jsd;
            jdn_to_sh(jdn, &jsy, &jsm, &jsd);
            if (jsy != year) {
                jsy = year.toInt();
            }
            Date = QString::number(jsy) + "/" + QString::number(jsm) + "/" + QString::number(jsd);
            Title = val.toObject().value(eventKey).toString().toUtf8();
            isHoliday = val.toObject().value(isHolidayKey).toBool();

            QJsonObject mObject;
            mObject.insert("Date", QJsonValue::fromVariant(Date));
            mObject.insert("Title", QJsonValue::fromVariant(Title));
            mObject.insert("IsHoliday", QJsonValue::fromVariant(isHoliday));
            mObject.insert("Temp", QJsonValue::fromVariant(jsd + jsm * 31));

            rootArray.push_back(mObject);
        }
    }
}

void generatePersianSolarEvents(QJsonArray& rootArray, QString year)
{
    QByteArray rawData = readFile_ByteArray(":/Events/PersianSolar.json");
    QJsonDocument jDoc(QJsonDocument::fromJson(rawData));
    QJsonObject jObject = jDoc.object();

    int16_t syear = static_cast<int16_t>(year.toUInt());

    for (auto iter = jObject.begin(); iter != jObject.end(); ++iter) {
        QString Date = "";
        QString Title = "";
        bool isHoliday;
        QString jKey = iter.key();
        QJsonValue jValue = iter.value();
        QJsonArray jValueArray = jValue.toArray();

        foreach (const QJsonValue& val, jValueArray) {
            QString eventKey = val.toObject().keys().at(0);
            QString isHolidayKey = val.toObject().keys().at(1);

            int month = jKey.toInt();
            int day = eventKey.toUInt();
            Date = QString::number(syear) + "/" + QString::number(month) + "/" + QString::number(day);
            Title = val.toObject().value(eventKey).toString().toUtf8();
            isHoliday = val.toObject().value(isHolidayKey).toBool();

            QJsonObject mObject;
            mObject.insert("Date", QJsonValue::fromVariant(Date));
            mObject.insert("Title", QJsonValue::fromVariant(Title));
            mObject.insert("IsHoliday", QJsonValue::fromVariant(isHoliday));
            mObject.insert("Temp", QJsonValue::fromVariant(day + month * 31));

            rootArray.push_back(mObject);
        }
    }
}

void generatePersianNationalEvents(QJsonArray& rootArray, QString year)
{
    QByteArray rawData = readFile_ByteArray(":/Events/PersianNational.json");
    QJsonDocument jDoc(QJsonDocument::fromJson(rawData));
    QJsonObject jObject = jDoc.object();

    int16_t syear = static_cast<int16_t>(year.toUInt());

    for (auto iter = jObject.begin(); iter != jObject.end(); ++iter) {
        QString Date = "";
        QString Title = "";
        bool isHoliday;
        QString jKey = iter.key();
        QJsonValue jValue = iter.value();
        QJsonArray jValueArray = jValue.toArray();

        foreach (const QJsonValue& val, jValueArray) {
            QString eventKey = val.toObject().keys().at(0);
            QString isHolidayKey = val.toObject().keys().at(1);

            int month = jKey.toInt();
            int day = eventKey.toUInt();
            Date = QString::number(syear) + "/" + QString::number(month) + "/" + QString::number(day);
            Title = val.toObject().value(eventKey).toString().toUtf8();
            isHoliday = val.toObject().value(isHolidayKey).toBool();

            QJsonObject mObject;
            mObject.insert("Date", QJsonValue::fromVariant(Date));
            mObject.insert("Title", QJsonValue::fromVariant(Title));
            mObject.insert("IsHoliday", QJsonValue::fromVariant(isHoliday));
            mObject.insert("Temp", QJsonValue::fromVariant(day + month * 31));

            rootArray.push_back(mObject);
        }
    }
}

void generatePersianPersonageEvents(QJsonArray& rootArray, QString year)
{
    QByteArray rawData = readFile_ByteArray(":/Events/PersianPersonage.json");
    QJsonDocument jDoc(QJsonDocument::fromJson(rawData));
    QJsonObject jObject = jDoc.object();

    int16_t syear = static_cast<int16_t>(year.toUInt());

    for (auto iter = jObject.begin(); iter != jObject.end(); ++iter) {
        QString Date = "";
        QString Title = "";
        bool isHoliday;
        QString jKey = iter.key();
        QJsonValue jValue = iter.value();
        QJsonArray jValueArray = jValue.toArray();

        foreach (const QJsonValue& val, jValueArray) {
            QString eventKey = val.toObject().keys().at(0);
            QString isHolidayKey = val.toObject().keys().at(1);

            int month = jKey.toInt();
            int day = eventKey.toUInt();
            Date = QString::number(syear) + "/" + QString::number(month) + "/" + QString::number(day);
            Title = val.toObject().value(eventKey).toString().toUtf8();
            isHoliday = val.toObject().value(isHolidayKey).toBool();

            QJsonObject mObject;
            mObject.insert("Date", QJsonValue::fromVariant(Date));
            mObject.insert("Title", QJsonValue::fromVariant(Title));
            mObject.insert("IsHoliday", QJsonValue::fromVariant(isHoliday));
            mObject.insert("Temp", QJsonValue::fromVariant(day + month * 31));

            rootArray.push_back(mObject);
        }
    }
}

void generateWorldEvents(QJsonArray& rootArray, QString year)
{
    QByteArray rawData = readFile_ByteArray(":/Events/World.json");
    QJsonDocument jDoc(QJsonDocument::fromJson(rawData));
    QJsonObject jObject = jDoc.object();

    int16_t syear = static_cast<int16_t>(year.toUInt());
    int16_t gsy;
    uint8_t gsm;
    uint16_t gsd;

    for (auto iter = jObject.begin(); iter != jObject.end(); ++iter) {
        QString Date = "";
        QString Title = "";
        bool isHoliday;
        QString jKey = iter.key();
        QJsonValue jValue = iter.value();
        QJsonArray jValueArray = jValue.toArray();

        foreach (const QJsonValue& val, jValueArray) {
            QString eventKey = val.toObject().keys().at(0);
            QString isHolidayKey = val.toObject().keys().at(1);

            uint8_t hjmonth = static_cast<uint8_t>(jKey.toInt());
            uint16_t hjday = static_cast<uint16_t>(eventKey.toUInt());
            gr_to_sh(syear, hjmonth, hjday, &gsy, &gsm, &gsd);

            Date = QString::number(syear) + "/" + QString::number(gsm) + "/" + QString::number(gsd);
            Title = val.toObject().value(eventKey).toString().toUtf8();
            isHoliday = val.toObject().value(isHolidayKey).toBool();

            QJsonObject mObject;
            mObject.insert("Date", QJsonValue::fromVariant(Date));
            mObject.insert("Title", QJsonValue::fromVariant(Title));
            mObject.insert("IsHoliday", QJsonValue::fromVariant(isHoliday));
            mObject.insert("Temp", QJsonValue::fromVariant(gsd + gsm * 31));

            rootArray.push_back(mObject);
        }
    }
}

bool operator<(const QMap<QString, QVariant>& m1, const QMap<QString, QVariant>& m2)
{
    auto it1 = m1.find("Temp");
    auto it2 = m2.find("Temp");
    if (it1.value() < it2.value()) {
        return true;
    } else {
        return false;
    }
}

QJsonArray sortJsonDoc(QJsonArray rootArray)
{
    // QJsonArray To QList<QMap<,>>
    QVariantList mList = rootArray.toVariantList();
    QVector<QVariant> mVector = mList.toVector();
    QList<QVariant> listOfVariants = QList<QVariant>::fromVector(mVector);
    QList<QMap<QString, QVariant>> listOfMaps;
    foreach (QVariant qv, listOfVariants) {
        QMap<QString, QVariant> mQmap = qv.toMap();
        listOfMaps.append(mQmap);
    }

    // Sort
    qSort(listOfMaps);

    // QList<QMap<,>> To QJsonArray
    QJsonArray outputArray;
    int id = 1;
    foreach (auto item, listOfMaps) {
        QVariantMap qvMap;
        foreach (auto i, item.keys()) {
            qvMap.insert(i, item.value(i));
        }
        QJsonObject obj = QJsonObject::fromVariantMap(qvMap);
        obj.remove("Temp");
        obj.insert("ID", QJsonValue::fromVariant(id));
        outputArray.push_back(obj);
        id++;
    }
    return outputArray;
}

void extractAllEvents(QString mPath, QString year)
{
    // init
    QJsonArray rootArray;

    // Create Output File
    QString pAllEvents = createFile(mPath, "/Events", "/AllEvents.json");

    // Generate Events
    generatePersianSolarEvents(rootArray, year);
    generatePersianNationalEvents(rootArray, year);
    generatePersianPersonageEvents(rootArray, year);
    generatePersianLonarEvents(rootArray, year);
    generateWorldEvents(rootArray, year);

    QJsonArray outputArray = sortJsonDoc(rootArray);
    QJsonDocument outDoc(outputArray);
    writeToFile(outDoc.toJson(), pAllEvents);
}

list<int> getLonarDates(int year, int month, int day)
{
    uint32_t jdn = 0;
    sh_to_jdn(&jdn, year, month, day);

    int16_t jiy;
    uint8_t jim;
    uint16_t jid;
    jdn_to_is(jdn, &jiy, &jim, &jid);

    list<int> lDates;
    lDates.push_back(jid);
    lDates.push_back(jim);
    lDates.push_back(jiy);
    return lDates;
}

void showLonarDate(list<int> lDate)
{
    string hDate = std::to_string(*(next(lDate.begin(), 0))) + "/" + std::to_string(*(next(lDate.begin(), 1))) + "/" + std::to_string(*(next(lDate.begin(), 2)));
    cout << "Hijri Date: " + hDate << endl;
}

list<int> getWorldDates(int year, int month, int day)
{
    int16_t sgy;
    uint8_t sgm;
    uint16_t sgd;
    sh_to_gr(year, month, day, &sgy, &sgm, &sgd);

    list<int> gDates;
    gDates.push_back(sgd);
    gDates.push_back(sgm);
    gDates.push_back(sgy);
    return gDates;
}

void showGregorianDate(list<int> gDate)
{
    string hDate = std::to_string(*(next(gDate.begin(), 0))) + "/" + std::to_string(*(next(gDate.begin(), 1))) + "/" + std::to_string(*(next(gDate.begin(), 2)));
    cout << "Gregorain Date: " + hDate << endl;
}

int main(int argc, char* argv[])
{
    if (argc == 2) {
        QCoreApplication app(argc, argv);

        QString date = argv[1];
        QStringList dateList = date.split("/");
        QString year = dateList[0];
        if (dateList.length() == 1) {
            QString mPath = app.applicationDirPath(); //QDir::current().absolutePath();
            extractAllEvents(mPath, dateList[0]);
            //            QString fWorld = Util::readFile(":/Events/World.json");
            //            QString pWorld = createFile(mPath, "/Events", "/World.json");
            //            writeToFile(fWorld, pWorld);
            cout << "Events Saved in: " + mPath.toStdString() + "/Events Directory." << endl;
        } else {
            QString month = dateList[1];
            QString day = dateList[2];
            QStringList trimmedList = trimmingArguments(month, day);
            QString mDay = trimmedList[0];
            QString mMonth = trimmedList[1];

            list<int> wDates = getWorldDates(year.toInt(), month.toInt(), day.toInt());
            showGregorianDate(wDates);
            list<int> lDates = getLonarDates(year.toInt(), month.toInt(), day.toInt());
            showLonarDate(lDates);

            extractSolarEvents(mDay, mMonth);
            extractNationalEvents(mDay, mMonth);
            extractPersonageEvents(mDay, mMonth);

            extractWorldEvents(QString::number(*(next(wDates.begin(), 0))), QString::number(*(next(wDates.begin(), 1))));
            extractLonarEvents(QString::number(*(next(lDates.begin(), 0))), QString::number(*(next(lDates.begin(), 1))));

            return 1;
        }

    } else {
    }

    QGuiApplication app(argc, argv);
    qmlRegisterType<MyDate>("linarcx.taghvim.MyDate", 1, 0, "MyDate");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
    return 0;
}
