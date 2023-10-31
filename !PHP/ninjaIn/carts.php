<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $uri = $_SERVER['REQUEST_URI'];
    if (strpos($uri, 'carts.php/') !== false) {
        $action = substr($uri, strpos($uri, 'carts.php/') + strlen('carts.php/'));
    }

    ///////////////////////////////////////////////////////////////////////////////////////

    if ($action === 'addCart') {
        $requestData = json_decode(file_get_contents('php://input'), true); // Retrieve the JSON data sent from Flutter
        $user_id    = isset($requestData['user_id'])  ? $requestData['user_id']     : '';
        $prod_id    = isset($requestData['prod_id'])  ? $requestData['prod_id']     : '';
        $quantity   = isset($requestData['quantity']) ? $requestData['quantity']    : '';
        $price      = isset($requestData['price'] )   ? $requestData['price']       : '';
        
        $sql = "SELECT id FROM orders WHERE user_id = '$user_id' AND order_status = '1'";
        $result = mysqli_query($con, $sql);

        if (mysqli_num_rows($result) > 0){
        $order_id = mysqli_fetch_assoc($result)['id'];
        $result = mysqli_num_rows(mysqli_query($con, $sql));
        }
        // if there is no any available order create a new one
        else {
            $sql = "INSERT INTO orders (user_id, order_status) 
                    VALUES ('$user_id', '1')";
                $result = mysqli_query($con, $sql);
                $order_id = mysqli_insert_id($con);
        }
        if($result > 0)
        {
            // get cart id if there is one with the same product in the available order
            $sql = "SELECT * FROM carts WHERE prod_id = '$prod_id' AND order_id = '$order_id'";
            $result = mysqli_query($con, $sql);
            if(mysqli_num_rows($result) > 0)
            {
                $old_cart = mysqli_fetch_assoc($result); 
                $old_qty = $old_cart['quantity'];
                $updated_cart_id = $old_cart['id'];
                // instead of create new cart increase the quantity
                $qty = $old_qty + $quantity;
                $sql = "UPDATE carts SET quantity = $qty WHERE prod_id = '$prod_id' AND order_id = '$order_id'";
                mysqli_query($con, $sql);
                $sql = "SELECT * FROM carts WHERE id = '$updated_cart_id'";
                $cart = mysqli_fetch_assoc(mysqli_query($con, $sql));
                if($cart != null)
                {
                    echo json_encode($cart);
                } else {
                    echo null;
                }

            }
            else{        
                // if there is no cart with the same product id, create a new cart
                $sql = "INSERT INTO carts (prod_id, order_id, user_id, quantity, price) 
                        VALUES ('$prod_id', '$order_id', '$user_id', '$quantity', '$price')";
                $result = mysqli_query($con, $sql);
                if ($result > 0) {
                    $insertedCartId = mysqli_insert_id($con);
                    $selectSql = "SELECT * FROM carts WHERE id = $insertedCartId";
                    $selectResult = mysqli_query($con, $selectSql);
                    $cart = mysqli_fetch_assoc($selectResult);
                    if($cart != null)
                    {
                        echo json_encode($cart);
                    } else {
                        echo null;
                    }
                }
            }
        }
    }

    elseif ($action === 'updateCart') {
        $requestData = json_decode(file_get_contents('php://input'), true); // Retrieve the JSON data sent from Flutter
        
        $cart_id = isset($requestData['id']) ? $requestData['id'] : '';
        $quantity = isset($requestData['quantity']) ? $requestData['quantity'] : '';
            $sql = "UPDATE carts SET quantity = $quantity WHERE id = $cart_id";
            mysqli_query($con, $sql);
            $result = mysqli_affected_rows($con);
            echo $result;
    }
    elseif ($action === 'deleteCart') {
        $requestData = json_decode(file_get_contents('php://input'), true); // Retrieve the JSON data sent from Flutter

        $cart_id = isset($requestData['id']) ? $requestData['id'] : '';
        $sql = "DELETE FROM carts WHERE id = $cart_id";
        mysqli_query($con, $sql);
        $result = mysqli_affected_rows($con);
        echo $result;
    }
}

elseif ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $uri = $_SERVER['REQUEST_URI'];
    if (strpos($uri, 'carts.php/') !== false) {
        $action = substr($uri, strpos($uri, 'carts.php/') + strlen('carts.php/'));
        $action = strtok($action, '?');
    }


    if ($action === 'getCarts') {

        $user_id = isset($_GET['user_id']) ? $_GET['user_id'] : '';
        $sql = "SELECT id FROM orders WHERE user_id = '$user_id' AND order_status = '1'";

        $result = mysqli_query($con, $sql);
        if (mysqli_num_rows($result) > 0) {
            $order_id = mysqli_fetch_assoc($result)['id'];
            $sql = "SELECT * FROM carts WHERE user_id = '$user_id' AND order_id = $order_id";

            $result = mysqli_query($con, $sql);

            if (mysqli_num_rows($result) > 0) {
                $row = mysqli_fetch_all($result, MYSQLI_ASSOC);

            // Return the response as JSON
            echo json_encode($row);
            // echo json_encode($user);
            }
        }   
    }
}

?>