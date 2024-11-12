<?php
// in development
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $subject = $_POST['subject'] ?? '';
    $message = $_POST['message'] ?? '';

    if (!$name || !$email || !$subject || !$message) {
        echo "<script>alert('All fields are required.'); window.history.back();</script>";
        exit;
    }

    $to = 'admin@racal.ph';
    $headers = "From: $email" . "\r\n" .
               "Reply-To: $email" . "\r\n" .
               "X-Mailer: PHP/" . phpversion();
    $body = "Name: $name\nEmail: $email\nSubject: $subject\nMessage:\n$message";

    if (@mail($to, $subject, $body, $headers)) {
        echo "<script>alert('Message sent successfully.'); window.location.href='ask-librarian.html';</script>";
    } else {
        echo "<script>alert('Failed to send the message. Please try again later.'); window.location.href='ask-librarian.html';</script>";
    }
} else {
    echo "<script>alert('Invalid request.'); window.history.back();</script>";
}
?>
