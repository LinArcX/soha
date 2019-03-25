import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.3
import linarcx.taghvim.MyDate 1.0

import "qrc:/Util"
import "qrc:/Jalali/"
import "qrc:/strings/MainStrings.js" as CStr

Window {
    id: mainWindow
    title: qsTr(CStr.appTitle)
    visible: true
    minimumWidth: Screen.width / 3 * 2
    minimumHeight: Screen.height / 3 * 2
    maximumWidth: Screen.width
    maximumHeight: Screen.height
    color: CStr.appColor

    signal localeChanged(int localeIndex)
    signal gridVisibleChanged(bool isVisible)
    signal dateSelected(string mLocale)

    property string lblPersianSolarEvent
    property string lblPersianNationalEvent
    property string lblPersianPersonageEvent
    property string lblWorldEvent
    property string lblPersianLonarEvent
    property string lblJalali
    property string lblGregorian
    property string lblHijri

    property variant shamsiToGregorain: ({

                                         })
    property variant shamsiToHijri: ({

                                     })

    property variant hijriToShamsi: ({

                                     })
    property variant hijriToGregorian: ({

                                        })
    property variant gregorianToShamsi: ({

                                         })
    property variant gregorianToHijri: ({

                                        })

    FontLoader {
        id: fntVazirDF
        source: "qrc:/Fonts/Vazir-FD.ttf"
    }

    FontLoader {
        id: fntXMYekan
        source: "qrc:/Fonts/XMYekan.ttf"
    }

    MyDate {
        id: mDate
    }

    Grid {
        id: mGrid
        width: parent.width
        height: parent.height
        columns: 2
        columnSpacing: 5
        rowSpacing: 5
        padding: 5

        GroupBox {
            id: gbTaghvim
            title: "تقویم"
            font: fntXMYekan.name
            width: (parent.width / 2)
            height: (parent.height / 3) * 2

            JalaliCalendar {
                id: mCalendar
                anchors.fill: parent
            }
        }

        GroupBox {
            id: gbSettings
            title: "تنظیمات"
            font: fntXMYekan.name
            width: (parent.width / 2) - 15
            height: (parent.height / 3) * 2

            Column {
                anchors.fill: parent
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true
                spacing: 20

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor
                    visible: false

                    Label {
                        id: lblLocale
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "زبان تقویم:"
                    }
                    ComboBox {
                        id: cbLocale
                        width: parent.width - lblLocale.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["پارسی", "انگلیسی", "عربی"]
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#fcfcfc"
                            border.color: "#999797"
                            border.width: 2
                            radius: 4
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex == 0) {
                                mCalendar.locale = Qt.locale("fa-FA")
                            } else if (currentIndex == 1) {
                                mCalendar.locale = Qt.locale("en-EN")
                            } else if (currentIndex == 2) {
                                mCalendar.locale = Qt.locale("ar-AR")
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblIsGridVisible
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "نمایش شبکه بندی:"
                    }
                    Row {
                        id: cbIsGridVisible
                        width: parent.width - lblIsGridVisible.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        //spacing: 20
                        RadioButton {
                            text: "بله"
                            checked: true
                            onCheckedChanged: mCalendar.mGridVisible = true
                        }
                        RadioButton {
                            text: "خیر"
                            onCheckedChanged: mCalendar.mGridVisible = false
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblIsUnderLine
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "نمایش عناوین هفته بصورت:"
                    }

                    Row {
                        spacing: 5
                        CheckBox {
                            text: "خمیده"
                            onCheckedChanged: {
                                if (checked) {
                                    mCalendar.mTitleIsItalic = true
                                } else {
                                    mCalendar.mTitleIsItalic = false
                                }
                            }
                        }
                        CheckBox {
                            text: "زیرخط‌دار"
                            checked: true
                            onCheckedChanged: {
                                if (checked) {
                                    mCalendar.mTitleIsUnderLine = true
                                } else {
                                    mCalendar.mTitleIsUnderLine = false
                                }
                            }
                        }
                        CheckBox {
                            text: "توپُر"
                            onCheckedChanged: {
                                if (checked) {
                                    mCalendar.mTitleIsBold = true
                                } else {
                                    mCalendar.mTitleIsBold = false
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblWeekDayColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "عناوین هفته:"
                    }
                    ComboBox {
                        id: cbWeekDayColor
                        width: parent.width - lblWeekDayColor.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["مشکی", "آبی", "قرمز", "سبز"]
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#fcfcfc"
                            border.color: "#999797"
                            border.width: 2
                            radius: 4
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex == 0) {
                                mCalendar.mWeekDayColor = "Black"
                            } else if (currentIndex == 1) {
                                mCalendar.mWeekDayColor = "Blue"
                            } else if (currentIndex == 2) {
                                mCalendar.mWeekDayColor = "Red"
                            } else if (currentIndex == 3) {
                                mCalendar.mWeekDayColor = "Green"
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblDaysColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "روزهای هفته:"
                    }
                    ComboBox {
                        id: cbDaysColor
                        width: parent.width - lblDaysColor.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["مشکی", "آبی", "قرمز", "سبز"]
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#fcfcfc"
                            border.color: "#999797"
                            border.width: 2
                            radius: 4
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex == 0) {
                                mCalendar.mDaysColor = "Black"
                            } else if (currentIndex == 1) {
                                mCalendar.mDaysColor = "Blue"
                            } else if (currentIndex == 2) {
                                mCalendar.mDaysColor = "Red"
                            } else if (currentIndex == 3) {
                                mCalendar.mDaysColor = "Green"
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblHolidaysColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "روزهای تعطیل:"
                    }
                    ComboBox {
                        id: cbHolidaysColor
                        width: parent.width - lblHolidaysColor.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["قرمز", "آبی", "نارنجی", "سبز"]
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#fcfcfc"
                            border.color: "#999797"
                            border.width: 2
                            radius: 4
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex == 0) {
                                mCalendar.mHolidaysColor = "Red"
                            } else if (currentIndex == 1) {
                                mCalendar.mHolidaysColor = "Blue"
                            } else if (currentIndex == 2) {
                                mCalendar.mHolidaysColor = "Orange"
                            } else if (currentIndex == 3) {
                                mCalendar.mHolidaysColor = "Green"
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height / 10 * 1
                    color: CStr.appColor

                    Label {
                        id: lblDaysFontSize
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: "اندازه فونت:"
                    }
                    ComboBox {
                        id: cbDaysFontSize
                        width: parent.width - lblWeekDayColor.width
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["معمولی", "بزرگ", "کوچک"]
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#fcfcfc"
                            border.color: "#999797"
                            border.width: 2
                            radius: 4
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex == 0) {
                                mCalendar.mDasyFontSize = "normal"
                            } else if (currentIndex == 1) {
                                mCalendar.mDasyFontSize = "big"
                            } else if (currentIndex == 2) {
                                mCalendar.mDasyFontSize = "small"
                            }
                        }
                    }
                }
            }
        }

        GroupBox {
            title: "مناسبات"
            width: (parent.width / 2)
            height: parent.height - gbTaghvim.height - 15
            font: fntXMYekan.name

            Rectangle {
                id: rSolar
                width: (parent.width / 2 * 1)
                height: parent.height / 5
                anchors.right: parent.right
                anchors.top: parent.top
                color: CStr.appColor
                Image {
                    id: imgSolar
                    source: CStr.imgHoliday
                    sourceSize.height: parent.height - 5
                    sourceSize.width: parent.height - 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: psEvent
                    text: lblPersianSolarEvent
                    anchors.right: imgSolar.left
                    anchors.verticalCenter: imgSolar.verticalCenter
                    anchors.rightMargin: 5
                }
            }

            Rectangle {
                id: rNational
                width: (parent.width / 2 * 1)
                height: parent.height / 5
                anchors.right: parent.right
                anchors.top: rSolar.bottom
                color: CStr.appColor

                Image {
                    id: imgNational
                    source: CStr.imgNational
                    sourceSize.height: parent.height - 5
                    sourceSize.width: parent.height - 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: pnEvent
                    text: lblPersianNationalEvent
                    anchors.right: imgNational.left
                    anchors.verticalCenter: imgNational.verticalCenter
                    anchors.rightMargin: 5
                }
            }

            Rectangle {
                id: rPersonage
                width: (parent.width / 2 * 1)
                height: parent.height / 5
                anchors.right: parent.right
                anchors.top: rNational.bottom
                color: CStr.appColor

                Image {
                    id: imgPersonage
                    source: CStr.imgPersonage
                    sourceSize.height: parent.height - 5
                    sourceSize.width: parent.height - 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: ppEvent
                    text: lblPersianPersonageEvent
                    anchors.right: imgPersonage.left
                    anchors.verticalCenter: imgPersonage.verticalCenter
                    anchors.rightMargin: 5
                }
            }

            Rectangle {
                id: rWorld
                width: (parent.width / 2 * 1)
                height: parent.height / 5
                anchors.right: parent.right
                anchors.top: rPersonage.bottom
                color: CStr.appColor

                Image {
                    id: imgWorld
                    source: CStr.imgWorld
                    sourceSize.height: parent.height - 5
                    sourceSize.width: parent.height - 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: wEvent
                    text: lblWorldEvent
                    anchors.right: imgWorld.left
                    anchors.verticalCenter: imgWorld.verticalCenter
                    anchors.rightMargin: 5
                }
            }

            Rectangle {
                id: rLonar
                width: (parent.width / 2 * 1)
                height: parent.height / 5
                anchors.right: parent.right
                anchors.top: rWorld.bottom
                color: CStr.appColor

                Image {
                    id: imgLonar
                    source: CStr.imgLonar
                    sourceSize.height: parent.height - 5
                    sourceSize.width: parent.height - 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: plEvent
                    text: lblPersianLonarEvent
                    anchors.right: imgLonar.left
                    anchors.verticalCenter: imgLonar.verticalCenter
                    anchors.rightMargin: 5
                }
            }

            Rectangle {
                id: rdPersian
                width: (parent.width / 2 * 1)
                height: parent.height / 3
                anchors.left: parent.left
                anchors.top: parent.top
                color: CStr.appColor

                LinArcxPopUp{
                    id : persianPopUp
                    puTitle: CStr.jalaliTitle
                    puImage: CStr.imgIran
                    puDesc: CStr.jalaliDesc
                    puParent: mainWindow
                    puX: mainWindow.width / 2 - rdPersian.width
                    puY: -mainWindow.height / 2 - rdPersian.height
                    puFontFamily: fntXMYekan.name
                }

                Image {
                    id: imgPersianDate
                    source: CStr.imgIran
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: ctmJalali.popup()
                        Menu {
                            id: ctmJalali
                            Action{
                                text: "What's This?"
                                onTriggered: persianPopUp.open()
                                icon{
                                    source: CStr.imgWhatsThis; width: 20; height: 20
                                }
                            }
                        }
                    }
                }

                Label {
                    text: lblJalali
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgPersianDate.right
                    anchors.verticalCenter: imgPersianDate.verticalCenter
                    anchors.leftMargin: 5
                }
            }

            Rectangle {
                id: rdGregorian
                width: (parent.width / 2 * 1)
                height: parent.height / 3
                anchors.top: rdPersian.bottom
                anchors.left: parent.left
                color: CStr.appColor

                LinArcxPopUp{
                    id : gregorianPopUp
                    puTitle: CStr.gregorianTitle
                    puDesc: CStr.gregorianDesc
                    puImage: CStr.imgUsa
                    puParent: mainWindow
                    puX: mainWindow.width / 2 - rdGregorian.width
                    puY: -mainWindow.height / 2 - rdGregorian.height
                    puFontFamily: fntXMYekan.name
                }

                Image {
                    id: imgGregorianDate
                    source: CStr.imgUsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: ctmGregorian.popup()
                        Menu {
                            id: ctmGregorian
                            Action{
                                text: "What's This?"
                                onTriggered: gregorianPopUp.open()
                                icon{
                                    source: CStr.imgWhatsThis; width: 20; height: 20
                                }
                            }
                        }
                    }
                }

                Label {
                    text: lblGregorian
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgGregorianDate.right
                    anchors.verticalCenter: imgGregorianDate.verticalCenter
                    anchors.leftMargin: 5
                }
            }

            Rectangle {
                id: rdHijri
                width: (parent.width / 2 * 1)
                height: parent.height / 3
                anchors.top: rdGregorian.bottom
                anchors.left: parent.left
                color: CStr.appColor

                LinArcxPopUp{
                    id : hijriPopUp
                    puTitle: CStr.hijriTitle
                    puDesc: CStr.hijriDesc
                    puImage: CStr.imgKsa
                    puParent: mainWindow
                    puX: mainWindow.width / 2 - rdHijri.width
                    puY: -mainWindow.height / 2 - rdHijri.height
                    puFontFamily: fntXMYekan.name
                }

                Image {
                    id: imgHijriDate
                    source: CStr.imgKsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: ctmHijri.popup()
                        Menu {
                            id: ctmHijri
                            Action{
                                text: "What's This?"
                                onTriggered: hijriPopUp.open()
                                icon{
                                    source: CStr.imgWhatsThis; width: 20; height: 20
                                }
                            }
                        }
                    }
                }

                Label {
                    text: lblHijri
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgHijriDate.right
                    anchors.verticalCenter: imgHijriDate.verticalCenter
                    anchors.leftMargin: 5
                }
            }
        }

        GroupBox {
            title: "تبدیلات"
            font: fntXMYekan.name
            width: (parent.width / 2) - 15
            height: parent.height - gbSettings.height - 15

            Rectangle {
                id: cvrtButtons
                width: parent.width
                height: parent.height / 3
                color: "transparent"

                Button {
                    id: btnFromHijri
                    text: "از قمری"
                    width: parent.width / 3 - 5
                    anchors.left: parent.left
                    checkable: true
                    autoExclusive: true
                    onCheckedChanged: {
                        rctFromHijri.visible = true
                        rctFromGregorian.visible = false
                        rctFromJalali.visible = false
                    }
                    font.family: fntXMYekan.name
                }

                Button {
                    id: btnFromGregorian
                    text: "از میلادی"
                    width: parent.width / 3 - 5
                    anchors.left: btnFromHijri.right
                    anchors.leftMargin: 5
                    checkable: true
                    autoExclusive: true
                    onCheckedChanged: {
                        rctFromGregorian.visible = true
                        rctFromJalali.visible = false
                        rctFromHijri.visible = false
                    }
                    font.family: fntXMYekan.name
                }

                Button {
                    id: btnFromJalali
                    text: "از شمسی"
                    width: parent.width / 3 - 5
                    anchors.left: btnFromGregorian.right
                    anchors.leftMargin: 5
                    checkable: true
                    autoExclusive: true
                    checked: true
                    onCheckedChanged: {
                        rctFromJalali.visible = true
                        rctFromGregorian.visible = false
                        rctFromHijri.visible = false
                    }
                    font.family: fntXMYekan.name
                }
            }
            Rectangle {
                id: rctYMD
                width: parent.width
                height: parent.height / 3
                anchors.top: cvrtButtons.bottom
                anchors.left: cvrtButtons.left
                anchors.topMargin: 5
                color: "transparent"
                visible: true

                LinArcxTextField {
                    id: txtYear
                    width: btnFromJalali.width
                    height: 30
                    placeholderText: CStr.phYear
                }

                LinArcxTextField {
                    id: txtMonth
                    width: btnFromGregorian.width
                    height: 30
                    placeholderText: CStr.phMonth
                    anchors.left: txtYear.right
                    anchors.leftMargin: 5
                }

                LinArcxTextField {
                    id: txtDay
                    width: btnFromHijri.width
                    height: 30
                    placeholderText: CStr.phDay
                    anchors.left: txtMonth.right
                    anchors.leftMargin: 5
                }
            }

            Rectangle {
                id: rctFromJalali
                width: parent.width
                height: parent.height / 3
                anchors.top: rctYMD.bottom
                anchors.left: rctYMD.left
                anchors.topMargin: 5
                color: "transparent"

                Button {
                    id: btnConvert
                    text: "تبدیل کن!"
                    width: parent.width / 3 - 5
                    anchors.centerIn: parent
                    background: Rectangle {
                        border.width: 1
                        radius: 2
                        color: "#d1bf94"
                    }
                    onClicked: {
                        shamsiToGregorain = mDate.shamsiToGregorain(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblGregorianConvertor.text = shamsiToGregorain[2] + " "
                                + mCalendar.gregorianMonthName(
                                    shamsiToGregorain[1]) + " " + shamsiToGregorain[0]

                        shamsiToHijri = mDate.shamsiToHijri(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblHijriConvertor.text = shamsiToHijri[2] + " " + mCalendar.hijriMonthName(
                                    shamsiToHijri[1]) + " " + shamsiToHijri[0]
                    }
                }

                Image {
                    id: imgHijriConverter
                    source: CStr.imgKsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                }

                Label {
                    id: lblHijriConvertor
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgHijriConverter.right
                    anchors.verticalCenter: imgHijriConverter.verticalCenter
                    anchors.leftMargin: 10
                }

                Image {
                    id: imgGregorianConverter
                    source: CStr.imgUsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: lblGregorianConvertor
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.right: imgGregorianConverter.left
                    anchors.verticalCenter: imgGregorianConverter.verticalCenter
                    anchors.rightMargin: 10
                }
            }

            Rectangle {
                id: rctFromGregorian
                width: parent.width
                height: parent.height / 3
                anchors.top: rctYMD.bottom
                anchors.left: rctYMD.left
                anchors.topMargin: 5
                color: "transparent"
                visible: false

                Button {
                    id: btnConvertFromGregorian
                    text: "تبدیل کن!"
                    width: parent.width / 3 - 5
                    anchors.centerIn: parent
                    background: Rectangle {
                        border.width: 1
                        radius: 2
                        color: "#d1bf94"
                    }
                    onClicked: {
                        gregorianToShamsi = mDate.gregorainToShamsi(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblFromGregorianToJalali.text = gregorianToShamsi[2]
                                + " " + mCalendar.shamsiMonthName(
                                    gregorianToShamsi[1]) + " " + gregorianToShamsi[0]

                        gregorianToHijri = mDate.gregorianToHijri(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblFromGregorianToHijri.text = gregorianToHijri[2] + " "
                                + mCalendar.hijriMonthName(
                                    gregorianToHijri[1]) + " " + gregorianToHijri[0]
                    }
                }

                Image {
                    id: imgFromGregorianToHijri
                    source: CStr.imgKsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                }

                Label {
                    id: lblFromGregorianToHijri
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgFromGregorianToHijri.right
                    anchors.verticalCenter: imgFromGregorianToHijri.verticalCenter
                    anchors.leftMargin: 10
                }

                Image {
                    id: imgFromGregorianToJalali
                    source: CStr.imgIran
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: lblFromGregorianToJalali
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.right: imgFromGregorianToJalali.left
                    anchors.verticalCenter: imgFromGregorianToJalali.verticalCenter
                    anchors.rightMargin: 10
                }
            }

            Rectangle {
                id: rctFromHijri
                width: parent.width
                height: parent.height / 3
                anchors.top: rctYMD.bottom
                anchors.left: rctYMD.left
                anchors.topMargin: 5
                color: "transparent"
                visible: false

                Button {
                    id: btnConvertFromHijri
                    text: "تبدیل کن!"
                    width: parent.width / 3 - 5
                    anchors.centerIn: parent
                    background: Rectangle {
                        border.width: 1
                        radius: 2
                        color: "#d1bf94"
                    }
                    onClicked: {
                        hijriToGregorian = mDate.hijriToGregorian(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblFromHijriToGregorian.text = hijriToGregorian[2] + " "
                                + mCalendar.gregorianMonthName(
                                    hijriToGregorian[1]) + " " + hijriToGregorian[0]

                        hijriToShamsi = mDate.hijriToShamsi(
                                    parseInt(txtYear.text),
                                    parseInt(txtMonth.text),
                                    parseInt(txtDay.text))
                        lblFromHijriToJalali.text = hijriToShamsi[2] + " "
                                + mCalendar.shamsiMonthName(
                                    hijriToShamsi[1]) + " " + hijriToShamsi[0]
                    }
                }

                Image {
                    id: imgFromHijriToGregorian
                    source: CStr.imgUsa
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                }

                Label {
                    id: lblFromHijriToGregorian
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.left: imgFromHijriToGregorian.right
                    anchors.verticalCenter: imgFromHijriToGregorian.verticalCenter
                    anchors.leftMargin: 10
                }

                Image {
                    id: imgFromHijriToJalali
                    source: CStr.imgIran
                    sourceSize.height: parent.height
                    sourceSize.width: parent.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label {
                    id: lblFromHijriToJalali
                    font.family: fntVazirDF.name
                    font.pixelSize: 12
                    anchors.right: imgFromHijriToJalali.left
                    anchors.verticalCenter: imgFromHijriToJalali.verticalCenter
                    anchors.rightMargin: 10
                }
            }
        }
    }
}
