import QtQuick 2.9
import QtQuick.Controls 1.4
import linarcx.taghvim.MyDate 1.0

Calendar {
    id: mJalaliCalendar
    locale: Qt.locale("fa-FA")

    style: JalaliCalendarStyle {
        id: jalaliStyle
    }

    MyDate {
        id: mDate
    }

    FontLoader {
        id: mFont
        source: "qrc:/Fonts/Vazir-FD.ttf"
    }
    property bool isPersianMode: true

    property string persianSelectedDate
    property string persianGregorianSelectedDate
    property string persianHijriSelectedDate
    onPersianSelectedDateChanged: lblJalali = persianSelectedDate
    onPersianGregorianSelectedDateChanged: lblGregorian = persianGregorianSelectedDate
    onPersianHijriSelectedDateChanged: lblHijri = persianHijriSelectedDate

    property bool mGridVisible: true
    property bool mTitleIsBold: false
    property bool mTitleIsItalic: false
    property bool mTitleIsUnderLine: true
    onMGridVisibleChanged: JalaliCalendarStyle.gridVisible = mGridVisible
    onMTitleIsBoldChanged: JalaliCalendarStyle.isBold = mTitleIsBold
    onMTitleIsItalicChanged: JalaliCalendarStyle.isItalic = mTitleIsItalic
    onMTitleIsUnderLineChanged: JalaliCalendarStyle.isUnderline = mTitleIsUnderLine

    property string mDaysColor
    property string mWeekDayColor
    property string mHolidaysColor
    property string mDasyFontSize
    onMDaysColorChanged: JalaliCalendarStyle.daysColor = mDaysColor
    onMWeekDayColorChanged: JalaliCalendarStyle.weekDaysColor = mWeekDayColor
    onMHolidaysColorChanged: JalaliCalendarStyle.holidaysColor = mHolidaysColor
    onMDasyFontSizeChanged: JalaliCalendarStyle.daysFontSize = mDasyFontSize

    property string worldEvent
    property string persianSolarEvent
    property string persianLonarEvent
    property string persianNationalEvent
    property string persianPersonageEvent
    onWorldEventChanged: lblWorldEvent = worldEvent
    onPersianSolarEventChanged: lblPersianSolarEvent = persianSolarEvent
    onPersianLonarEventChanged: lblPersianLonarEvent = persianLonarEvent
    onPersianNationalEventChanged: lblPersianNationalEvent = persianNationalEvent
    onPersianPersonageEventChanged: lblPersianPersonageEvent = persianPersonageEvent


    property bool persianSolarIsHoliday: false
    property bool persianLonarIsHoliday: false
    onPersianSolarIsHolidayChanged: {
        if (persianSolarIsHoliday) {
            psEvent.color = "Red"
        } else {
            psEvent.color = "Black"
        }
    }
    onPersianLonarIsHolidayChanged: {
        if (persianLonarIsHoliday) {
            plEvent.color = "Red"
        } else {
            plEvent.color = "Black"
        }
    }

    function shamsiMonthName(i) {
        switch (i) {
        case 1:
            return "فروردین"
        case 2:
            return "اردیبهشت"
        case 3:
            return "خرداد"
        case 4:
            return "تیر"
        case 5:
            return "مرداد"
        case 6:
            return "شهریور"
        case 7:
            return "مهر"
        case 8:
            return "آبان"
        case 9:
            return "آذر"
        case 10:
            return "دی"
        case 11:
            return "بهمن"
        case 12:
            return "اسفند"
        }
    }

    function hijriMonthName(i) {
        switch (i) {
        case 1:
            return "محرّم"
        case 2:
            return "صفر"
        case 3:
            return "ربیع الاوّل"
        case 4:
            return "ربیع الثانی"
        case 5:
            return "جمادی الاول"
        case 6:
            return "جمادی الثانی"
        case 7:
            return "رجب"
        case 8:
            return "شعبان"
        case 9:
            return "رمضان"
        case 10:
            return "شوّال"
        case 11:
            return "ذی القعده"
        case 12:
            return "ذی الحجّه"
        }
    }

    function gregorianMonthName(i) {
        switch (i) {
        case 1:
            return "ژانویه"
        case 2:
            return "فوریه"
        case 3:
            return "مارس"
        case 4:
            return "آوریل"
        case 5:
            return "مِی"
        case 6:
            return "ژوئن"
        case 7:
            return "جولای"
        case 8:
            return "آگوست"
        case 9:
            return "سپتامبر"
        case 10:
            return "اکتبر"
        case 11:
            return "نوامبر"
        case 12:
            return "دسامبر"
        }
    }

    function dayName(i, mode) {
        switch (i) {
        case 0:
            return "یکشنبه"
        case 1:
            return "دوشنبه"
        case 2:
            return "سه‌شنبه"
        case 3:
            return "چهار‌شنبه"
        case 4:
            return "پنج‌شنبه"
        case 5:
            return "جمعه"
        case 6:
            return "شنبه"
        }
    }
    function getCurrentDate(){
        var currentDate = Qt.formatDateTime(new Date(), "yyyy/MM/dd")
        var year = parseInt(currentDate.split("/")[0])
        var month = parseInt(currentDate.split("/")[1])
        var day = parseInt(currentDate.split("/")[2])
        return [year, month, day]
    }

    function dayNumber(jy, jm, jd) {
        var gr = mDate.shamsiToGregorain(jy, jm, jd)
        return Date.fromLocaleString(Qt.locale(),
                                     gr[0] + "-" + gr[1] + "-" + gr[2],
                                     "yyyy-M-d").getDay() * 1 + 1
    }
    function dayInMonth(year, month) {
        month = month - 1
        if (month < 0)
            return -1
        if (month < 6)
            return 31
        if (month < 11)
            return 30

        var ary = [1, 5, 9, 13, 17, 22, 26, 30]
        var b = year % 33
        for (var i = 0; i < ary.length; i++)
            if (b === ary[i])
                return 30
        return 29
    }
}
