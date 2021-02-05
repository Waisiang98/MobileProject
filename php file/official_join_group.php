<?php
error_reporting(0);
include_once("db_connect.php");
$username = $_POST['username'];
$email = $_POST['email'];
$password=sha1($_POST['password']);
$groupname = $_POST['groupname'];
$groupid = $_POST['groupid'];
$groupimage = $_POST['groupimage'];

$sqlregister = "INSERT INTO LOCATIONGROUP (GROUPNAME,USERNAME,EMAIL,GROUPID,JOINPASSWORD,GROUPIMAGE) VALUES ('$groupname','$username','$email','$groupid','$password','$groupimage')";
                if($conn->query($sqlregister)===TRUE){
                    echo"success";}
                    
                    else{
                         echo "failed";
                    }


?>