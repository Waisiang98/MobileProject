<?php
$servername ="localhost";
$username   ="wxxsspec_findmeadmin";
$password   ="x4{4y^=LKV5[";
$dbname     ="wxxsspec_findme";

$conn = new mysqli($servername, $username, $password, $dbname);
if($conn->connect_error){
    die("Connection failed:" .$conn->connect_error );
}
?>