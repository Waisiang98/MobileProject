<?php
include_once("db_connect.php");
$username=$_POST['username'];
$password=sha1($_POST['password']);


$sqllogin = "SELECT * FROM USER WHERE USERNAME = '$username' AND PASSWORD = '$password'";
$result = $conn->query($sqllogin);

if ($result-> num_rows>0){
    while ($row = $result -> fetch_assoc()){
        
        echo $data = "success,".$row["EMAIL"].",".$row["NAME"].",".$row["USERNAME"].",".$row["PASSWORD"].",".$row["IMAGENAME"];
    }
}

else {
    echo "failed";
}
?>