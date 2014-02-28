import QtQuick 2.0
import "controlFile.js" as Control
import "Weather.js" as Weather


//The main root rectangle. This rectangle holds all the other rectangles in the application

Rectangle {
    id: root
    width: 1366
    height: 768

    //These are some global properties defined. These are common throughout the code
    property string city: "Chicago"
    property string language: "English"
    property string tempScale: "C"
    property int back1: 1
    property int back2: 0
    property int animationDuration: 1000
    property string day_night: "Day"


    //Image for the background (Two images are declared so that fading effect can be applied efficiently)

    Image {
        id:background
        source: "default.jpg"
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        fillMode: Image.Stretch
        smooth:true
        cache: true
        opacity: 1

        NumberAnimation on opacity {
            id:showBackground
            to:1
            duration:root.animationDuration
            running:false


        }

        NumberAnimation on opacity {
            id:hideBackground
            to:0
            duration:root.animationDuration
            running:false


        }
    }

    Image {
        id:background2
        //source:"Black and White Tree.jpg"
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        fillMode: Image.Stretch
        smooth:true
        cache: true
        opacity: 0

        NumberAnimation on opacity {
            id:showBackground2
            to:1
            duration:root.animationDuration
            running:false


        }

        NumberAnimation on opacity {
            id:hideBackground2
            to:0
            duration:root.animationDuration
            running:false

        }

    }


    //Parallel Animation for hiding the main weather screen

    ParallelAnimation {
        id:hideMain
        running: false

        NumberAnimation { target: container; property: "x"; to:-2000; duration: 1000; easing.type: Easing.OutCurve }
        NumberAnimation { target: container; property: "opacity"; to:0; duration: 500 }

        NumberAnimation { target: todayRect; property: "x"; to:2000; duration: 1000; easing.type: Easing.OutCurve }
        NumberAnimation { target: todayRect; property: "opacity"; to:0; duration: 500 }

        NumberAnimation { target: forecastRectangle; property: "x"; to:-2000; duration: 1000; easing.type: Easing.OutCurve }
        NumberAnimation { target: forecastRectangle; property: "opacity"; to:0; duration: 500 }

    }

    //Parallel Animation for displaying the main weather screen

    ParallelAnimation {
        id:showMain
        running: false

        NumberAnimation { target: container; property: "x"; to:0; duration: 500; easing.type: Easing.InCurve }
        NumberAnimation { target: container; property: "opacity"; to:1; duration: 1000 }

        NumberAnimation { target: todayRect; property: "x"; to:0; duration: 500; easing.type: Easing.InCurve }
        NumberAnimation { target: todayRect; property: "opacity"; to:1; duration: 1000 }

        NumberAnimation { target: forecastRectangle; property: "x"; to:0 ; duration: 500; easing.type: Easing.InCurve }
        NumberAnimation { target: forecastRectangle; property: "opacity"; to:1; duration: 1000 }

    }


    //Rectangle used to contain other rectangles in the main weather screen

    Rectangle {
        id: container
        width: root.width
        height: ((root.height/4) + (root.height/16))
        color: "transparent"
        opacity: 0;
        x:-500



      //Rectangle used to display the topmost elements of the main weather screen
      Rectangle {
            id:topRowRectMain
            width: root.width
            height: root.height/16
            color:"transparent"

            //Background image of the top rectangle
            Image {
                id: topRowImage
                source: "whiteBack.png"
                anchors.fill: parent
                opacity: 0.2
                anchors.leftMargin: 15

            }

            //City text that is shown on the top of the weather screen page
            Text {
                id: cityDescription
                color: "#020203"
                text:"Unknown"
                font.family: "Arial Rounded MT Bold"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.pointSize: 16
                anchors.centerIn: parent
            }

            //Row is defined to help hold various side by side rectangle on the top row of the ain weather screen
            Row {
                   id: topRow
                   property int rowHeight : (root.height/16)
                   property int rowWidth : (root.width/4)


                   //This rectangle hold the icon for the refresh button
                   Rectangle {
                       id: topRowRect2
                       width: 50
                       height: topRow.rowHeight
                       color:"transparent"
                       //border.color: "red"

                       //Parallel animation for rotating the refresh button when pressed
                       ParallelAnimation {
                           id: refreshButtonRotate
                           running: false
                           NumberAnimation { target: topRowRect2 ; property: "rotation"; to: 720; duration: 2000 }
                       }

                       //Setting the rotation of the refresh button to initial value after refresh action is completed
                       Timer {
                           id:refreshButtonRotateReset
                           interval: 3000
                           repeat:false
                           running:false
                           onTriggered: {
                               topRowRect2.rotation = 0
                           }
                       }

                       //Refresh button
                       Button {
                           id:refresh
                           buttonHeight: parent.height
                           buttonWidth: 50
                           buttonDown: "refresh.png"
                           buttonUp: "refresh.png"

                           onClicked: {
                               Weather.sendRequest(root.city);
                               refreshButtonRotate.start()
                               refreshButtonRotateReset.start();

                           }
                       }

                   }

                   //This Rectangle holds the date text showed on the top left of the main weather screen
                   Rectangle {
                       id:dateRect
                       width: 300
                       height: 50
                       color:"transparent"

                       //Date text
                       Text {
                           id:dateText
                           text: "unknown"
                           font.family: "Arial Rounded MT Bold"
                           anchors.fill: parent
                           anchors.topMargin: 5
                           anchors.leftMargin: 25
                           color: "#020203"
                           font.pointSize: 12

                       }

                   }

                   //A filler rectangle used to fill up space between two rectangles
                   Rectangle {
                       id:filler
                       width: root.width - 700
                       height:50
                       color: "transparent"
                   }


                   //This rectangle holds the time of the current location shown on the top right of the screen
                   Rectangle {
                       id:timeRect
                       width: 300
                       height: 50
                       color:"transparent"

                    //Time Text
                       Text {
                           id:timeTextBox
                           text: "unknown"
                           font.family: "Arial Rounded MT Bold"
                           anchors.fill: parent
                           color: "#020203"
                           font.pointSize: 12
                           horizontalAlignment: Text.AlignRight
                           anchors.rightMargin: 35
                           anchors.topMargin: 5

                       }
                   }

                   //This rectangle holds the settings button located on the top right of the screen
                   Rectangle {
                       id: topRowRect1
                       color:"transparent"
                       width: 50
                       height: topRow.rowHeight
                       //border.color: "green"


                       Button {
                           id:cityChangeButton
                           buttonHeight: parent.height
                           buttonWidth: parent.width
                           //buttonText: "Options"
                           anchors.fill: parent
                           buttonDown: "settingsPressed.png"
                           buttonUp: "settings.png"


                           onClicked: {
                               Weather.setOptionImage();
                               optionsScreen.visible = true
                               optionsScreen.opacity = 0
                               optionsWindowAnimate.restart()
                               hideMain.start()
                           }

                       }

                   }
               }
        }


      //Row contains rectangles to display the current conditions and the indoor conditions

      Row {
           id: secondRow
           anchors.top:topRowRectMain.bottom

           //This rectangle holds the current conditions description of the weather
           Rectangle {
               id: leftRect
               //border.color: "red"
               color: "transparent"
               width:((root.width/3)+25)
               height: root.height/4

               //Background image for current conditions
               Image {
                   id:currentConditionsBackground
                   source: "whiteBack.png"
                   x:-15
                   y:-5
                   width: 450
                   height:210
                   opacity: 0.05

               }

               //Text for weather description
               Text {
                   id:currentConditions
                   text: "Current conditions"
                   font.family: "Arial Rounded MT Bold"
                   color: "#020203"
                   font.pointSize: 12
                   font.italic: true
                   x:10
                   y:10


               }

               //Contains the details of the current weather conditions
               Rectangle {
                   id: innerLeft
                   //border.color: "blue"
                   color: "transparent"
                   width: (parent.width/3)
                   height:(parent.height/2)
                   anchors.left:parent.left
                   anchors.leftMargin: 10

                   //Current Temperature text
                   Text{
                       id:tempText
                       text:"Unknown"+(Control.getDegree())+"C"
                       font.family: "Times New Roman"
                       font.bold: true
                       style: Text.Raised
                       anchors.left: parent.left
                       y: parent.y+25
                       font.pointSize: 39
                       color: "#C0C0C0"

                   }

               }

               //Contains the arrow image and its rotation details to display the wind direction on the screen
               Rectangle {
                   id: innerRight
                   //border.color: "green"
                   color: "transparent"
                   width: 150
                   height:120
                   anchors.bottom: leftRect.bottom
                   anchors.left:innerLeftBottom.right
                   property int toggleValue: 0

                   //Text to display windspeed
                   Text {
                       id:windspeed
                       text:"unknown"
                       anchors.top: arrow.bottom
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 10
                       x:5
                       color: "#020203"

                   }

                   //Text for wind degrees (Not shown)
                   Text {
                       id:windDegreesText
                       text:"unknown"
                       anchors.left: arrow.right
                       font.pointSize: 11
                       y:innerRight.y + 60
                       //x: parent.x - 40
                       color: "red"
                       style: Text.Raised
                       visible: false
                   }

                   //Wind direction arrow images
                   Image {
                       id: arrow
                       source: "arrow.png"
                       //y: innerRight.y+20
                       width: 100
                       height: 100
                       fillMode: Image.Stretch
                       anchors.top: innerRight.top
                       anchors.topMargin: 5
                       smooth: true
                       cache: true
                       property int rotationAngle: arrow2.rotationAngle2;
                       states:
                           State {
                                    name: "rotated"
                                    PropertyChanges { target: arrow; rotation:arrow.rotationAngle}
                                }

                                transitions:
                                    Transition {

                                        RotationAnimation {
                                        properties: "rotation";
                                        //from: arrow2.rotationAngle2
                                        to:arrow.rotationAngle
                                        duration:4000
                                        direction: RotationAnimation.Clockwise
                                        easing.type: Easing.InExpo

                                    }

                                }
                   }

                   Image {
                       id: arrow2
                       source: "arrow2.png"
                       fillMode: Image.Stretch
                       width: 100
                       height: 100
                       //y: innerRight.y+20
                       anchors.top: innerRight.top
                       anchors.topMargin: 5
                       smooth: true
                       cache: true
                       property int rotationAngle2:arrow.rotationAngle;
                       states:
                           State {
                                    name: "rotated"
                                    PropertyChanges { target: arrow2; rotation:arrow2.rotationAngle2}
                                }

                                transitions:
                                    Transition {
                                        id:arrow2Animate
                                        RotationAnimation {
                                        properties: "rotation";
                                        //from: arrow.rotationAngle
                                        to:arrow2.rotationAngle2
                                        duration:4000
                                        direction: RotationAnimation.Clockwise
                                        easing.type: Easing.InExpo

                                    }

                                }





           }

               }


               Rectangle {
                   id: innerLeftBottom
                   //border.color: "white"
                   color: "transparent"
                   width: 250
                   height:(parent.height/2)+10
                   anchors.left:parent.left
                   anchors.bottom: parent.bottom
                   anchors.leftMargin: 5

                   //Weather Description text
                   Text {
                       id: weatherDesc
                       text:"Unknown"
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 12
                       x:5
                       y:3
                       color: "#020203"
                   }

                   //Humidity text
                   Text {
                       id: humidityDesc
                       text:"Unknown"
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 12
                       x:5
                       color: "#020203"
                       y: weatherDesc.y+21
                   }

                   //Clouds text
                   Text {
                       id: cloudsDesc
                       text:"Unknown"
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 12
                       x:5
                       color: "#020203"
                       y: humidityDesc.y+21
                   }

                   //precipitation text
                   Text {
                       id: precipDesc
                       text:"Unknown"
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 12
                       x:5
                       color: "#020203"
                       y: cloudsDesc.y+21
                   }

                   //Visibility Text
                   Text {
                       id: visibilityDesc
                       text:"Unknown"
                       font.family: "Arial Rounded MT Bold"
                       styleColor: "#0f0e0e"
                       font.pointSize: 12
                       x:5
                       color: "#020203"
                       y: precipDesc.y+21
                   }
               }

                //Test rectangle. Not used anywhere. For reference purposes only
               Rectangle {
              id:test
              width: 200
              height: 400
              color: "red"
              x:500
              y:50
              visible: false

              Text {
                  id: weatherInfo
                  text:"Info Here"
                  anchors.centerIn: parent
              }

              MouseArea {
                  id:mouse
                  anchors.fill: parent
                  onClicked: {

                  }
              }
          }


           }

            //filler rectangle to shift indoor contions to the right
           Rectangle {
               id:fillerRect
               width: (root.width-leftRect.width-indoorRect.width)
               height: 200
               //border.color:"blue"
               color:"transparent"

           }


           //Indoor Conditions rect
           Rectangle {
               id:indoorRect
               width: 280
               height: 200
               color:"transparent"

               //Timer to update time
               Timer {
                   id:timeChangeTimer
                   interval: 5000
                   running: false
                   repeat: true
                   onTriggered: {
                       Weather.getTime()
                   }
               }

               //column to display indoor condition
               Column {
                   id:indoorColumn

                   //Indoor conditions rect
                   Rectangle {
                       id:indoorConditionsRectangle
                       width: 250
                       height: 100
                       color:"transparent"
                       x:20
                       //border.color: "red"
                       //anchors.right: indoorRect.right
                       anchors.rightMargin: 10

                        //background image
                       Image {
                           id:indoorConditionsImage
                           source: "whiteBack.png"
                           anchors.fill: parent
                           opacity:0.2
                       }

                       //Indoor conditions text
                       Text {
                           id:indoorConditionsText
                           y:20
                           text:""
                           font.family: "Arial Rounded MT Bold"
                           horizontalAlignment: Text.AlignRight
                           anchors.fill: parent
                           font.pointSize: 12
                           color: "#020203"
                           anchors.rightMargin: 20
                           anchors.topMargin: 5
                       }

                   }



               }
           }

       }


      //This rectangle is used to display the alert box on the main weather screen
      Rectangle {
          id:alertRect
          width: root.width/3
          height:35
          //border.color: "red"
          y:240
          radius: 10
          color: "transparent"

          //alert box background
          Image {
              id: alertBack
              source: "whiteBack.png"
              height: parent.height
              width: parent.width - 110
              opacity: 0.1
          }

          //alert icon image
          Image {
              id: alertIcon
              source: "alert.png"
              height: parent.height
              width: parent.height
              x:10
          }
            //alert box text
          Text {
              id:alertText
              text:"No alerts right now"
              font.family: "Arial Rounded MT Bold"
              verticalAlignment: Text.AlignVCenter
              font.pointSize: 12
              anchors.fill: parent
              anchors.left: alertIcon.right
              anchors.leftMargin: 65

          }

      }

    }



    //This contains the rectangles for the welcome screens
    Rectangle {
        id: container2
        visible: true
        width: root.width
        height: root.height
        color: "transparent"

        //Animation to animate welcome screens
        ParallelAnimation {
            id:parallelSwipeFade
            running: false

             NumberAnimation { target: welcome; property: "x"; to: -2000; duration: 1000 }
             NumberAnimation { target: welcome; property: "opacity"; to: 0; duration: 500 }
             NumberAnimation { target: welcome; property: "rotation"; to: 0; duration: 3000 }
             NumberAnimation { target: scaleAndLanguageRect; property: "opacity"; to: 1; duration: 1500 }
             NumberAnimation { target: scaleAndLanguageRect; property: "rotation"; to: 0; duration: 5;}
             NumberAnimation { target: scaleAndLanguageRect; property: "x"; to: 420; duration: 1000 }

        }


        //The first welcome rectangle
        Rectangle {
                id:welcome
                width: container2.width/2
                height: container2.height
                //border.color: "blue"
                color: "transparent"
                opacity: 1
                x:350

                //Welcome text
                Text {
                    id:welcomeText
                    text: "Welcome to your Weather Station! \n\n Please select your Language"
                    font.family: "Arial Rounded MT Bold"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    width: (parent.width)
                    height: (parent.height/5)
                    font.pointSize: 24
                    anchors.right: parent.right
                    y:75
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                //Continue button to go to next welcome screen
                Button {
                    id:goToScaleSelection
                    buttonHeight: (welcome.height/10)
                    buttonWidth: (welcome.width/5.1)
                    buttonText: "Continue"
                    buttonFontSize: (buttonHeight*0.2)
                    anchors.topMargin: 50
                    anchors.top:welcomeScreenLanguage.bottom
                    x:275

                    //Button actions descriptions
                    onClicked: {
                        //scaleAndLanguageRect.visible = true
                        root.city = welcomeScreenTextInput.text
                        parallelSwipeFade.start()
                        //showScaleAndLanguageRect.start()
                    }
                }


                Rectangle {
                    id:welcomeScreenLanguage
                    //border.color: "red"
                    width: parent.width
                    height: 300
                    color: "transparent"
                    anchors.right: welcome.right
                    anchors.top : welcomeText.bottom


                    Grid {

                        id: languageGrid
                        columns: 3
                        rows: 4
                        anchors.centerIn: parent

                        property int gridwidth: 150
                        property int gridheight: 50
                        property int gridButtonHeight: 50
                        property int gridButtonWidth: 150

                        Rectangle {
                            color: "transparent"
                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                            Button {
                                id: arabic
                                buttonHeight: languageGrid.gridButtonHeight
                                buttonWidth: languageGrid.gridButtonWidth

                                buttonText: "Arabic"
                                anchors.fill: parent

                            }

                        }

                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button2 {
                            id: english
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonUp: "buttonUp.png"
                            buttonDown: "buttonDown.png"

                            buttonText: "English"
                            anchors.fill: parent

                            onClicked: {
                                Weather.language = "English"
                                Weather.languageToggle();

                                english.buttonDown = "buttonDown.png"
                                english.buttonUp = "buttonUp.png"
                                spanish.buttonDown = "buttonUp.png"
                                spanish.buttonUp = "buttonDown.png"


                            }

                        }

                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: french
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "French"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: german
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "German"
                            anchors.fill: parent
                        }

                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: hindi
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Hindi"
                            anchors.fill: parent
                        }

                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: indonesian
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Indonesian"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: japanese
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Japanese"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: mandarin
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Mandarin"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: portuguese
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Portuguese"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: punjabi
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Punjabi"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button {
                            id: russian
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Russian"
                            anchors.fill: parent
                        }
                        }


                        Rectangle {
                            color: "transparent"

                            width: languageGrid.gridwidth
                            height: languageGrid.gridheight

                        Button2 {
                            id: spanish
                            buttonHeight: languageGrid.gridButtonHeight
                            buttonWidth: languageGrid.gridButtonWidth

                            buttonText: "Spanish"
                            anchors.fill: parent

                            onClicked: {
                                Weather.language = "Spanish"
                                Weather.languageToggle();
                                english.buttonDown = "buttonUp.png"
                                english.buttonUp = "buttonDown.png"
                                spanish.buttonDown = "buttonDown.png"
                                spanish.buttonUp = "buttonUp.png"

                            }
                        }
                        }

                    }

                    Text {
                        id:languageSelectedInfo
                        width: parent.width
                        height:100
                        text:"Language selected is English"
                        font.family: "Arial Rounded MT Bold"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignBottom
                        font.pointSize: 16
                        anchors.bottom: parent.bottom


                    }


                }


            }


        //The second welcome screen
        Rectangle {
            id: scaleAndLanguageRect
            width: container2.width/2
            height: container2.height
            color: "transparent"
            opacity: 0
            x:2000
            rotation: -180

            //Animation to animate this rectangle
            ParallelAnimation {
                id:hideContainer2
                NumberAnimation { target: scaleAndLanguageRect; property: "opacity"; to: 0; duration: 500 }
                //NumberAnimation { target: scaleAndLanguageRect; property: "rotation"; to: 180; duration: 1000;}
                NumberAnimation { target: scaleAndLanguageRect; property: "x"; to: -2000; duration: 1000 }
                running: false
            }

            //Rectangle to display city and unit information
            Rectangle {
                    id:scaleAndLanguageBackRect
                    height: parent.height
                    width:parent.width
                    color:"transparent"
                    //border.color: "blue"
                    anchors.top: parent.top


                    Rectangle {
                        id:languageRectangle
                        //border.color: "green"
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        anchors.centerIn: parent

                        //Enter your city name text
                        Text {
                            id:askForCity
                            width: 250
                            height: 50
                            text:"Please Enter Your City Below"
                            font.family: "Arial Rounded MT Bold"
                            font.pointSize: 16
                            x:30
                            y:50
                            color: "black"
                            font.underline: true
                        }

                        //Text input rectangle
                        Rectangle {
                            id:welcomeScreenTextInputRectangle
                            color:"transparent"
                            //border.color: "red"
                            anchors.topMargin: 20
                            width: 300
                            height: 35
                            y:90
                            x:20
                            //text input background
                            Image {
                                id: welcomeScreenTextInputImage
                                source: "whiteBack.png"
                                anchors.fill: parent
                                opacity: 0.5
                            }


                            TextInput {
                                id:welcomeScreenTextInput
                                text:root.city
                                font.family: "Arial Rounded MT Bold"
                                font.pointSize: 16
                                anchors.leftMargin: 20
                                anchors.fill: welcomeScreenTextInputImage
                                focus: true
                                anchors.topMargin: 5
                        }
                    }


                        //Button to show the weather screen
                        Button {
                            id:showMeWeather
                            buttonHeight: 50
                            buttonWidth: 300
                            buttonText: "Show me the weather"

                            y:450
                            x:30

                            onClicked: {
                                root.city = welcomeScreenTextInput.text
                                console.log("Sending Request Now")
                                Weather.sendRequest(root.city)
                                console.log("Request sent now")
                                hideContainer2.start()
                                animateTimer.start()
                                console.log("destroyed")

                            }


                        }

                        //timer to animate the rectangles
                        Timer {
                            id:animateTimer
                            interval: 500
                            running: false
                            repeat: false

                            onTriggered: {
                                showMain.start()
                            }
                        }


                        //Unit scale information
                        Text {
                            id:toggleTempScale
                            text:"Please select Imperial/Metric scale"
                            font.family: "Arial Rounded MT Bold"
                            font.pointSize: 16
                            anchors.topMargin: 30
                            anchors.leftMargin: 20
                            y:220
                            x:30
                            font.underline: true

                        }


                        //Scale information
                        Text {
                            id:scaleInfo
                            text:"Imperial Scale Selected"
                            font.family: "Arial Rounded MT Bold"
                            x:30
                            y:260
                            font.pointSize: 15
                        }

                        //User note
                        Text {
                            id:scaleDesc
                            text:"Note: Temperature will be shown in Farenhite scale and Windspeed in Miles Per Hour"
                            font.family: "Arial Rounded MT Bold"
                            x:30
                            y:360
                            //anchors.bottom: imperial_metric_toggle_Rect.bottom
                            anchors.bottomMargin: 10
                            font.pointSize: 10



                        }

                        //Button to switch to imperial scale
                        Button2 {
                            id:scaleToggle
                            buttonHeight: 45
                            buttonWidth: 200
                            buttonText: "Imperial"
                            anchors.leftMargin: 20
                            x:30


                            buttonDown: "buttonDown.png"
                            buttonUp: "buttonUp.png"

                            y:300

                            onClicked: {
                                Weather.changeToImperial();

                                scaleToggle.buttonDown = "buttonDown.png"
                                scaleToggle.buttonUp = "buttonUp.png"
                                scaleToggleBack.buttonDown = "buttonUp.png"
                                scaleToggleBack.buttonUp = "buttonDown.png"

                                scaleToggle2.buttonDown = "buttonDown.png"
                                scaleToggle2.buttonUp = "buttonUp.png"
                                scaleToggle2Back.buttonDown = "buttonUp.png"
                                scaleToggle2Back.buttonUp = "buttonDown.png"




                            }

                        }

                        //Button ro switch to metric scale
                        Button2 {
                            id:scaleToggleBack
                            buttonHeight: 45
                            buttonWidth: 200
                            buttonText: "Metric"
                            anchors.leftMargin: 20

                            x:250

                            y:300

                            onClicked: {
                                Weather.changeToMetric();

                                scaleToggle.buttonDown = "buttonUp.png"
                                scaleToggle.buttonUp = "buttonDown.png"
                                scaleToggleBack.buttonDown = "buttonDown.png"
                                scaleToggleBack.buttonUp = "buttonUp.png"

                                scaleToggle2.buttonDown = "buttonUp.png"
                                scaleToggle2.buttonUp = "buttonDown.png"
                                scaleToggle2Back.buttonDown = "buttonDown.png"
                                scaleToggle2Back.buttonUp = "buttonUp.png"

                            }

                        }



                    }




            }




        }




}

    //This screen contains rectangle for options screen
    Rectangle {
        id:optionsScreen
        visible: false
        width: parent.width
        height: parent.height
        color: "transparent"
        opacity: 0


        //For animating options screen
        ParallelAnimation {
            id:optionsWindowAnimate
            NumberAnimation { target: optionsScreen; property: "opacity"; to:1; duration: 1000 }

            //NumberAnimation { target: optionsRect; property: "y"; to:0 ; duration: 1000; easing.type: Easing.InCurve}
            NumberAnimation { target: optionsRect; property: "opacity"; to:1; duration: 1000 }

            //NumberAnimation { target: optionChange; property: "y"; to:0; duration: 1000;  easing.type: Easing.InCurve }
            NumberAnimation { target: optionChange; property: "opacity"; to:1; duration: 1000 }

            running: false

        }

        //For animating options screen
        ParallelAnimation {
            id:optionScreenHide

            NumberAnimation { target: optionsScreen; property: "opacity"; to:0; duration: 700 }

            //NumberAnimation { target: optionsRect; property: "y"; to:-500 ; duration: 1000; easing.type: Easing.OutCubic}
            NumberAnimation { target: optionsRect; property: "opacity"; to:0; duration: 700 }

            //NumberAnimation { target: optionChange; property: "y"; to:-500; duration: 1000;  easing.type: Easing.OutCubic }
            NumberAnimation { target: optionChange; property: "opacity"; to:0; duration: 700 }


            running:false
        }


        //Rectangle to ask for city input and unit selection
        Rectangle {
            id: optionsRect
            width: parent.width/2
            height: parent.height
            anchors.left: optionsScreen.left
            color:"transparent"
            //y:-500

            //City info rectangle
            Rectangle {
                id:cityAndScaleOptions
                //border.color: "green"
                width: parent.width/2
                height: parent.height
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 20
                //City text
                Text {
                    id:askForCity2
                    width: 250
                    height: 50
                    text:"Please Enter Your City Below"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: 15
                    x:30
                    y:50
                    color: "black"
                    //style: Text.Raised
                    font.underline: true
                }


                Rectangle {
                    id:welcomeScreenTextInputRectangle2
                    color:"transparent"
                    //border.color: "red"
                    anchors.topMargin: 20
                    width: 250
                    height: 35
                    y:90
                    x:20
                    radius: 5

                    Image {
                        id: welcomeScreenTextInputImage2
                        source: "whiteBack.png"
                        anchors.fill: parent
                        opacity: 0.5
                    }


                    TextInput {
                        id:welcomeScreenTextInput2
                        text:root.city
                        font.family: "Arial Rounded MT Bold"
                        font.pointSize: 14
                        anchors.leftMargin: 20
                        anchors.topMargin: 5
                        anchors.fill: welcomeScreenTextInputImage2
                        focus: true

                }
            }



                Button {
                    id:showMeWeather2
                    buttonHeight: 75
                    buttonWidth: 300
                    buttonText: "Show me the weather"

                    y:500
                    x:450

                    onClicked: {
                        //root.city = welcomeScreenTextInput.text
                        console.log("Sending Request Now")
                        root.city = welcomeScreenTextInput2.text
                        Weather.sendRequest(root.city)
                        console.log("Request sent now")
                        hideContainer2.start()
                        destroyTime2.start()
                        //optionsScreen.opacity = 0
                        optionScreenHide.start();
                        console.log("destroyed")


                    }

                    Timer{
                        id:destroyTime2
                        interval: 1000
                        running: false
                        repeat: false
                        onTriggered: {

                            showMain.start()
                        }
                    }



                }



                Text {
                    id:toggleTempScale2
                    text:"Please select Imperial/Metric scale"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: 15
                    //anchors.fill: parent
                    anchors.topMargin: 30
                    anchors.leftMargin: 20
                    y:200
                    x:30
                    font.underline: true

                }



                Text {
                    id:scaleInfo2
                    text:scaleInfo.text
                    font.family: "Arial Rounded MT Bold"
                    x:30
                    y:240
                    font.pointSize: 15
                }

                Text {
                    id:scaleDesc2
                    text:scaleDesc.text
                    font.family: "Arial Rounded MT Bold"
                    x:30
                    y:340
                    //anchors.bottom: imperial_metric_toggle_Rect.bottom
                    anchors.bottomMargin: 10
                    font.pointSize: 10



                }

                Button2 {
                    id:scaleToggle2
                    buttonHeight: 45
                    buttonWidth: 200
                    buttonText: scaleToggle.buttonText
                    anchors.leftMargin: 20

                    buttonDown: "buttonDown.png"
                    buttonUp: "buttonUp.png"

                    x:30

                    y:280

                    onClicked: {
                        Weather.changeToImperial();

                        scaleToggle2.buttonDown = "buttonDown.png"
                        scaleToggle2.buttonUp = "buttonUp.png"
                        scaleToggle2Back.buttonDown = "buttonUp.png"
                        scaleToggle2Back.buttonUp = "buttonDown.png"


                    }

                }

                Button2 {
                    id:scaleToggle2Back
                    buttonHeight: 45
                    buttonWidth: 200
                    buttonText: scaleToggleBack.buttonText
                    anchors.leftMargin: 20
                    x:250

                    y:280


                    onClicked: {

                        Weather.changeToMetric();
                        scaleToggle2.buttonDown = "buttonUp.png"
                        scaleToggle2.buttonUp = "buttonDown.png"
                        scaleToggle2Back.buttonDown = "buttonDown.png"
                        scaleToggle2Back.buttonUp = "buttonUp.png"


                    }

                }




            }


        }

        //Rectangle for language selection
        Rectangle {
            id:optionChange
            width:(parent.width/2)
            height: parent.height
            //border.color: "orange"
            anchors.left: optionsRect.right
            color:"transparent"
            //y:-500

            //Language selection text
            Text {
                id: askForLanguage
                text:"Please select your language"
                font.family: "Arial Rounded MT Bold"
                anchors.bottom: languageGrid2.top
                x:180
                anchors.bottomMargin: 30
                font.pointSize: 16

            }

            //Grid to display language buttons
            Grid {

                id: languageGrid2
                columns: 3
                rows: 4
                anchors.left: parent.left
                anchors.leftMargin: 100
                y: 80

                property int gridwidth: 150
                property int gridheight: 50
                property int gridButtonHeight: 50
                property int gridButtonWidth: 150

                Rectangle {
                    color: "transparent"
                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                    Button {
                        id: arabic2
                        buttonHeight: languageGrid2.gridButtonHeight
                        buttonWidth: languageGrid2.gridButtonWidth

                        buttonText: "Arabic"
                        anchors.fill: parent

                    }

                }

                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button2 {
                    id: english2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "English"
                    anchors.fill: parent

                    buttonDown: english.buttonDown
                    buttonUp: english.buttonUp

                    onClicked: {
                        Weather.language = "English"
                        Weather.languageToggle();

                        english2.buttonDown = "buttonDown.png"
                        english2.buttonUp = "buttonUp.png"
                        spanish2.buttonDown = "buttonUp.png"
                        spanish2.buttonUp = "buttonDown.png"

                    }

                }

                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: french2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "French"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: german2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "German"
                    anchors.fill: parent
                }

                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: hindi2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Hindi"
                    anchors.fill: parent
                }

                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: indonesian2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Indonesian"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: japanese2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Japanese"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: mandarin2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Mandarin"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: portuguese2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Portuguese"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: punjabi2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Punjabi"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button {
                    id: russian2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Russian"
                    anchors.fill: parent
                }
                }


                Rectangle {
                    color: "transparent"

                    width: languageGrid2.gridwidth
                    height: languageGrid2.gridheight

                Button2 {
                    id: spanish2
                    buttonHeight: languageGrid2.gridButtonHeight
                    buttonWidth: languageGrid2.gridButtonWidth

                    buttonText: "Spanish"
                    anchors.fill: parent

                    buttonDown: spanish.buttonDown
                    buttonUp: spanish.buttonUp

                    onClicked: {
                        Weather.language = "Spanish"
                        Weather.languageToggle();

                        english2.buttonDown = "buttonUp.png"
                        english2.buttonUp = "buttonDown.png"
                        spanish2.buttonDown = "buttonDown.png"
                        spanish2.buttonUp = "buttonUp.png"



                    }
                }
                }

            }

            //Language selection  info
            Text {
                id:languageSelectedInfo2
                text:"Language selected is English"
                font.family: "Arial Rounded MT Bold"
                font.pointSize: 16
                anchors.top: languageGrid2.bottom
                anchors.topMargin: 40

                x:180
                y:220

            }



        }
    }


    //This rectangle contains information about todays weather
    Rectangle {
        id: todayRect
        width: root.width/4
        height: 225
        anchors.bottom: forecastRectangle.top
        anchors.top: secondRow.bottom
        color:"transparent"
        opacity: 0
        //border.color: "red"
        x:2000

        //Animation information for this rectangle
        ParallelAnimation {
            id:todayRectAnimate
            running: false
            NumberAnimation { target:todayRect; property: "opacity"; to:1; duration: 2000 }
            NumberAnimation { target: todayRect; property: "x"; to:0; duration: 1000 }
        }

        //Background image for rectangle
        Image {
            id: todayRectBackground
            source: "whiteBack.png"
            anchors.fill: parent
            smooth: true
            opacity: 0.15
        }

        //Icon image for todays weather
        Image {
            id:todaysIcon
            source:"Real/100.png"
            height: parent.height - 50
            width: parent.width/2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 25
            smooth: true
        }

        //Weather desc for today
        Text {
            id:todayTag
            text:"Today"
            font.family: "Arial Rounded MT Bold"
            font.italic: true
            width: todaysIcon.width
            x: 25
            y: 10
            anchors.bottom: todaysIcon.top
            anchors.topMargin: 10
            font.pointSize: 12
            color: "#020203"
        }


        //rectangle to show todays temp
        Rectangle {
            id:todaysTempRect
            width: parent.width - 1030
            height: parent.height
            anchors.left: todaysIcon.right
            anchors.bottom: todayRect.bottom
            color: "transparent"

            //todays temp info text
            Text {
                id:todayTempText
                text:"unknown"
                font.family: "Arial Rounded MT Bold"
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.pointSize: 12
                anchors.margins: 5
                color:"#020203"

            }

        }
    }


    //Rectangle for containing forecast values
    Rectangle {
        id:forecastRectangle
        anchors.bottom: root.bottom
        width: root.width
        height: 200
        color:"transparent"
        x:-2000
        opacity: 0

        //Animating forecast rectangle
        ParallelAnimation {
            id: forecastRectangleAnimate
            running: false
            NumberAnimation { target:forecastRectangle; property: "opacity"; to:1; duration: 2000 }
            NumberAnimation { target:forecastRectangle; property: "x"; to:0; duration: 1000 }

        }

        //Row to arrange forecast date rectangles in sequence
        Row {
            id:dateRow
            property int fontSize: 12
            property string colorText: "#020203"

            //tomorrow rectangle
            Rectangle
            {
                id:nextDay1
                height: (root.height/16)
                width: (root.width/4)
                color: "transparent"

                //backgroung image
                Image {
                    id: nextDay1Image
                    source: "whiteBack.png"
                    anchors.fill: nextDay1
                    opacity: 0.2
                }


                Text {
                    id:nextDate1
                    text: "Tomorrow"
                    font.family: "Arial Rounded MT Bold"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: dateRow.fontSize
                    color: dateRow.colorText


                }
            }

            //day after tomorrow rect
            Rectangle
            {
                id:nextDay2
                height: (root.height/16)
                width: (root.width/4)
                color: "transparent"

                //Background image
                Image {
                    id: nextDay2Image
                    source: "whiteBack.png"
                    anchors.fill: nextDay2
                    opacity: 0.2

                }

                Text {
                    id:nextDate2
                    text: "Tomorrow"
                    font.family: "Arial Rounded MT Bold"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: dateRow.fontSize
                    color: dateRow.colorText
                }
            }

            //next day forecast
            Rectangle
            {
                id:nextDay3
                height: (root.height/16)
                width: (root.width/4)
                color: "transparent"

                //background
                Image {
                    id: nextDay3Image
                    source: "whiteBack.png"
                    anchors.fill: nextDay3
                    opacity: 0.3

                }

                Text {
                    id:nextDate3
                    text: "Tomorrow"
                    font.family: "Arial Rounded MT Bold"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: dateRow.fontSize
                    color: dateRow.colorText
                }
            }

            //next day forecast
            Rectangle
            {
                id:nextDay4
                height: (root.height/16)
                width: (root.width/4)
                color: "transparent"

                //background
                Image {
                    id: nextDay4Image
                    source: "whiteBack.png"
                    anchors.fill: nextDay4
                    opacity: 0.3

                }

                Text {
                    id:nextDate4
                    text: "Tomorrow"
                    font.family: "Arial Rounded MT Bold"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: dateRow.fontSize
                    color: dateRow.colorText
                }
            }

        }

        //row to arrange forecast data rectangles in sequence
        Row {
            id:foreCastData
            anchors.bottom: forecastRectangle.bottom
            property int fontSize: 12

            //For forecast data
            Rectangle {
                id:data1
                height: 150
                width: (root.width/4)
                color:"transparent"

                //background
                Image {
                    id: data1Back
                    source: "whiteBack.png"
                    anchors.fill: data1
                    anchors.top: parent.top
                    smooth: true
                    opacity: 0.2
                }

                //icon
                Image {
                    id:image1
                    width:100
                    height: 100
                    source:"Real/100.png"
                    anchors.top: parent.top
                }

                //Weather Description
                Text {
                    id:weatherDesc1
                    width: 100
                    height: 50
                    x:20
                    y:100
                    text:"Weather Condition 1"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: foreCastData.fontSize
                    color: "#020203"
                }

                //Weather details
                Rectangle {
                    id:data1Details
                    //border.color: "yellow"
                    anchors.right: parent.right
                    width: 220
                    height: 150
                    color: "transparent"

                    Text {
                        id:temp1
                        text:"Minimum: XX C"
                        font.family: "Arial Rounded MT Bold"
                        font.pointSize: foreCastData.fontSize
                        color: "#020203"
                        anchors.fill: parent
                        anchors.topMargin: 30
                        anchors.leftMargin: 10

                    }
                }

            }

            //For forecast data 2
            Rectangle {
                id:data2
                height: 150
                width: (root.width/4)
                //border.color: "blue"
                color:"transparent"

                //background
                Image {
                    id: data2Back
                    source: "whiteBack.png"
                    anchors.fill: data2
                    anchors.top: parent.top
                    smooth: true
                    opacity: 0.3
                }

                //icon
                Image {
                    id:image2
                    width:100
                    height: 100
                    source:"Real/100.png"
                    anchors.top: parent.top
                }

                //weather description
                Text {
                    id:weatherDesc2
                    width: 100
                    height: 50
                    x:20
                    y:100
                    text:"Weather Condition 1"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: foreCastData.fontSize
                    color: "#020203"
                }

                //weather details
                Rectangle {
                    id:data2Details
                    anchors.right: parent.right
                    width: 220
                    height: 150
                    color: "transparent"

                    Text {
                        id:temp2
                        text:"Minimum: XX C"
                        font.family: "Arial Rounded MT Bold"
                        font.pointSize: foreCastData.fontSize
                        //anchors.left: image1.right
                        color: "#020203"
                        anchors.fill: parent
                        anchors.topMargin: 30
                        anchors.leftMargin: 10

                    }
                }

            }

            //For forecast data 3
            Rectangle {
                id:data3
                height: 150
                width: (root.width/4)
                //border.color: "blue"
                color:"transparent"

                //background
                Image {
                    id: data3Back
                    source: "whiteBack.png"
                    anchors.fill: data3
                    anchors.top: parent.top
                    smooth: true
                    opacity: 0.3
                }

                //icon
                Image {
                    id:image3
                    width:100
                    height: 100
                    source:"Real/100.png"
                    anchors.top: parent.top
                }

                //weather description
                Text {
                    id:weatherDesc3
                    width: 100
                    height: 50
                    x:20
                    y:100
                    text:"Weather Condition 1"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: foreCastData.fontSize
                    color: "#020203"
                }

                //weather details
                Rectangle {
                    id:data3Details
                    //border.color: "yellow"
                    anchors.right: parent.right
                    width: 220
                    height: 150
                    color: "transparent"

                    Text {
                        id:temp3
                        text:"Minimum: XX C"
                        font.family: "Arial Rounded MT Bold"
                        font.pointSize: foreCastData.fontSize
                        color: "#020203"
                        anchors.fill: parent
                        anchors.topMargin: 30
                        anchors.leftMargin: 10

                    }
                }

            }

            //Forecast values
            Rectangle {
                id:data4
                height: 150
                width: (root.width/4)
                //border.color: "blue"
                color:"transparent"

                //background
                Image {
                    id: data4Back
                    source: "whiteBack.png"
                    anchors.fill: data4
                    anchors.top: parent.top
                    smooth: true
                    opacity: 0.3
                }

                //icon
                Image {
                    id:image4
                    width:100
                    height: 100
                    source:"Real/100.png"
                    anchors.top: parent.top
                }


                //weather description
                Text {
                    id:weatherDesc4
                    width: 100
                    height: 50
                    x:20
                    y:100
                    text:"Weather Condition 1"
                    font.family: "Arial Rounded MT Bold"
                    font.pointSize: foreCastData.fontSize
                    color: "#020203"
                }

                //Weather details
                Rectangle {
                    id:data4Details
                    //border.color: "yellow"
                    anchors.right: parent.right
                    width: 220
                    height: 150
                    color: "transparent"

                    Text {
                        id:temp4
                        text:"Minimum: XX C"
                        font.family: "Arial Rounded MT Bold"
                        font.pointSize: foreCastData.fontSize
                        //anchors.left: image1.right
                        color: "#020203"
                        anchors.fill: parent
                        anchors.topMargin: 30
                        anchors.leftMargin: 10

                    }
                }

            }
        }
    }



}
