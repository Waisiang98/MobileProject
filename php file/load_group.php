<?php
error_reporting(0);
include_once("db_connect.php");
$email = $_POST['email'];

$sql = "SELECT DISTINCT GROUPID, GROUPNAME, GROUPIMAGE,EMAIL,JOINPASSWORD FROM LOCATIONGROUP WHERE EMAIL = '$email'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["group"] = array();
    while ($row = $result ->fetch_assoc()){
        $grouplist = array();
        $grouplist[groupid] = $row["GROUPID"];
        $grouplist[groupname] = $row["GROUPNAME"];
        $grouplist[groupimage] = $row["GROUPIMAGE"];
        $grouplist[email] = $row["EMAIL"];
        $grouplist[joinpassword] = $row["JOINPASSWORD"];
        array_push($response["group"], $grouplist);
    }
    echo json_encode($response);
}

else{
    echo "nodata";
}
?>