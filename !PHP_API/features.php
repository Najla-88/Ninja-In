<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $cateId = isset($_GET['cateId']) ? $_GET['cateId'] : '';
    $sql = "SELECT * FROM features WHERE cate_id = $cateId";
    if (mysqli_query($con, $sql)) {
        $features = mysqli_query($con, $sql);
        if (mysqli_num_rows($features) > 0) {
            $rows = array();
            while ($row = mysqli_fetch_assoc($features)) {
                if ($row['image'] !== null) {
                    $row['image'] = base64_encode($row['image']);
                }
                
                $rows[] = $row;
            }
            $jsonfeature = json_encode($rows);
            echo $jsonfeature;
        }
    }
}
?>