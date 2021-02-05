<?php
error_reporting(0);
include_once("db_connect.php");
$email = $_POST['email'];



$sql = "SELECT USERNAME, EMAIL FROM USER WHERE EMAIL = '$email'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["adduser"] = array();
    while ($row = $result ->fetch_assoc()){
        $adduserlist = array();
        $adduserlist[username] = $row["USERNAME"];
        $adduserlist[useremail] = $row["EMAIL"];
        array_push($response["adduser"], $adduserlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>