<?php
require 'config/database.php';
session_start();

// Cek apakah user adalah admin
if (!isset($_SESSION['login']) || $_SESSION['role_id'] != 1) {
    die("Akses ditolak!");
}

// Cek CSRF Token
if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    die("Error: Token keamanan tidak valid!");
}

if (isset($_POST['step']) && $_POST['step'] == '1') {
    // Matikan Foreign Key Checks sementara agar bisa truncate table berelasi
    mysqli_query($conn, "SET FOREIGN_KEY_CHECKS = 0");

    // 1. Reset Jumlah Login (tabel-tabel terkait login)
    mysqli_query($conn, "TRUNCATE TABLE login_activity");
    mysqli_query($conn, "TRUNCATE TABLE login_attempts");
    mysqli_query($conn, "TRUNCATE TABLE login_attempts_user");
    mysqli_query($conn, "TRUNCATE TABLE login_logs");

    // 2. Reset Pengumuman
    mysqli_query($conn, "TRUNCATE TABLE announcements");

    // 3. Reset Chat
    mysqli_query($conn, "TRUNCATE TABLE public_messages");
    
    // 4. Reset File Upload (Database)
    mysqli_query($conn, "TRUNCATE TABLE material_comments");
    mysqli_query($conn, "TRUNCATE TABLE material_requests");
    mysqli_query($conn, "TRUNCATE TABLE downloads");
    mysqli_query($conn, "TRUNCATE TABLE materials");

    // Hidupkan kembali Foreign Key Checks
    mysqli_query($conn, "SET FOREIGN_KEY_CHECKS = 1");

    // 5. Menghapus isi folder uploads (tapi membiarkan folder dan index-nya)
    $upload_dir = __DIR__ . '/uploads/';
    if (is_dir($upload_dir)) {
        $files = glob($upload_dir . '*'); 
        foreach($files as $file){ 
            if(is_file($file)){
                $filename = basename($file);
                // Biarkan index.php atau index.html jika ada untuk keamanan folder
                if ($filename !== 'index.php' && $filename !== 'index.html') {
                    unlink($file); 
                }
            }
        }
    }

    header("Location: dashboard_admin.php?reset_success=1");
    exit;
}
?>
