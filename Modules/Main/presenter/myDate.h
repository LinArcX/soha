#pragma once

#include <QObject>
#include <QVariantList>

class MyDate : public QObject {
    Q_OBJECT

public:
    explicit MyDate(QObject* parent = nullptr);

    Q_INVOKABLE QVariantList shamsiToGregorain(QVariant year, QVariant month, QVariant day);
    Q_INVOKABLE QVariantList shamsiToHijri(QVariant year, QVariant month, QVariant day);

    Q_INVOKABLE QVariantList gregorainToShamsi(QVariant year, QVariant month, QVariant day);
    Q_INVOKABLE QVariantList gregorianToHijri(QVariant year, QVariant month, QVariant day);

    Q_INVOKABLE QVariantList hijriToShamsi(QVariant year, QVariant month, QVariant day);
    Q_INVOKABLE QVariantList hijriToGregorian(QVariant year, QVariant month, QVariant day);
};
