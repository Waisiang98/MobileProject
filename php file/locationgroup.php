<?php
include_once("db_connect.php");
$username=$_POST['username'];
$groupname=$_POST['groupname'];
$groupid=$_POST['groupid'];
$email=$_POST['email'];
$joinpassword=sha1($_POST['joinpassword']);
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$imagename=$_POST['imagename'];
$path='../images/groupimages/'.$imagename.'.jpg';
$is_written = file_put_contents($path,$decoded_string);

$sqlgroupidcheck = "SELECT * FROM LOCATIONGROUP WHERE GROUPID='$groupid'";
$resultidcheck = $conn->query($sqlrestidcheck);

if ($is_written > 0){
        if($resultidcheck->num_rows>0){
            while($row = $resultidcheck -> fetch_assoc()){
                if($row["GROUPID"]==$groupid){
                     echo "Group Existed";
        }
    }
        }
        else {
            $sqlregister = "INSERT INTO LOCATIONGROUP (GROUPNAME,USERNAME,EMAIL,GROUPID,JOINPASSWORD,GROUPIMAGE) VALUES ('$groupname','$username','$email','$groupid','$joinpassword','$imagename')";
                if($conn->query($sqlregister)===TRUE){
                    echo"success";}
                    
                    else{
                         echo "failed";
                    }
    
        }
}
?>