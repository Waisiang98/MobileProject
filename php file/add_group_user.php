<?php
include_once("db_connect.php");
$email=$_POST["email"];
$username=$_POST["username"];
$groupid=$_POST["groupid"];
$groupimage=$_POST["groupimage"];
$password=$_POST["password"];
$groupname=$_POST["groupname"];

$sqlregister = "INSERT INTO LOCATIONGROUP (EMAIL,GROUPID,USERNAME,GROUPNAME,JOINPASSWORD,GROUPIMAGE) VALUES ('$email','$groupid','$username','$groupname','$password','$groupimage')";

if($conn->query($sqlregister)===TRUE){
    echo"success";
}else{
    echo"failed";
}
?>