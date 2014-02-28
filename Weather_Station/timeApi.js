var todayDateTimeDetails;
var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
var daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];

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
    doc.open("GET", "http://www.worldweatheronline.com/feed/tz.ashx?q="+root.city+"&format=json&key=3b28da0d40173746130202");
    doc.send();
    console.log("Sent")
    
}


function loadedtime(jsonObject) {

    //console.log(jsonObject.data.time_zone[0].localtime)
    todayDateTimeDetails = jsonObject.data.time_zone[0].localtime
    console.log("I GOT THE DATE "+ todayDateTimeDetails)

    var year = todayDateTimeDetails.slice(0,4);
    var month = todayDateTimeDetails.slice(5,7);
    var day = todayDateTimeDetails.slice(8,10);
    var hours = todayDateTimeDetails.slice(11,13);
    var minutes = todayDateTimeDetails.slice(14,16);

    var todaysDate = new Date(year+","+month+","+day);
    var dayOfTheWeek = todaysDate.getDay();

    month = months[month-1];
    dayOfTheWeek = daysOfWeek[dayOfTheWeek];

    var am_pm = "PM"

    var flagTime = true

    if(hours == 0)
    {
        hours = 12;
        am_pm = "AM"
        flagTime = false

    }

    if((hours >= 12) & (flagTime == true))
    {

        hours = hours - 12;
        //console.log(hours+"*************************************")
        am_pm = "PM"
        if(hours == 0)
        {
            hours = 12;
        }
    }

    if((hours >= 6)&(am_pm == "PM") | (hours <=6) & (am_pm == "AM"))
    {
        root.day_night = "Night"
        //console.log("Night Set**************************************************")
    }

    var finalTime = hours+":"+minutes+" "+am_pm;
    timeTextBox.text = finalTime;

    var finalDate = dayOfTheWeek+", "+month+" "+day+", "+year;
    dateText.text = finalDate;
     console.log("I GOT THE "+finalDate);



}
