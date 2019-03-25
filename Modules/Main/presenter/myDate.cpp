#include "Modules/Main/presenter/myDate.h"
#include <QString>
#include <QStringList>
#include <QVariantList>

//#include <libcalendars/cl-julian.h>
//#include <libcalendars/cl-gregorian.h>
//#include <libcalendars/cl-solar-hijri.h>
//#include <libcalendars/cl-islamic-civil.h>

#include "Util/libs/libcalendars/cl-julian.h"
#include "Util/libs/libcalendars/cl-gregorian.h"
#include "Util/libs/libcalendars/cl-solar-hijri.h"
#include "Util/libs/libcalendars/cl-islamic-civil.h"

using namespace std;

MyDate::MyDate(QObject* parent)
{
}

QVariantList MyDate::shamsiToGregorain(QVariant year, QVariant month, QVariant day)
{
    int16_t sgy;
    uint8_t sgm;
    uint16_t sgd;

    int16_t sgyear = year.toInt();
    uint8_t sgmonth = month.toUInt();
    uint16_t sgday = day.toUInt();

    sh_to_gr(sgyear, sgmonth, sgday, &sgy, &sgm, &sgd);

    QVariantList dateList;
    dateList.append(sgy);
    dateList.append(sgm);
    dateList.append(sgd);
    return dateList;
    // string sgDate = std::to_string(sgy) + "/" + std::to_string(sgm) + "/" + std::to_string(sgd);
    // QVariant qv(QString::fromStdString(sgDate));
    // emit singleModelReady(qv);
}

QVariantList MyDate::shamsiToHijri(QVariant year, QVariant month, QVariant day)
{
    uint32_t jdn = 0;
    int16_t hyear = year.toInt();
    uint8_t hmonth = month.toUInt();
    uint16_t hday = day.toUInt();

    sh_to_jdn(&jdn, hyear, hmonth, hday);

    int16_t jiy;
    uint8_t jim;
    uint16_t jid;
    jdn_to_is(jdn, &jiy, &jim, &jid);

    QVariantList dateList;
    dateList.append(jiy);
    dateList.append(jim);
    dateList.append(jid);
    return dateList;
}

QVariantList MyDate::gregorainToShamsi(QVariant year, QVariant month, QVariant day){
    int16_t gsy;
    uint8_t gsm;
    uint16_t gsd;

    int16_t gsyear = year.toInt();
    uint8_t gsmonth = month.toUInt();
    uint16_t gsday = day.toUInt();

    gr_to_sh(gsyear, gsmonth, gsday, &gsy, &gsm, &gsd);

    QVariantList dateList;
    dateList.append(gsy);
    dateList.append(gsm);
    dateList.append(gsd);
    return dateList;
}

QVariantList MyDate::gregorianToHijri(QVariant year, QVariant month, QVariant day){
    int16_t giy;
    uint8_t gim;
    uint16_t gid;

    int16_t giyear = year.toInt();
    uint8_t gimonth = month.toUInt();
    uint16_t giday = day.toUInt();

    gr_to_is(giyear, gimonth, giday, &giy, &gim, &gid);

    QVariantList dateList;
    dateList.append(giy);
    dateList.append(gim);
    dateList.append(gid);
    return dateList;
}

QVariantList MyDate::hijriToShamsi(QVariant year, QVariant month, QVariant day){
    uint32_t jdn = 0;
    int16_t hjyear = year.toInt();
    uint8_t hjmonth = month.toUInt();
    uint16_t hjday = day.toUInt();

    is_to_jdn(&jdn, hjyear, hjmonth, hjday);

    int16_t jsy;
    uint8_t jsm;
    uint16_t jsd;
    jdn_to_sh(jdn, &jsy, &jsm, &jsd);

    QVariantList dateList;
    dateList.append(jsy);
    dateList.append(jsm);
    dateList.append(jsd);
    return dateList;
}

QVariantList MyDate::hijriToGregorian(QVariant year, QVariant month, QVariant day){
    int16_t igy;
    uint8_t igm;
    uint16_t igd;

    int16_t igyear = year.toInt();
    uint8_t igmonth = month.toUInt();
    uint16_t igday = day.toUInt();

    is_to_gr(igyear, igmonth, igday, &igy, &igm, &igd);

    QVariantList dateList;
    dateList.append(igy);
    dateList.append(igm);
    dateList.append(igd);
    return dateList;
}
