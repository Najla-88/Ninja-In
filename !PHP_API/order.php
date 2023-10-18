<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $order_id = isset($_GET['id']) ? $_GET['id'] : '';
        $sql = "UPDATE orders SET order_status = '0' WHERE id = $order_id";
        mysqli_query($con, $sql);
        $result = mysqli_affected_rows($con);
        echo $result;

} 
?>