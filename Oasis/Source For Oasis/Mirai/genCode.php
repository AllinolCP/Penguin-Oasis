<?php
$amount = $argv[1];
if(!is_numeric($amount))
	die;
include '/Mirai/config.php';
function gen_uuid() {
    return sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),
        mt_rand( 0, 0xffff ),
        mt_rand( 0, 0x0fff ) | 0x4000,
        mt_rand( 0, 0x3fff ) | 0x8000,
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff )
    );
}
$randCode = strtoupper(gen_uuid());
$db = new mysqli($config['db_host'], $config['db_user'], $config['db_pass'], $config['db_name']) or die('INT_ERROR');
$query = $db->prepare('INSERT INTO codes (`expires`, `uses`, `code`, `credits`) VALUES(0, 1, ?, ?)');
$query->bind_param('si', $randCode, $amount);
$query->execute();
$db->close();
die($randCode);
?>
