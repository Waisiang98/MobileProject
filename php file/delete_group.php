<?php
error_reporting(0);
include_once("db_connect.php");
$email=$_POST['email'];
$groupid=$_POST['groupid'];

$sqldelete="DELETE FROM LOCATIONGROUP WHERE EMAIL = '$email' AND GROUPID='$groupid'";
    if($conn->query($sqldelete)===TRUE){
        echo "success";
    }
    else{
        echo "failed";
    }
    
?>