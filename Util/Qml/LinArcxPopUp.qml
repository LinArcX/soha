import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Controls 2.3

Popup {
    property string puTitle
    property string puImage
    property string puDesc
    property variant puParent
    property string puFontFamily
    property variant puY
    property variant puX

    id: mPopUp
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    width: puParent.width / 2
    height: puParent.height / 2
    //parent: puParent

    x: puX//puParent.width / 2 - mPopUp.width / 2
    y: puY//-puParent.height / 2 - mPopUp.height / 2

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
        NumberAnimation { property: "y"; from: y; to: y + 10; duration: 200 }
    }

    Image {
        id: imgClose
        x: -20
        y: -20
        source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgdmlld0JveD0iMCAwIDUxMiA1MTIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMiA1MTI7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxjaXJjbGUgc3R5bGU9ImZpbGw6I0ZGNzU3QzsiIGN4PSIyNTYiIGN5PSIyNTYiIHI9IjI0NS44MDEiLz4NCjxwb2x5Z29uIHN0eWxlPSJmaWxsOiNGMkYyRjI7IiBwb2ludHM9IjM5NS41NjEsMTY0LjAzOCAzNDcuOTYxLDExNi40NCAyNTYsMjA4LjQwMSAxNjQuMDM5LDExNi40NCAxMTYuNDM5LDE2NC4wMzggMjA4LjQwMSwyNTYgDQoJMTE2LjQzOSwzNDcuOTYyIDE2NC4wMzksMzk1LjU2IDI1NiwzMDMuNTk5IDM0Ny45NjEsMzk1LjU2IDM5NS41NjEsMzQ3Ljk2MiAzMDMuNTk5LDI1NiAiLz4NCjxnPg0KCTxwYXRoIHN0eWxlPSJmaWxsOiM0RDRENEQ7IiBkPSJNMjU2LDUxMmMtNjguMzgsMC0xMzIuNjY3LTI2LjYyOC0xODEuMDItNzQuOThTMCwzMjQuMzgsMCwyNTZTMjYuNjI4LDEyMy4zMzMsNzQuOTgsNzQuOTgNCgkJUzE4Ny42MiwwLDI1NiwwczEzMi42NjcsMjYuNjI4LDE4MS4wMiw3NC45OFM1MTIsMTg3LjYyLDUxMiwyNTZzLTI2LjYyOCwxMzIuNjY3LTc0Ljk4LDE4MS4wMlMzMjQuMzgsNTEyLDI1Niw1MTJ6IE0yNTYsMjAuMzk4DQoJCUMxMjYuMDg5LDIwLjM5OCwyMC4zOTgsMTI2LjA4OSwyMC4zOTgsMjU2UzEyNi4wODksNDkxLjYwMiwyNTYsNDkxLjYwMlM0OTEuNjAyLDM4NS45MTEsNDkxLjYwMiwyNTZTMzg1LjkxMSwyMC4zOTgsMjU2LDIwLjM5OHoiDQoJCS8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik0zNDcuOTYyLDQwNS43NTljLTIuNjEsMC01LjIyMS0wLjk5Ni03LjIxMi0yLjk4N0wyNTYsMzE4LjAyMmwtODQuNzQ5LDg0Ljc1DQoJCWMtMy45ODMsMy45ODItMTAuNDQxLDMuOTgyLTE0LjQyNSwwbC00Ny41OTktNDcuNTk5Yy0zLjk4My0zLjk4My0zLjk4My0xMC40NDEsMC0xNC40MjVMMTkzLjk3OCwyNTZsLTg0Ljc1LTg0Ljc0OQ0KCQljLTMuOTgzLTMuOTgzLTMuOTgzLTEwLjQ0MSwwLTE0LjQyNWw0Ny41OTktNDcuNTk5YzMuOTgzLTMuOTgyLDEwLjQ0MS0zLjk4MiwxNC40MjUsMEwyNTYsMTkzLjk3OGw4NC43NDktODQuNzUNCgkJYzMuOTgzLTMuOTgyLDEwLjQ0MS0zLjk4MiwxNC40MjUsMGw0Ny41OTksNDcuNTk5YzMuOTgzLDMuOTgzLDMuOTgzLDEwLjQ0MSwwLDE0LjQyNUwzMTguMDIyLDI1Nmw4NC43NSw4NC43NDkNCgkJYzMuOTgzLDMuOTgzLDMuOTgzLDEwLjQ0MSwwLDE0LjQyNWwtNDcuNTk5LDQ3LjU5OUMzNTMuMTgyLDQwNC43NjQsMzUwLjU3Miw0MDUuNzU5LDM0Ny45NjIsNDA1Ljc1OXogTTI1NiwyOTMuMzk5DQoJCWMyLjYxLDAsNS4yMjEsMC45OTYsNy4yMTIsMi45ODdsODQuNzQ5LDg0Ljc1bDMzLjE3NS0zMy4xNzVsLTg0Ljc1LTg0Ljc0OWMtMy45ODMtMy45ODMtMy45ODMtMTAuNDQxLDAtMTQuNDI1bDg0Ljc1LTg0Ljc0OQ0KCQlsLTMzLjE3NS0zMy4xNzVsLTg0Ljc0OSw4NC43NWMtMy45ODMsMy45ODItMTAuNDQxLDMuOTgyLTE0LjQyNSwwbC04NC43NDktODQuNzVsLTMzLjE3NSwzMy4xNzVsODQuNzUsODQuNzQ5DQoJCWMzLjk4MywzLjk4MywzLjk4MywxMC40NDEsMCwxNC40MjVsLTg0Ljc1LDg0Ljc0OWwzMy4xNzUsMzMuMTc1bDg0Ljc0OS04NC43NUMyNTAuNzc5LDI5NC4zOTYsMjUzLjM5LDI5My4zOTksMjU2LDI5My4zOTl6Ii8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik00NTQuMzY5LDMzOC42MTZjLTEuMTYsMC0yLjMzOC0wLjE5OS0zLjQ5LTAuNjE5Yy01LjI5Mi0xLjkyOS04LjAyLTcuNzgyLTYuMDkyLTEzLjA3NA0KCQljOS43NDYtMjYuNzUzLDEzLjczNi01NS45NTcsMTEuNTM5LTg0LjQ1OGMtMC40MzMtNS42MTYsMy43NjktMTAuNTE5LDkuMzg1LTEwLjk1M2M1LjYyMi0wLjQ0OSwxMC41MTksMy43NjksMTAuOTUzLDkuMzg1DQoJCWMyLjQxOSwzMS4zODEtMS45NzcsNjMuNTQyLTEyLjcxMSw5My4wMDhDNDYyLjQ0NSwzMzYuMDQ0LDQ1OC41MzQsMzM4LjYxNiw0NTQuMzY5LDMzOC42MTZ6Ii8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik00NTkuNTY3LDIxMC4xMDZjLTQuNDc5LDAtOC41ODYtMi45NzMtOS44MjktNy41MDJjLTAuODAyLTIuOTE3LTEuNjgtNS44NTYtMi42MTMtOC43MzUNCgkJYy0xLjczNy01LjM1OCwxLjE5OS0xMS4xMSw2LjU1OC0xMi44NDdjNS4zNTYtMS43MzgsMTEuMTEsMS4xOTgsMTIuODQ3LDYuNTU4YzEuMDI4LDMuMTcxLDEuOTk3LDYuNDA4LDIuODc5LDkuNjIzDQoJCWMxLjQ5MSw1LjQzMi0xLjcwMiwxMS4wNDQtNy4xMzUsMTIuNTM2QzQ2MS4zNjksMjA5Ljk4Nyw0NjAuNDYsMjEwLjEwNiw0NTkuNTY3LDIxMC4xMDZ6Ii8+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg=="
        sourceSize.width: 20
        sourceSize.height: 20
        z: 1

        states: [
            State {
                name: "scale"
                PropertyChanges { target: imgClose; scale: 1.3; }
            },
            State {
                name: "normal"
                PropertyChanges { target: imgClose; scale: 1; }
            }
        ]

        transitions: Transition {
            ScaleAnimator { duration: 100; }
        }

        MouseArea{
            hoverEnabled: true
            anchors.fill: parent
            onClicked: mPopUp.close();
            onEntered: imgClose.state = "scale";
            onExited: imgClose.state = "normal";
        }
    }

    Rectangle{
        anchors.fill: parent

        Image {
            id: imgPopUp
            source: puImage
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.margins: 20
            anchors.top: parent.top
            anchors.left: parent.left
            antialiasing: true
        }

        Text {
            text: puTitle
            anchors.margins: 20
            anchors.right: parent.right
            anchors.top: parent.top
            font.family: puFontFamily
            font.pixelSize: 30
        }

        Rectangle{
            id: spacer
            width: parent.width - 20
            height: 3
            color: "#999"
            anchors.top: imgPopUp.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ScrollView {
            id: mScrollView
            clip: true
            width: parent.width
            height: parent.height - (spacer.height + imgPopUp.height + 25)
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            anchors.top: spacer.bottom
            anchors.left: parent.left
            anchors.margins: 10

            Text {
                text: puDesc
                width: mPopUp.width - 60
                wrapMode: TextArea.Wrap
                font.family: puFontFamily
                font.pixelSize: 14
            }
        }
    }
}
