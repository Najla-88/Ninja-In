<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');

if($_SERVER['REQUEST_METHOD'] === 'GET'){

    $uri = $_SERVER['REQUEST_URI'];
    if (strpos($uri, 'products.php/') !== false) {
        $action = substr($uri, strpos($uri, 'products.php/') + strlen('products.php/'));
        $action = strtok($action, '?');
    }

    ///////////////////////////////////////////////////////////////////

    if ($action === 'getByCate') {
        $cateId = isset($_GET['cateId']) ? $_GET['cateId'] : '';

        $sql = "SELECT * FROM products WHERE cate_id = $cateId";
        if (mysqli_query($con, $sql)) {
            $product = mysqli_query($con, $sql);
            if (mysqli_num_rows($product) > 0) {
                $productArray = mysqli_fetch_all($product, MYSQLI_ASSOC);
                $jsonproduct = json_encode($productArray);
                echo $jsonproduct;
            }
        }
    }

    ///////////////////////////////////////////////////////////////////

    elseif ($action === 'getByFeate') {
        $featId = isset($_GET['featId']) ? $_GET['featId'] : '';
            $sql = "SELECT p.*
                    FROM products p
                    JOIN product_feature pf ON p.id = pf.prod_id
                    WHERE pf.feat_id = $featId;";
            if (mysqli_query($con, $sql)) {
                $products = mysqli_query($con, $sql);
                $productArray = mysqli_fetch_all($products, MYSQLI_ASSOC);
                $jsonproduct = json_encode($productArray);

                    echo $jsonproduct;
            }
    }

    ///////////////////////////////////////////////////////////////////

    elseif ($action === 'getById') {
        $id = isset($_GET['id']) ? $_GET['id'] : '';
        $sql = "SELECT * FROM products WHERE id = $id";
        if (mysqli_query($con, $sql)) {
            $product = mysqli_query($con, $sql);
            if (mysqli_num_rows($product) > 0) {
                $productArray = mysqli_fetch_assoc($product);
                $jsonproduct = json_encode($productArray);
                echo $jsonproduct;
            }
        }
    }
}
?>