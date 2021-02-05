<?php
error_reporting(0);
include_once("db_connect.php");
$email = $_POST['email'];

$sql = "SELECT NAME,USERNAME,IMAGENAME,EMAIL,PASSWORD FROM USER WHERE EMAIL = '$email'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["user"] = array();
    while ($row = $result ->fetch_assoc()){
        $userlist = array();
        $userlist[name] = $row["NAME"];
        $userlist[username] = $row["USERNAME"];
        $userlist[userimage] = $row["IMAGENAME"];
        $userlist[email] = $row["EMAIL"];
        $userlist[password] = $row["PASSWORD"];
        array_push($response["user"], $userlist);
    }
    echo json_encode($response);
}

else{
    echo "nodata";
}

?>