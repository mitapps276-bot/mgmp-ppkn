<?php
session_start();
require_once 'config/database.php';

if (!isset($_SESSION['login'])) {
    exit('Unauthorized');
}

$user_id = (int) $_SESSION['user_id'];
@mysqli_query($conn, "UPDATE users SET last_activity = NOW() WHERE id = $user_id");

// Ambil jumlah unread messages untuk fitur Chat
$unread_counts = [];
$cek_pm_table = @mysqli_query($conn, "SHOW TABLES LIKE 'private_messages'");
if ($cek_pm_table && mysqli_num_rows($cek_pm_table) > 0) {
    $q_unread = mysqli_query($conn, "SELECT sender_id, COUNT(id) as unread_total FROM private_messages WHERE receiver_id = $user_id AND is_read = 0 GROUP BY sender_id");
    if ($q_unread) {
        while ($r = mysqli_fetch_assoc($q_unread)) {
            $unread_counts[$r['sender_id']] = $r['unread_total'];
        }
    }
}

$recent_logins_query = mysqli_query($conn, "
    SELECT u.id, u.full_name, u.school_name, l.login_time, u.profile_photo, u.role_id, u.last_activity 
    FROM login_activity l
    JOIN users u ON l.user_id = u.id
    WHERE u.role_id IN (1, 2, 4) AND l.login_date = CURDATE()
    ORDER BY l.login_time DESC
");

if($recent_logins_query && mysqli_num_rows($recent_logins_query) > 0){ 
    // Kita juga bisa mengembalikan info jumlah guru lewat header atau diparsing, 
    // tapi karena ini merender HTML langsung, kita render saja wrapper-nya.
?>
    <style>
        .active-teacher-carousel-wrapper {
            position: relative;
            width: 100%;
            margin-top: -60px;
            margin-bottom: -60px;
            z-index: 5;
        }
        .active-teacher-list {
            display: flex;
            overflow-x: auto;
            gap: 15px;
            padding: 65px 5px;
            scroll-snap-type: x mandatory;
            -webkit-overflow-scrolling: touch;
            scroll-behavior: smooth;
            scrollbar-width: thin;
        }
        .active-teacher-list::-webkit-scrollbar { height: 8px; }
        .active-teacher-list::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
        .active-teacher-list::-webkit-scrollbar-thumb { background: #bdc3c7; border-radius: 10px; }
        .active-teacher-card {
            flex: 0 0 280px;
            scroll-snap-align: start;
            box-sizing: border-box;
            background: #ffffff;
            border: 1px solid #edf0f2;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: transform 0.3s ease;
        }
        .active-teacher-card:hover {
            transform: translateY(-2px);
            z-index: 10;
            position: relative;
        }
        .active-user-photo {
            transition: transform 0.3s ease, box-shadow 0.3s ease !important;
            position: relative;
            z-index: 1;
        }
        .active-teacher-card:hover .active-user-photo {
            transform: scale(5) !important;
            z-index: 9999 !important;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2) !important;
        }
    </style>
    <div class="active-teacher-carousel-wrapper">
        <div class="active-teacher-list" id="activeTeacherCarousel">
            <?php
            while($login = mysqli_fetch_assoc($recent_logins_query)){
                $login_time = date('H:i', strtotime($login['login_time']));
                $initial_login = strtoupper(substr(trim($login['full_name']), 0, 1));
                $photo_login = isset($login['profile_photo']) ? $login['profile_photo'] : '';
                $is_me = ($login['id'] == $user_id);
                
                // Menentukan Status Online/Offline (Batas 10 Menit)
                $is_online = false;
                if (isset($login['last_activity']) && !empty($login['last_activity'])) {
                    $last_act = strtotime($login['last_activity']);
                    $now = time();
                    if (($now - $last_act) <= 600) { // 10 menit
                        $is_online = true;
                    }
                }
                
                if ($is_online) {
                    $status_badge = '<span style="background:#eafaf1; color:#27ae60; padding:4px 8px; border-radius:12px; font-size:11px; font-weight:bold; border:1px solid #2ecc71;">🟢 Online</span>';
                } else {
                    $status_badge = '<span style="background:#f2f3f4; color:#7f8c8d; padding:4px 8px; border-radius:12px; font-size:11px; font-weight:bold; border:1px solid #bdc3c7;">⚪ Offline</span>';
                }
            ?>
            <div class="active-teacher-card" style="display:flex; flex-direction:column; justify-content:space-between; height: 100%;">
                <div style="display:flex; gap:10px;">
                    <div>
                        <?php if(!empty($photo_login) && file_exists(__DIR__ . "/" . $photo_login)){ ?>
                            <img src="<?= htmlspecialchars($photo_login); ?>" class="active-user-photo" style="width:45px; height:45px; border-radius:50%; object-fit:cover; flex-shrink:0;">
                        <?php }else{ ?>
                            <div class="active-user-photo" style="width:45px; height:45px; border-radius:50%; background:#2c3e50; color:white; display:flex; align-items:center; justify-content:center; font-size:18px; font-weight:bold; flex-shrink:0;">
                                <?= htmlspecialchars($initial_login); ?>
                            </div>
                        <?php } ?>
                    </div>
                    <div style="flex:1; min-width:0;">
                        <strong style="color:#2c3e50; font-size:14px; display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <?= htmlspecialchars($login['full_name']); ?> 
                            <?= $is_me ? '<span style="color:#27ae60; font-size:11px;">(Anda)</span>' : ''; ?>
                        </strong>
                        <span style="color:#7f8c8d; font-size:12px; display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <?= htmlspecialchars(isset($login['school_name']) ? $login['school_name'] : '-'); ?>
                        </span>
                        <?php if($login['role_id'] == 4){ echo '<div style="margin-top:4px;"><span style="display:inline-block; background:#fdf2e9; color:#e67e22; padding:2px 6px; border-radius:4px; font-size:10px; border:1px solid #f39c12;">Ext. Kolaborator</span></div>'; } ?>
                        <?php if($login['role_id'] == 1){ echo '<div style="margin-top:4px;"><span style="display:inline-block; background:#ebf5ff; color:#2980b9; padding:2px 6px; border-radius:4px; font-size:10px; border:1px solid #3498db;">Admin</span></div>'; } ?>
                    </div>
                </div>
                
                <div style="margin-top: 15px; display:flex; justify-content:space-between; align-items:center; border-top: 1px solid #eee; padding-top: 10px;">
                    <div>
                        <?= $status_badge; ?>
                    </div>
                    <?php if (!$is_me) { ?>
                    <div style="position:relative; display:inline-block;" id="chat_btn_wrapper_<?= $login['id']; ?>">
                        <button onclick="openChatModal(<?= $login['id']; ?>, '<?= addslashes($login['full_name']); ?>')" style="background:#3498db !important; color:white !important; border:none !important; padding:6px 12px !important; margin:0 !important; border-radius:6px !important; font-size:12px !important; cursor:pointer; font-weight:bold; display:inline-block !important; width:auto !important; min-width:70px !important; white-space:nowrap !important; vertical-align:middle !important; line-height:1.2 !important; text-align:center !important;"><span style="font-size:14px; vertical-align:middle;">💬</span> <span style="vertical-align:middle;">Chat</span></button>
                        
                        <?php if(isset($unread_counts[$login['id']]) && $unread_counts[$login['id']] > 0) { ?>
                            <span id="badge_unread_<?= $login['id']; ?>" style="position:absolute; top:-8px; right:-8px; background:#e74c3c; color:white; font-size:10px; font-weight:bold; padding:2px 6px; border-radius:10px; border:1px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                                <?= $unread_counts[$login['id']] > 99 ? '99+' : $unread_counts[$login['id']]; ?>
                            </span>
                        <?php } ?>
                    </div>
                    <?php } else { ?>
                        <div style="font-size:11px; color:#aaa;">Login: <?= $login_time; ?></div>
                    <?php } ?>
                </div>
            </div>
            <?php } ?>
        </div>
    </div>
    <p class="mobile-swipe-hint" style="text-align:center; font-size:12px; color:#95a5a6; margin-top:-10px; margin-bottom:0;">&larr; Geser untuk melihat yang lain &rarr;</p>
<?php } else { ?>
    <div style="width:100%; padding:20px; text-align:center; color:#7f8c8d; background:#f8f9fa; border-radius:12px; border:1px dashed #ccc;">Belum ada guru yang login hari ini.</div>
<?php } ?>
