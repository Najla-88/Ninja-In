<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $ProdId = isset($_GET['prodId']) ? $_GET['prodId'] : '';
    $sql = "SELECT * FROM images WHERE product_id = $ProdId";
        if (mysqli_query($con, $sql)) {
            $images = mysqli_query($con, $sql);
            if (mysqli_num_rows($images) > 0) {
                $rows = array();
                while ($row = mysqli_fetch_assoc($images)) {
                    if ($row['img'] !== null) {
                        $row['img'] = base64_encode($row['img']);
                    }
                    $rows[] = $row;
                }
                $jsonimages = json_encode($rows);
                echo $jsonimages;
        }
    }
}
?>