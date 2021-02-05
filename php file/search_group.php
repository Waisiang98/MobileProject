<?php
error_reporting(0);
include_once("db_connect.php");
$groupid = $_POST['groupid'];

if (isset($_POST['groupid'])){
$groupid = $_POST['groupid'];
 $sql ="SELECT DISTINCT GROUPID, GROUPNAME, GROUPIMAGE FROM LOCATIONGROUP WHERE GROUPID LIKE '%$groupid%'";
}

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["group"] = array();
    while ($row = $result ->fetch_assoc()){
            $grouplist = array();
            $grouplist[groupid] = $row["GROUPID"];
            $grouplist[groupname] = $row["GROUPNAME"];
            $grouplist[groupimage] = $row["GROUPIMAGE"];
            array_push($response["group"], $grouplist);
            echo json_encode($response);
        
    }
}

else{
    echo "nodata";
}
?>