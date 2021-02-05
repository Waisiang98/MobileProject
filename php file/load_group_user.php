<?php
error_reporting(0);
include_once("db_connect.php");
$email = $_POST['email'];
$groupid = $_POST['groupid'];



$sql = "SELECT DISTINCT USER.NAME, USER.EMAIL, USER.IMAGENAME, USER.LATITUDE, USER.LONGITUDE,USER.ADDRESS, LOCATIONGROUP.GROUPNAME, LOCATIONGROUP.GROUPID, LOCATIONGROUP.GROUPIMAGE, LOCATIONGROUP.JOINPASSWORD FROM USER INNER JOIN LOCATIONGROUP ON LOCATIONGROUP.EMAIL = USER.EMAIL WHERE LOCATIONGROUP.GROUPID = '$groupid'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["usergroup"] = array();
    while ($row = $result ->fetch_assoc()){
        $usergrouplist = array();
        $usergrouplist[userName] = $row["NAME"];
        $usergrouplist[userEmail] = $row["EMAIL"];
        $usergrouplist[userImageName] = $row["IMAGENAME"];
        $usergrouplist[groupId] = $row["GROUPID"];
        $usergrouplist[groupname] = $row["GROUPNAME"];
        $usergrouplist[groupimage] = $row["GROUPIMAGE"];
        $usergrouplist[grouppassword] = $row["JOINPASSWORD"];
        $usergrouplist[latitude] = $row["LATITUDE"];
        $usergrouplist[longitude] = $row["LONGITUDE"];
        $usergrouplist[address] = $row["ADDRESS"];
        array_push($response["usergroup"], $usergrouplist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>