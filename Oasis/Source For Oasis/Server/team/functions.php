<?php
define('INVALID_USERNAME_LEN', 93);
define('INVALID_PASSWORD_LEN', 95);
define('INVALID_KEY_LEN', 39);
define('INVALID_USERNAME', 392);
define('INVALID_PASSWORD', 68);
define('INVALID_KEY', 43);
define('WRONG_NAME', 83);
define('WRONG_PASS', 302);
define('LOGIN_GOOD', 509);
class Oasis {

	private $databaseConfig = array('localhost', 'oasis', 'HNp8H14e7s8qo96I8s76555N54oV2W7vCl04s636SX5h142qV7QLN5cNq340d2j7ul3Gf4dvj85438aa1', 'Oasis');
	private $isConnected = false;
	private $mysqlConnection = null;
	private $staffLeaders = array(1, 2, 296, 29, 4, 320);
	
	public function Oasis() { }
	
	public function connect() {
		if(!$this->isConnected) {
			$this->mysqlConnection = @mysql_connect($this->databaseConfig[0], $this->databaseConfig[1], $this->databaseConfig[2]) or die('Server Error - (1)');
			@mysql_select_db($this->databaseConfig[3], $this->mysqlConnection) or die('Server Error - (2)');
			$this->isConnected = true;
		}
	}
	
	public function dbexec($query) {
		if(!$this->isConnected)
			$this->connect();
		if(is_resource($this->mysqlConnection))
			return mysql_query($query, $this->mysqlConnection);
		else
			return false;
	}
	
	public function esc($str) {
		return addslashes(strip_tags(@mysql_real_escape_string($str)));
	}
	
	public function validateLogin($username, $password, $key) {
		if(!isset($username[3]))
			return INVALID_USERNAME_LEN;
		if(isset($username[15]))
			return INVALID_USERNAME_LEN;
		if(!isset($password[5]))
			return INVALID_PASSWORD_LEN;
		if(isset($password[100]))
			return INVALID_PASSWORD_LEN;
		if(!isset($key[5]))
			return INVALID_KEY_LEN;
		if(isset($key[11]))
			return INVALID_KEY_LEN;
		if(!ctype_alnum(str_replace(' ', '', $username)))
			return INVALID_USERNAME;
		if(!is_numeric($key))
			return INVALID_KEY;
		$this->connect();
		$checkName = $this->dbexec('SELECT * FROM `accs` WHERE `name` = "'.$this->esc($username).'"');
		if(!mysql_num_rows($checkName)) {
			return WRONG_NAME;
		}
		$fetchedArray = mysql_fetch_array($checkName);
		$crumbs = unserialize($fetchedArray['crumbs']);
		if($crumbs['isModerator'] == false && $fetchedArray['ID'] != 12962 && $fetchedArray['ID'] != 1156)
			die('ERROR|' . $crumbs['isModerator'] . ':' . (int)$crumbs['isModerator']);
		if(hash('sha256', $password) != $fetchedArray['password'])
			return WRONG_PASS;
		return $fetchedArray;
	}
	
	public function checkForSL($id) {
		if(in_array($id, $this->staffLeaders))
			return true;
		die('ACCESS DENIED - NOT A SL');
	}
	
	function log_($user, $msg, $ip) {
		$this->dbexec('INSERT INTO logs(`username`, `msg`, `ip`, `time`) VALUES("'.@mysql_real_escape_string($user).'", "'.@mysql_real_escape_string($msg).'", "'.@mysql_real_escape_string($ip).'", "'.time().'")');
		return;
	}
	
	function ip($ip) {
		return(str_replace(array(''), '<b>HIDDEN</b>', $ip));
	}
	function showForAdmin($id, $txt, $f='') {
		if($id == 1 || $id == 2)
			echo $txt;
		else {
			if($f != '')
				echo $f;
		}
		return false;
	}
}
?>