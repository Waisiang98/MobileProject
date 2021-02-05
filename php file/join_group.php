<?php
include_once("db_connect.php");
$password=sha1($_POST['password']);

$sqlchoose = "SELECT * FROM LOCATIONGROUP WHERE JOINPASSWORD = '$password'";

$result = $conn->query($sqlchoose);
if ($result->num_rows > 0){
        echo "success";
}
else{
    echo "failed";
}
?>