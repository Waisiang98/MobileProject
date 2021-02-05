<?php
error_reporting(0);
include_once("db_connect.php");
$username = $_POST['username'];
$email = $_POST['email'];
$groupid = $_POST['groupid'];

$sql = "SELECT * FROM LOCATIONGROUP WHERE EMAIL = '$email'AND USERNAME = '$username' AND GROUPID = '$groupid'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "success";
}
else{
    echo "nodata";
}

?>