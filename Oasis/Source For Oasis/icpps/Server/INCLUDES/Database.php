<?php
if(!defined("DBCONF")){
	define("DBCONF", true);
	include('iCPDB.php');
}

define("DB_INCLUDED", true);
define("BAD_USER", false);
define("NON_EXISTENT", false);
define("VALID_USER", true);


$g_link = false;
function &getDB(){
	global $g_link;
	if( @$g_link && is_object($g_link))
		return $g_link;
	if(DB_HOST != "localhost" && DB_HOST != "127.0.0.1"){
		$g_link = mysqli_init();
		$g_link->real_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME, null, null, MYSQLI_CLIENT_COMPRESS);
	}
	else{
		$g_link = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	}
	@$g_link->autocommit(false);//false for MyISAM!
	echo "Connected to MySQL server " . DB_HOST . " username " . DB_USER . "\n";
	return $g_link;
}

function DBCommit(){
	$g_link = getDB();
	return $g_link->commit();
	//return true;//For InnoDB
}

function getData($query, $m = "default"){
	error_reporting(E_ALL | E_STRICT);
	$mysqli = getDB();
	$result = $mysqli->query($query);
	if(!is_object($result)){
		return false;
	}
	$row = $result->fetch_assoc();
	if($m == "single"){
		if(is_object($result))
			$result->close();
		return $row;
	}
	$a = array($row);
	while($d2 = $result->fetch_assoc()){
		$a[] = $d2;
	}
	if(is_object($result))
		$result->close();
	return $a;
}

function setData($query){
	$mysqli = getDB();
	$result = $mysqli->query($query);
	$return =  ($result === false) ? false :true;
	if(is_object($result))
		$result->close();
	return $return;
}

function validUser($name){
	$d = getData("SELECT ID from accs WHERE UCASE(name) = '" . dbEscape(strtoupper($name)) . "'");
	if($d[0] == false || (!is_array($d)) || (count($d) < 1) || $d == false){
		return BAD_USER;
	}
	if(count($d) !== 1){
		//$this->logger->error("ERROR: getData call returned multiple usernames for a UNIQUE query. Your database is corrupted!");
		return VALID_USER;//It still exists, and this should never happen... so... just in case
	}
	return VALID_USER;
}

function validID($id){
	$d = getData("SELECT name from accs WHERE ID = '" . dbEscape($id) . "'");
	if($d[0] === false || (!is_array($d)) || (count($d) < 1)){
		return BAD_USER;
	}
	if(count($d) !== 1){
		$this->logger->error("ERROR: getData call returned multiple usernames for a UNIQUE query. Your database is corrupted!");
		return VALID_USER;//It still exists, and this should never happen... so... just in case
	}
	return VALID_USER;
}

function getId($name){
	$d = getData("SELECT ID from accs where UCASE(name) = '" . dbEscape(strtoupper($name)) . "'");
	if($d[0] === false || (!is_array($d)) || (count($d) < 1)){
		return BAD_USER;
	}
	if(count($d) !== 1){
		$this->logger->error("ERROR: getData call returned multiple usernames for a UNIQUE query. Your database is corrupted!");
		//return BAD_USER; //It still exists, and this should nevaar happen... so... just in case
	}
	return $d[0]['ID'];
}

function getRedemptionData($code){
	$d = getData("SELECT * FROM `redemption` WHERE `Code` = '". dbEscape($code) . "' LIMIT 1");

	if($d[0] === false || (!is_array($d)) || (count($d) < 1)){
		return NON_EXISTENT;
	}
	return $d[0];
}

function getName($ID){
	$d = getData("SELECT name from accs where ID = '" . dbEscape($ID) . "'");
	if($d[0] === false || (!is_array($d)) || (count($d) < 1)){
		return BAD_USER;
	}
	if(count($d) !== 1){
		$this->logger->error("ERROR: getData call returned multiple usernames for a UNIQUE query. Your database is corrupted!");
		//return BAD_USER; //It still exists, and this should nevaar happen... so... just in case
	}
	return $d[0]['name'];
}

