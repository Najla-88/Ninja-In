<?php
header("Content-Type: application/json");

$con = mysqli_connect('localhost', 'root', '', 'ninjain');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $uri = $_SERVER['REQUEST_URI'];
    if (strpos($uri, 'users.php/') !== false) {
        $action = substr($uri, strpos($uri, 'users.php/') + strlen('users.php/'));
    }



    if ($action === 'signup') {
        $requestData = json_decode(file_get_contents('php://input'), true); // Retrieve the JSON data sent from Flutter
        $name = isset($requestData['name']) ? $requestData['name'] : '';
        $email = isset($requestData['email']) ? $requestData['email'] : '';
        $password = isset($requestData['password']) ? $requestData['password'] : '';

        // check if user is exsisted
        $sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";

        $result = mysqli_query($con, $sql);

        // if there is no user with this name and email
        // add the user to table
        if (mysqli_num_rows($result) < 1) {
            $sql = "INSERT INTO users (name, email, Password) VALUES ('$name', '$email', '$password')";

            if (mysqli_query($con, $sql)) {
                $insertedUserId = mysqli_insert_id($con);
                $selectSql = "SELECT * FROM users WHERE id = $insertedUserId";
                $selectResult = mysqli_query($con, $selectSql);
                
                if (mysqli_num_rows($selectResult) > 0) {
                    $user = mysqli_fetch_assoc($selectResult);
                    echo json_encode($user);
                } 
            } 
        }
        else {
            echo null;
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////

    elseif ($action === 'login') {
        $requestData = json_decode(file_get_contents('php://input'), true);
        $email = isset($requestData['email']) ? $requestData['email'] : '';
        $password = isset($requestData['password']) ? $requestData['password'] : '';
        $sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";

        $result = mysqli_query($con, $sql);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $response = array(
                'id' => $row['id'],
                'name' => $row['name'],
                'email' => $row['email'],
                'password' => $row['password'],
                'image' => base64_encode($row['image'])
            );
            echo json_encode($response);
        } else {
            echo null;
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////

    elseif ($action === 'delete') {
        $requestData = json_decode(file_get_contents('php://input'), true);
        $id = isset($requestData['id']) ? $requestData['id'] : '';
        $sql = "DELETE FROM users WHERE id = $id";
        mysqli_query($con, $sql);
        $result = mysqli_affected_rows($con);
        echo $result;
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////

    elseif ($action === 'update') {
        $requestData = json_decode(file_get_contents('php://input'), true);
        $id = isset($requestData['id']) ? $requestData['id'] : '';
        $name = isset($requestData['name']) ? $requestData['name'] : '';
        $password = isset($requestData['password']) ? $requestData['password'] : '';
        $img = isset($requestData['image']) ? $requestData['image'] : '';

        if ($img!='') {
            $imgData = base64_decode($img); // Convert base64 string to binary data
            // Store the image data in the database as a blob
            $stmt = $con->prepare("UPDATE users SET name = ?, password = ?, image = ? WHERE id = ?");
            $null = NULL;
            $stmt->bind_param("ssbi", $name, $password, $null, $id);
            $stmt->send_long_data(2, $imgData);
            $stmt->execute();
            echo $stmt->affected_rows;
            $stmt->close();
        } else {
            $sql = "UPDATE users SET name = '$name', password = '$password' WHERE id = '$id'";
            mysqli_query($con, $sql);
            echo mysqli_affected_rows($con);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////

    elseif ($action === 'getUserById') {
        $requestData = json_decode(file_get_contents('php://input'), true);
        $id = isset($requestData['id']) ? $requestData['id'] : '';

        $sql = "SELECT * FROM users WHERE id = '$id'";

        $result = mysqli_query($con, $sql);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $response = array(
                'id' => $row['id'],
                'name' => $row['name'],
                'email' => $row['email'],
                'password' => $row['password'],
                'image' => base64_encode($row['image'])
            );
            echo json_encode($response);
        } else {
            echo null;
        }
    }
}
?>