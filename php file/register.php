<?php
include_once("db_connect.php");
$name=$_POST['name'];
$username=$_POST['username'];
$email=$_POST['email'];
$password=sha1($_POST['password']);
$otp=rand(0000,9999);


$sqlregister = "INSERT INTO USER (NAME,USERNAME,EMAIL,PASSWORD,OTP) VALUES ('$name','$username','$email','$password','$otp')";

if($conn->query($sqlregister)===TRUE){
    sendEmail($otp,$email);
    echo"success";
}else{
    echo"failed";
}

function sendEmail($otp,$email){
    $from ="noreply@findme.com";
    $subject = "From Find Me. Verify your account";
    $message = "Use the following link to verify your password:". "http://wxxsspecial983.com/findme/php/verify_user.php?email=".$email."&key=".$otp;
    $headers="From:".$from;
    mail($email,$subject,$message,$headers);
}
?>