function getIglooDetails($id){
	if(!validID($id))
		return BAD_USER;
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	$s = $id;
	if(!isset($a["igloo"])){
		return $s .= "%0%0%0";
	}
	$s .= "%" . $a["igloo"];
	$s .= "%" . $a["music"];
	$s .= "%" . $a["floor"];
	if(@$a["roomFurniture"]){
		$s .= "%" . $a["roomFurniture"];
		$s = substr($s, 0, strlen($s) - 1);
	}
	return $s;
}

function getPlayer($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	$s = $id;
	$s .= "|" . getName($id) . "|" . 1;//ENGLISH
	$s .= "|" . $a["color"];
	$s .= "|" . $a["head"];
	$s .= "|" . $a["face"];
	$s .= "|" . $a["neck"];
	$s .= "|" . $a["body"];
	$s .= "|" . $a["hands"];
	$s .= "|" . $a["feet"];
	$s .= "|" . $a["pin"];
	$s .= "|" . $a["photo"] . "|";
	return $s;
}

function dbEscape($s, $link = NULL){
	$mysqli = getDB();
	return $mysqli->real_escape_string($s);
}

function finishDB(){
	global $g_link;
	if($g_link)
		@mysql_close($g_link);
	$g_link = false;
}

function makeXt(){
	$a = func_get_args();
	if(!is_array($a))
		return false;
	$send = "%xt%";
	foreach($a as $s){
		$send .= $s . "%";
	}
	return $send;
}

function getPlayersStamps($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	$s = $id;
	if(!count($a["stamps"])){
		return $s;
	}
	$s .= "%";
	foreach($a["stamps"] as $stamp){
		$s .= "$stamp|";
	}
	$s = substr($s, 0, strlen($s) - 1);
	return $s;
}

function queryPlayersPins($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	$items = $a["items"];
	$pins = "";
	foreach($items as $item){
		if(($item >= 500 and $item < 650) || ($item >= 7000 and $item < 7100)){ //temporary pin check
			$pins .= "$item|0000000000|0%"; //0000000000 = pin release date in unix time, not sure what third parameter
		}
	}
	$pins = substr($pins, 0, strlen($pins) - 1);
	return $pins;
}

function queryPlayersAwards($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	$items = $a["items"];
	$awards = "";
	foreach($items as $item){
		if(($item >= 800 and $item < 823) || ($item >= 8000 and $item < 8010)){ //temporary pin check
			$awards .= "$item|0000000000|0%"; //0000000000 = award release date in unix time, not sure what third parameter
		}
	}
	$awards = substr($awards, 0, strlen($awards) - 1);
	return $awards;
}

function getStampBookCoverDetails($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	if(!isset($a["stampColor"])){
		return $s = "1%1%-1%1";
	}
	$s =  $a["stampColor"];
	$s .= "%" . $a["stampHighlight"];
	$s .= "%" . $a["stampPattern"];
	$s .= "%" . $a["stampIcon"];
	return $s;
}

function userOnline($id){
	$a = (getData("SELECT crumbs FROM accs WHERE ID=" . dbEscape($id), "single"));
	if(!$a)
		return BAD_USER;
	$a = unserialize($a['crumbs']);
	if(!is_array($a))
		return BAD_USER;
	if(isset($a['online']))
		if($a['online'])
			return $a['lastServerID'];
	return false;
}

function updateLogins($id, $name, $ip){
	$query = "INSERT INTO logins VALUES($id,'". dbEscape($name) . "','" . $ip . "'," . ($time = time()) . ")";
	$res = setData($query);
	//echo "DEBUG: updated logins, query $query!\n";
}

function updateStatus($id, $online){
	$query = "INSERT INTO stats VALUES($id," . dbEscape($online) . "," . ($time = time()) . ") ON duplicate KEY UPDATE population=" . dbEscape($online) . ", ts=$time";
	$res = setData($query);
	//echo "DEBUG: updated stats, query $query!\n";
}

?>
