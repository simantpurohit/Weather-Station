var w_code;
var x = false;
var weatherDescription = "unknown";
var humidiy = "unknown"
var clouds = "unknown"
var precipitation = "unknown"
var pressure = "unknown"
var windDirection16pt = "unknown"
var visibility = "unknown"
var location = "unknown"
var windDegreesSingle = 0
var windDirection = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
var windDegrees = ["0","22.5","45","67.5","90","112.5","135","157.5","180","202.5","225","247.5","270","292.5","315","337.5","360"]
var windSpeedValue = 0
var windDegreeValue = 0
var tempScaleFlag = "F";
var dayNightToggle = "AM";
var todayDateTimeDetails;
var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
var monthsSpanish = ["Enero","Febrero","Marzo","Abril","Mayo","​​Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]

var daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
var daysOfWeekSpanish = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves","Viernes", "Sábado"]
var fadeCount = 0;

var am_pm = "AM";
var language = "English"

var weatherCondition= new Array();
var minimumTemp = new Array();
var maximumTemp = new Array();
var weatherCodeForecast = new Array()
var precip = new Array()

//function showRequestInfo(text) {
//    weatherInfo.text = weatherInfo.text + "\n" + text
//    console.log(text)
//}


//Function to send weather request to the server
function sendRequest(city) {

    var doc = new XMLHttpRequest();
    console.log("sending")
    doc.onreadystatechange = function() {
       if (doc.readyState == XMLHttpRequest.DONE) {
           var jsonObject = eval('(' + doc.responseText + ')');
           console.log("return jason")
           loaded(jsonObject);
           setForecastDates(jsonObject);
           setForecastValues(jsonObject);
        }
    }
    // Replace YOURPRIVATEKEY by your key from free.worldweatheronline.com
    //doc.open("GET", "http://free.worldweatheronline.com/feed/weather.ashx?q=" + city + "&format=json&num_of_days=5&key=3b28da0d40173746130202");
    doc.open("GET","http://api.worldweatheronline.com/free/v1/weather.ashx?q=" + city + "&format=json&num_of_days=5&key=xmhcht3smtakvuu9p3z5nnsp")
    doc.send();
    console.log("Sent")
    fadeCount = 0;

}

//Function to set the weather details by using the received values
function loaded(jsonObject) {

    w_code=("weatherCode:" + jsonObject.data.current_condition[0].weatherCode);
    w_code= w_code.slice(12);

    getTime();

    clouds = (jsonObject.data.current_condition[0].cloudcover);
    cloudsDesc.text = "Cloud Cover: "+clouds+"%"

    humidiy = (jsonObject.data.current_condition[0].humidity);
    humidityDesc.text = "Humidity: "+humidiy+"%";

    precipitation = (jsonObject.data.current_condition[0].precipMM);
    precipDesc.text = "Precipitation: "+precipitation+"%";


    if(tempScaleFlag == "C")
    {
        var temp_c = (jsonObject.data.current_condition[0].temp_C);
        tempText.text = temp_c+(Control.getDegree())+tempScaleFlag;

        windSpeedValue = (jsonObject.data.current_condition[0].windspeedKmph);
        windspeed.text = "Speed: "+windSpeedValue+" kmph";

        visibility = (jsonObject.data.current_condition[0].visibility);
        visibilityDesc.text = "Visibility: "+visibility+" Km"


        if (language == "Spanish")
        {
            windspeed.text = "Acelerar: "+windSpeedValue+" kmph";
            visibilityDesc.text = "Visibilidad: "+visibility+" Km"

        }
    }

    if(tempScaleFlag == "F")
    {
        var temp_f = (jsonObject.data.current_condition[0].temp_F);
        tempText.text = temp_f+(Control.getDegree())+tempScaleFlag;

        windSpeedValue = (jsonObject.data.current_condition[0].windspeedMiles);
        windspeed.text = "Speed: "+windSpeedValue+" mph";

        visibility = (jsonObject.data.current_condition[0].visibility);
        visibilityDesc.text = "Visibility: "+visibility+" Miles"


        if (language == "Spanish")
        {
            windspeed.text = "Acelerar: "+windSpeedValue+" mph";
            visibilityDesc.text = "Visibilidad: "+visibility+" Miles"

        }
    }

    weatherDescription = (jsonObject.data.current_condition[0].weatherDesc[0].value);

    windDirection16pt = (jsonObject.data.current_condition[0].winddir16Point);
    rotationControl()

    windDegreeValue = (jsonObject.data.current_condition[0].winddirDegree);
    windDegreesText.text = "Degrees: "+windDegreeValue+String.fromCharCode(176);

    location = (jsonObject.data.request[0].query);
    cityDescription.text = location

    console.log(w_code);

    setSpanish();

    if(language == "English")
        weatherDesc.text = "Condition: "+weatherDescription;

}

//Function to start the fading animation for the background image
function fadeImage(imageCode) {

    if(dayNightToggle == "AM") {
        console.log("SETTING IMAGE FOR DAY!!!!!!")
        if(root.back1 == 1)
        {
            background2.source = "Images/"+imageCode+".png";
            if(background2.status == Image.Ready)
                x=true;

            else
                x=false;

            if (x == false)
            {
                background2.source = "100.png";
                x=true;
            }

            //hideContainer2.start();
            hideBackground.start();
            showBackground2.start();
            root.back1=0
            root.back2=1

        }

        else
        {
            background.source = "Images/"+imageCode+".png";

            if(background.status == Image.Ready)
                x=true;

            else
                x=false;

            if (x == false)
            {
                background.source = "100.png";
                x=true;
            }
            hideBackground2.start();
            showBackground.start();
            root.back1=1
            root.back2=0

        }

        }

    else {

        console.log("SETTING IMAGE FOR NIGHT!!!!!!")

        if(root.back1 == 1)
        {
            background2.source = "Images/Night/"+imageCode+".png";
            if(background2.status == Image.Ready)
                x=true;

            else
                x=false;

            if (x == false)
            {
                background2.source = "100.png";
                x=true;
            }

            hideBackground.start();
            showBackground2.start();
            root.back1=0
            root.back2=1

        }

        else
        {
            background.source = "Images/Night/"+imageCode+".png";

            if(background.status == Image.Ready)
                x=true;

            else
                x=false;

            if (x == false)
            {
                background.source = "100.png";
                x=true;
            }
            hideBackground2.start();
            showBackground.start();
            root.back1=1
            root.back2=0

        }


    }


    timeChangeTimer.start()

}

//Function to set the settings screen background
function setOptionImage() {

    console.log("I AM IN HERE")
    if(root.back1 == 1)
    {
        background2.source = "default.jpg";
        hideBackground.start();
        showBackground2.start();
        root.back1=0
        root.back2=1

    }

    else
    {
        background.source = "default.jpg";
        hideBackground2.start();
        showBackground.start();
        root.back1=1
        root.back2=0

    }

}

//Function to reset the background image when returning from options screen
function backFromOptions() {
    root.back1 = 1;
    root.back2 = 0;

    sendRequest(root.city)
}

//Function to rotate the windspeed arrow
function rotationControl() {


    for(var i =0; i<=16;i++)
    {
        if(windDirection16pt == windDirection[i])
        {
            windDegreesSingle = windDegrees[i];
            console.log("Wind Degrees:"+windDegreesSingle)
            break;
        }
    }

    if(innerRight.toggleValue == 0)
    {
        console.log("Inside Rotate If")
        arrow.rotationAngle = windDegreesSingle
        arrow.z = 10
        arrow2.z = 0
//        arrow.visible = true
//        arrow2.visible = false
        arrow.state = "rotated"
        arrow2.state = ""
        arrow2.rotation = arrow.rotationAngle
        innerRight.toggleValue = 1;
    }

    else
    {
        console.log("Inside Rotate Else")
        arrow2.rotationAngle2 = windDegreesSingle
        arrow.z = 0
        arrow2.z = 10

//        arrow.visible = false
//        arrow2.visible = true

        arrow2.state = "rotated"
        arrow.state = ""
        arrow.rotation = arrow2.rotationAngle2
        innerRight.toggleValue = 0

    }


}

//Function to set forecast dates
function setForecastDates(jsonObject) {

    //var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    var daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];

    var futureDays = new Array();
    var year = new Array();
    var month = new Array();
    var date = new Array();
    var day = new Array();

    for(var i=0;i<5;i++)
    {
        console.log("Calling Date For Loop")
        futureDays[i]=(jsonObject.data.weather[i].date);

        year[i] = futureDays[i].slice(0,4);
        console.log(year[i])

        month[i] = (futureDays[i].slice(5,7)) - 1;
        console.log(month[i])



        date[i] = futureDays[i].slice(8,10);
        console.log(date[i]);

        var thisDate = year
        var current = new Date(year[i],month[i],date[i])

        day[i] = current.getDay();


        if(language == "Spanish")
        {
            month[i] = monthsSpanish[month[i]];
            day[i] = daysOfWeekSpanish[day[i]];
            console.log("MONTH IN SPANISH:"+ month[i]);
        }

        else
        {
            month[i] = months[month[i]];
            day[i] = daysOfWeek[day[i]];
        }

        console.log(day[i]);
    }

    nextDate1.text = day[1]+","+"\n"+month[1]+" "+date[1]+", "+year[1];
    nextDate2.text = day[2]+","+"\n"+month[2]+" "+date[2]+", "+year[2];
    nextDate3.text = day[3]+","+"\n"+month[3]+" "+date[3]+", "+year[3];
    nextDate4.text = day[4]+","+"\n"+month[4]+" "+date[4]+", "+year[4];

}

//Function to set forecast values text fields
function setForecastValues(jsonObject) {


    for(var i=0; i<5; i++)
    {
        weatherCondition[i] = (jsonObject.data.weather[i].weatherDesc[0].value)
        weatherCodeForecast[i] = (jsonObject.data.weather[i].weatherCode)

        if(weatherCondition[i] == "Sunny")
            weatherCondition[i] = "Clear"

        console.log(weatherCodeForecast[i]+"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

        precip[i] = (jsonObject.data.weather[0].precipMM)


        if(tempScaleFlag == "C")
        {
            minimumTemp[i] = (jsonObject.data.weather[i].tempMinC);
            maximumTemp[i] = (jsonObject.data.weather[i].tempMaxC);
        }
        else
        {
            minimumTemp[i] = (jsonObject.data.weather[i].tempMinF);
            maximumTemp[i] = (jsonObject.data.weather[i].tempMaxF);
        }
    }

    weatherDesc1.text = weatherCondition[1];
    weatherDesc2.text = weatherCondition[2];
    weatherDesc3.text = weatherCondition[3];
    weatherDesc4.text = weatherCondition[4];

    temp1.text = "Min: "+minimumTemp[1]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Max: "+maximumTemp[1]+String.fromCharCode(176)+tempScaleFlag;
    temp2.text = "Min: "+minimumTemp[2]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Max: "+maximumTemp[2]+String.fromCharCode(176)+tempScaleFlag;
    temp3.text = "Min: "+minimumTemp[3]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Max: "+maximumTemp[3]+String.fromCharCode(176)+tempScaleFlag;
    temp4.text = "Min: "+minimumTemp[4]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Max: "+maximumTemp[4]+String.fromCharCode(176)+tempScaleFlag;


    todayTempText.text = "";
    todayTempText.text ="Min: "+minimumTemp[0]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Max: "+maximumTemp[1]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Precipitation: "+precip[0]+" %";
    todayTag.text = "Today: "+ weatherCondition[0];



    indoorConditionsText.text = "Your Indoor Conditions\n\nTemperature: 68"+String.fromCharCode(176)+tempScaleFlag+"\nHumidity: 30%"

    if(language == "Spanish")
    {
        weatherDesc1.text = weatherCondition[1];

        if(weatherDesc1.text == "Cloudy")
            weatherDesc1.text = "Nublado"

        if(weatherDesc1.text == "Sunny")
            weatherDesc1.text = "Soleado"

        if(weatherDesc1.text == "Clear")
            weatherDesc1.text = "Claro"

        if(weatherDesc1.text == "Overcast")
            weatherDesc1.text = "Cubierto"

        if(weatherDesc1.text == "Partly Cloudy")
            weatherDesc1.text = "Mayormente nublado"


        weatherDesc2.text = weatherCondition[2];

        if(weatherDesc2.text == "Cloudy")
            weatherDesc2.text = "Nublado"

        if(weatherDesc2.text == "Sunny")
            weatherDesc2.text = "Soleado"

        if(weatherDesc2.text == "Clear")
            weatherDesc2.text = "Claro"

        if(weatherDesc2.text == "Overcast")
            weatherDesc2.text = "Cubierto"

        if(weatherDesc2.text == "Partly Cloudy")
            weatherDesc2.text = "Mayormente nublado"

        weatherDesc3.text = weatherCondition[3];

        if(weatherDesc3.text == "Cloudy")
            weatherDesc3.text = "Nublado"

        if(weatherDesc3.text == "Sunny")
            weatherDesc3.text = "Soleado"

        if(weatherDesc3.text == "Clear")
            weatherDesc3.text = "Claro"

        if(weatherDesc3.text == "Overcast")
            weatherDesc3.text = "Cubierto"

        if(weatherDesc3.text == "Partly Cloudy")
            weatherDesc3.text = "Mayormente nublado"

        weatherDesc4.text = weatherCondition[4];

        if(weatherDesc4.text == "Cloudy")
            weatherDesc4.text = "Nublado"

        if(weatherDesc4.text == "Sunny")
            weatherDesc4.text = "Soleado"

        if(weatherDesc4.text == "Clear")
            weatherDesc4.text = "Claro"

        if(weatherDesc4.text == "Overcast")
            weatherDesc4.text = "Cubierto"

        if(weatherDesc4.text == "Partly Cloudy")
            weatherDesc4.text = "Mayormente nublado"

        temp1.text = "Mínimo: "+minimumTemp[1]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Máximo: "+maximumTemp[1]+String.fromCharCode(176)+tempScaleFlag;
        temp2.text = "Mínimo: "+minimumTemp[2]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Máximo: "+maximumTemp[2]+String.fromCharCode(176)+tempScaleFlag;
        temp3.text = "Mínimo: "+minimumTemp[3]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Máximo: "+maximumTemp[3]+String.fromCharCode(176)+tempScaleFlag;
        temp4.text = "Mínimo: "+minimumTemp[4]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Máximo: "+maximumTemp[4]+String.fromCharCode(176)+tempScaleFlag;


        todayTempText.text = "";
        todayTempText.text ="Mínimo: "+minimumTemp[0]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Máximo: "+maximumTemp[1]+String.fromCharCode(176)+tempScaleFlag+"\n"+"Precipitación: "+precip[0]+" %";

        if(weatherCondition[0] == "Cloudy")
            weatherCondition[0] = "Nublado"

        if(weatherCondition[0] == "Sunny")
            weatherCondition[0] = "Soleado"

        if(weatherCondition[0] == "Clear")
            weatherCondition[0] = "Claro"

        if(weatherCondition[0] == "Overcast")
            weatherCondition[0] = "Cubierto"

        if(weatherCondition[0] == "Partly Cloudy")
            weatherCondition[0] = "Mayormente nublado"



        todayTag.text = "Hoy: "+ weatherCondition[0];

        todaysIcon.source = "Real/"+weatherCodeForecast[0]+".png";
        image1.source = "Real/"+weatherCodeForecast[1]+".png";
        image2.source = "Real/"+weatherCodeForecast[2]+".png";
        image3.source = "Real/"+weatherCodeForecast[3]+".png";
        image4.source = "Real/"+weatherCodeForecast[4]+".png";

        indoorConditionsText.text = "Sus condiciones de interior\n\nTemperatura: 68"+String.fromCharCode(176)+tempScaleFlag+"\nHumedad: 30%"
    }

}

//Function to request time from the server using the Time API from worldweatheronline.com
function getTime() {

    var doc = new XMLHttpRequest();
    console.log("sending time request")
    doc.onreadystatechange = function() {
       if (doc.readyState == XMLHttpRequest.DONE) {
           var jsonObject = eval('(' + doc.responseText + ')');
           console.log("return jason")
           loadedtime(jsonObject);
        }
    }
    // Replace YOURPRIVATEKEY by your key from free.worldweatheronline.com
    //doc.open("GET", "http://www.worldweatheronline.com/feed/tz.ashx?q="+root.city+"&format=json&key=3b28da0d40173746130202");
    doc.open("GET","http://api.worldweatheronline.com/free/v1/tz.ashx?q="+root.city+"&format=json&key=xmhcht3smtakvuu9p3z5nnsp")
    doc.send();
    console.log("Sent")

}

//function to set the time values on the screen
function loadedtime(jsonObject) {

    //console.log(jsonObject.data.time_zone[0].localtime)
    todayDateTimeDetails = jsonObject.data.time_zone[0].localtime
    console.log("I GOT THE DATE "+ todayDateTimeDetails)

    var year = todayDateTimeDetails.slice(0,4);
    var month = todayDateTimeDetails.slice(5,7);
    var day = todayDateTimeDetails.slice(8,10);
    var hours = todayDateTimeDetails.slice(11,13);
    var minutes = todayDateTimeDetails.slice(14,16);

    if(hours>=18)
    {
        console.log("SETTING TOGGLE TO NIGHT FOR HOUR "+hours)
        dayNightToggle = "PM"
    }

    if(hours<6)
    {
        console.log("SETTING TOGGLE TO NIGHT FOR HOUR "+hours)
        dayNightToggle = "PM"
    }

    if(hours>=6 & hours<18)
    {
        console.log("SETTING TOGGLE TO MORNING FOR HOUR "+hours)
        dayNightToggle = "AM"
    }

    if(hours>=12 & hours <= 23)
    {
         console.log("Setting PM!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        am_pm = "PM"
    }

    if(hours>=0 & hours<12)
    {
        console.log("Setting AM!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        am_pm = "AM"
    }

    if(fadeCount == 0)
    {
        fadeImage(w_code);
        fadeCount++;
    }

    var todaysDate = new Date(year+","+month+","+day);
    var dayOfTheWeek = todaysDate.getDay();

    if(language == "Spanish")
    {
        month = monthsSpanish[month-1];
        dayOfTheWeek = daysOfWeekSpanish[dayOfTheWeek];
    }

    else {

    month = months[month-1];
    dayOfTheWeek = daysOfWeek[dayOfTheWeek];

    }

    var flagTime = true


    if(hours == 0)
    {
        hours = 12;
        flagTime = false

    }


    if((hours >= 12) & (flagTime == true))
    {
        hours = hours - 12;
        console.log(hours+"*************************************");
        if(hours == 0)
        {
            hours = 12;
        }
    }


    var finalTime = hours+":"+minutes+" "+am_pm;
    timeTextBox.text = finalTime;

    var finalDate = dayOfTheWeek+","+month+" "+day+", "+year;
    dateText.text = finalDate;
     console.log("I GOT THE OTHER:"+finalTime);

    if(dayNightToggle == "AM")
    {
        console.log("Setting icons for the day")
        todaysIcon.source = "Real/"+weatherCodeForecast[0]+".png";
        image1.source = "Real/"+weatherCodeForecast[1]+".png";
        image2.source = "Real/"+weatherCodeForecast[2]+".png";
        image3.source = "Real/"+weatherCodeForecast[3]+".png";
        image4.source = "Real/"+weatherCodeForecast[4]+".png";
    }


    if (dayNightToggle == "PM")
    {
        console.log("Setting icons for the night")
        todaysIcon.source = "Real/Night/"+weatherCodeForecast[0]+".png";
        image1.source = "Real/Night/"+weatherCodeForecast[1]+".png";
        image2.source = "Real/Night/"+weatherCodeForecast[2]+".png";
        image3.source = "Real/Night/"+weatherCodeForecast[3]+".png";
        image4.source = "Real/Night/"+weatherCodeForecast[4]+".png";

    }



}

//function to toggle the units/scale of display
function toggleScaleText() {
    var toggle = false

    var metricText = "Note: Temperature will be shown in Celcius scale and Windspeed in Kilometers Per Hour"
    var metricTextSpanish = "Nota: La temperatura se mostrará en grados Celsius escala y velocidad del viento en kilómetros por hora"

    var imperialText = "Note: Temperature will be shown in Farenhite scale and Windspeed in Miles Per Hour"
    var imperialTextSpanish = "Nota: La temperatura se mostrará en grados Fahrenheit escala y velocidad del viento en millas por hora"

    if(language == "Spanish") {

        if(scaleInfo.text == "Escala Imperial seleccionado")
        {
            scaleInfo.text = "Escala métrica seleccionada"
            scaleDesc.text = metricTextSpanish
            scaleToggle.buttonText = "Cambiar la escala de Imperial"
            toggle = true;
            console.log("SETTING FLAG TO C")
            tempScaleFlag = "C";
        }


        if(toggle == false)
        {
            if(scaleInfo.text == "Escala métrica seleccionada")
            {
                scaleInfo.text = "Escala Imperial seleccionado"
                scaleDesc.text = imperialTextSpanish
                scaleToggle.buttonText = "Cambio escala a métrico"
                console.log("SETTING FLAG TO F")
                tempScaleFlag = "F";
            }

        }

    }

    else {


        if(scaleInfo.text == "Imperial Scale Selected")
        {
            scaleInfo.text = "Metric Scale Selected"
            scaleDesc.text = metricText
            scaleToggle.buttonText = "Change scale to Imperial";
            toggle = true;
            console.log("SETTING FLAG TO C")
            tempScaleFlag = "C";
        }

        if(toggle == false)
        {
            if(scaleInfo.text == "Metric Scale Selected")
            {
                scaleInfo.text = "Imperial Scale Selected"
                scaleDesc.text = imperialText
                scaleToggle.buttonText = "Change scale to Metric"

                console.log("SETTING FLAG TO F")
                tempScaleFlag = "F";
            }
        }

    }
}

//function to change the unit to metric
function changeToMetric() {

    tempScaleFlag = "C"

    if(language == "English")
    {
        scaleInfo.text = "Metric Scale Selected"
        scaleDesc.text = "Note: Temperature will be shown in Celcius scale and Windspeed in Kilometers Per Hour"

    }

    else {
        scaleInfo.text = "Escala métrica seleccionada"
        scaleDesc.text = "Nota: La temperatura se mostrará en grados Celsius escala y velocidad del viento en kilómetros por hora"
    }

}

//function to change the unit to imperial
function changeToImperial() {

    tempScaleFlag = "F"

    if(language == "English")
    {
        scaleInfo.text = "Imperial Scale Selected"
        scaleDesc.text = "Note: Temperature will be shown in Farhenite scale and Windspeed in Miles Per Hour"

    }

    else {
        scaleInfo.text = "Escala Imperial seleccionado"
        scaleDesc.text = "Nota: La temperatura se mostrará en grados Fahrenheit escala y velocidad del viento en millas por hora"
    }

}

//function to set text in the application to spanish
function setSpanish() {

    if(language == "Spanish")
    {
        weatherDescriptionSpanish();
        cloudsDesc.text = "Cobertura de nubes: "+clouds+"%";
        humidityDesc.text = "Humedad: "+humidiy+"%";
        precipDesc.text = "Precipitación: "+precipitation+"%";
        //pressureDesc.text = "Presión: "+pressure+" mb"
        weatherDesc.text = "Condición del: "+weatherDescription;
        currentConditions.text = "Condiciones actuales";

    }


}

//function to toggle language on the screen
function languageToggle() {

    if(language == "Spanish")
    {


        languageSelectedInfo.text = "Idioma seleccionado es el español"
        welcomeText.text = "Bienvenido a tu estación meteorológica!\n\nPor favor seleccione su idioma"

        scaleToggle.buttonText = "Imperiales"
        scaleToggleBack.buttonText = "Métrico"

        if (tempScaleFlag == "F") {

            scaleInfo.text = "Escala Imperial seleccionado";
            scaleDesc.text = "Nota: La temperatura se mostrará en grados Fahrenheit escala y velocidad del viento en millas por hora"

        }

        else {
            scaleInfo.text = "Escala métrica seleccionada"
            scaleDesc.text = "Nota: La temperatura se mostrará en grados Celsius escala y velocidad del viento en kilómetros por hora"

        }

        askForCity.text = "Ingrese su cuidad Abajo"
        toggleTempScale.text = "Por favor, seleccione Imperial / Métrico escala"
        showMeWeather.buttonText = "Muéstrame el tiempo"

        askForCity2.text = "Ingrese su cuidad Abajo"
        toggleTempScale2.text = "Por favor, seleccione Imperial / Métrico escala"
        showMeWeather2.buttonText = "Muéstrame el tiempo"
        languageSelectedInfo2.text = "Idioma seleccionado es el español"

        goToScaleSelection.buttonText = "Continuar"
        askForLanguage.text = "Favor elija su lenguaje"

        alertText.text = "No hay alertas en este momento"

    }


    else
    {
        languageSelectedInfo.text = "Language selected is English"
        welcomeText.text = "Welcome to your Weather Station! \n\n Please select your Language"

        askForCity.text = "Please Enter Your City Below";
        toggleTempScale.text = "Please select Imperial/Metric scale";

        scaleToggle.buttonText = "Imperial"
        scaleToggleBack.buttonText = "Metric"

        if (tempScaleFlag == "F")
        {
            scaleInfo.text = "Imperial Scale Selected"
            scaleDesc.text = "Note: Temperature will be shown in Farenhite scale and Windspeed in Miles Per Hour"
        }

        else {
            scaleInfo.text = "Metric Scale Selected"
            scaleDesc.text = "Note: Temperature will be shown in Celcius scale and Windspeed in Kilometers Per Hour"
        }

        showMeWeather.buttonText = "Show me the weather"

        askForCity2.text = "Please Enter Your City Below";
        toggleTempScale2.text = "Please select Imperial/Metric scale";
        showMeWeather2.buttonText = "Show me the weather"
        languageSelectedInfo2.text = "Language selected is English"


        goToScaleSelection.buttonText = "Continue"
        askForLanguage.text = "Please Select Your Language"

        currentConditions.text = "Current conditions";

        alertText.text = "No alerts right now"

    }

}

//function to set the weather description to spanish
function weatherDescriptionSpanish() {


    if(weatherDescription == "Cloudy")
        weatherDescription = "Nublado"

    if(weatherDescription == "Sunny")
        weatherDescription = "Soleado"

    if(weatherDescription == "Clear")
        weatherDescription = "Claro"

    if(weatherDescription == "Overcast")
        weatherDescription = "Cubierto"

    if(weatherDescription == "Partly Cloudy")
        weatherDescription = "Mayormente nublado"

}
