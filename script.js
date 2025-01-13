var text = document.getElementById("loadtext");
var load1 = document.getElementById("load1");
var load2 = document.getElementById("load2");

setTimeout(function () {
    load1.remove();
    load2.remove();

    text.innerText = "Loaded!";

    fetch("load.html")
    .then(resp => resp.text())
    .then(html => {
        document.body.innerHTML = html;
    })
    .catch(err => {
        console.error(err);
    });

    setTimeout(function () {
        fetch("dailyMessage.json")
        .then(resp => resp.json())
        .then(daily => {
            document.getElementById("message").innerText = daily["dailyMessage"];
            document.getElementById("author").innerText = daily["lastChangeUser"] + " at " + daily["lastDailyMessageChange"];
            document.getElementById("load").innerText = "Daily Message";
        });
    }, 500);
}, 1000);