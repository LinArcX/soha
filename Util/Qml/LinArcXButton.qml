import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    property string mText

    checkable: true
    autoExclusive: true
    //width: parent.width
    background: Rectangle {
        //opacity: enabled ? 1 : 0.3
        //border.color: control.down ? "#17a81a" : "#21be2b"
        border.width: 0.7
        radius: 2
        color: checked ? "Grey" : "#cccccc"
    }
    contentItem: Text {
        horizontalAlignment: Text.AlignLeft
        color: checked ? "Black" : "#7c7b79"
        text: mText
    }
}
