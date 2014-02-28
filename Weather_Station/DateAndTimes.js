function getDate() {

    var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]

    var today = new Date();

    var day = today.getDate()
    var month= today.getMonth()
    var year = today.getFullYear()
    var monthText = months[month]

    var fullDate= day+" "+monthText+", "+year

    console.log(fullDate)
    console.log(day);


    var minutes = today.getMinutes()
    var hours = today.getHours()
    var am_pm = "am"

    if(hours > 12)
    {
        hours = hours - 12;
        if(minutes > 0)
        {
            am_pm = "pm"
        }
    }

    if(hours == 0)
    {
        hours = 12;
        am_pm = "am"

    }


    var timeText = hours+":"+minutes+" "+am_pm;
    console.log(timeText+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    
}
