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
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $uri = $_SERVER['REQUEST_URI'];
    if (strpos($uri, 'order.php/') !== false) {
        $action = substr($uri, strpos($uri, 'order.php/') + strlen('order.php/'));
    }

    if ($action === 'updateTotal') {
        $requestData = json_decode(file_get_contents('php://input'), true); // Retrieve the JSON data sent from Flutter
        
        $order_id = isset($requestData['id']) ? $requestData['id'] : '';
        $total = isset($requestData['total']) ? $requestData['total'] : '';
        
        $sql = "UPDATE orders SET total = $total WHERE id = $order_id";
        mysqli_query($con, $sql);
        $result = mysqli_affected_rows($con);
        echo $result;
    }
} 
?>