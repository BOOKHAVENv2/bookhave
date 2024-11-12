<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "bookhaven";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    if ($action === 'signup') {
        $confirmPassword = $_POST['confirm_password'];
        if ($password !== $confirmPassword) {
            echo json_encode(['status' => 'error', 'message' => 'Passwords do not match!']);
            exit;
        }

        $sql = "SELECT * FROM users WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            echo json_encode(['status' => 'error', 'message' => 'Email already exists!']);
            exit;
        }

        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        $sql = "INSERT INTO users (email, password) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ss', $email, $hashedPassword);
        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Registration successful!']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to register user.']);
        }
    } elseif ($action === 'signin') {
        $sql = "SELECT * FROM users WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc();
            if (password_verify($password, $user['password'])) {
                echo json_encode(['status' => 'success', 'message' => 'Login successful!', 'token' => bin2hex(random_bytes(16))]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Invalid password!']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Email not found!']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid action!']);
    }
}

$conn->close();

?>
