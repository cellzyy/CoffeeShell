<?php
// A more secure way to change the daily message with admin login
// TODO: finish logins

$adminPassword = "adminPassword123";
$adminUserKey = "administrator";
$adminLoggedIn = false;

date_default_timezone_set("America/Chicago");

$logins = array(
    "administrator" => "adminPassword123"
);

if (isset($_POST["user"]) & isset($_POST["pass"])) {
    $user = filter_input(INPUT_POST,"user", FILTER_SANITIZE_STRING);
    $pass = filter_input(INPUT_POST,"pass", FILTER_SANITIZE_STRING);

    if ($user === $adminUserKey & $pass === $adminPassword) {
        $adminLoggedIn = true;
    } else {
        header("Location: index.html?Fail");
        exit;
    }
} else {
    header("Location: index.html?Fail");
    exit;
}

if (isset($_POST["sub"]) & isset($_POST["msg"]) & $adminLoggedIn === true) {
    $msg = filter_input(INPUT_POST,"msg", FILTER_SANITIZE_STRING);
    $json = json_decode(file_get_contents("dailyMessage.json"), true);
    if ($json["changesLeftToday"] === 0) {
        die("The website has ran out of changes for today.");
    } else {
        $json["dailyMessage"] = $msg;
        $json["lastDailyMessageChange"] = date("h:i a");
        $json["lastChangeUser"] = filter_input(INPUT_POST,"user", FILTER_SANITIZE_STRING);
        $json["changesLeftToday"] = 1;
        file_put_contents("dailyMessage.json", json_encode($json));
    }
    header("Location: index.html?DailyChange");
    exit;
} else {
    header("index.html?Fail");
    exit;
}

?>