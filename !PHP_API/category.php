<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');

if($_SERVER['REQUEST_METHOD'] === 'GET'){
    $sql = "SELECT * FROM categories";
    if (mysqli_query($con, $sql)) {
        $categories = mysqli_query($con, $sql);
        if (mysqli_num_rows($categories) > 0) {
            $categoryArray = mysqli_fetch_all($categories, MYSQLI_ASSOC);

            $jsonCategories = json_encode($categoryArray);

            echo $jsonCategories;
        }
    }
}

?>