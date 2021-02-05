<?php
include_once("db_connect.php");
$username=$_POST['username'];
$password=$_POST['password'];
$latitude=$_POST['latitude'];
$longitude=$_POST['longitude'];
$address=$_POST['address'];

$sqlupdate = "UPDATE USER SET LATITUDE = '$latitude' , LONGITUDE = '$longitude' , ADDRESS = '$address' WHERE USERNAME = '$username' AND PASSWORD = '$password'";

if ($conn->query($sqlupdate) === TRUE){
       echo "success";
     
 }



?>