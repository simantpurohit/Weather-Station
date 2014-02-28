import QtQuick 2.0

//Item for second button
Item {

    id: genButton
    signal clicked
    property int buttonHeight: 100
    property int buttonWidth: 100
    property string buttonText
    property int buttonFontSize: (buttonHeight*0.2)
    property string buttonUp: "buttonDown.png"
    property string buttonDown: "buttonUp.png"


    //Button container
    Rectangle {
        id: buttonRect
        width: genButton.buttonWidth
        height: genButton.buttonHeight
        color:"transparent"
        anchors.fill: parent
        radius:100

    }

    //Button mouse area
    MouseArea {
        id:buttonMouse
        anchors.fill: buttonImage

        onClicked: {
            genButton.clicked();
        }
    }

    //Button image
    Image {
        id:buttonImage
        source: buttonUp
        //anchors.centerIn: parent
        width: genButton.buttonWidth
        height: genButton.buttonHeight
        fillMode: Image.Stretch
        smooth: true
        opacity: 0.6
    }

    //button text
    Text {
        id: buttonText
        text:genButton.buttonText
        font.family: "Arial Rounded MT Bold"
        font.bold: true
        anchors.centerIn: buttonImage
        font.pointSize: genButton.buttonFontSize
    }

}
