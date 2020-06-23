<?php
/*	Made by ~Mobster	*/
/*	Modified by the Mirai team	*/
/*	August 26, 2013		*/

set_time_limit(0);
date_default_timezone_set('America/Chicago');

class BasicBot {
	var $BotRegname = 'MiraiCreditBOT';
	var $BotID = '1440986532';
	var $BotPassword = '83ne978';
	var $roomName = 'Mirai';
	var $soc;
	var $pendingMsgs;
	var $packet;
	var $users;
	var $myXats;
	var $games;
	var $done = false;
	var $owners = array('1000048', '148365148'); /*Put your id here*/
	var $automember_type = 0; /*-1 = Off; 0 = All; 1 = Registered; 2 = Subscribed;*/
	public $SockStatus = array(400, 401, 402, 403, 410, 411, 412, 413, 420, 421, 422, 423, 430, 431, 432, 433);
	
	function loadSettings() {
		$this->botInfo = array('name' => '[BOT]Mirai', 'avatar' => 1, 'home' => 'http://mirai.so', 'hat' => 1 /*1 = on, 0 = off*/, 'hatCode' => 'x', 'hatColor' => 'r', 'glow' => 0 /*1 = on, 0 = off*/, 'glowCode' => '------', 'namecolorCode' => 'r', 'status' => 'Mirai.so', 'statusGlowcode' => 'r');
	}
	function disconnect() {
		if(isset($this->soc) && $this->soc == true) socket_close($this->soc);
		$this->soc=FALSE;
	}
	function connect($ip='xat.com', $port=10001) {
		if(empty($this->BotRegname) || empty($this->BotPassword)) die("You must enter your bot's username and password.\n");
		if(!is_numeric($this->roomName)) {
			$cont = file_get_contents('http://xat.com/' . trim($this->roomName));
			$posLeft = stripos($cont, 'value="id=') + strlen('value="id=');
			$posRight = @stripos($cont, '&', $posLeft);
			$this->roomID = substr($cont, $posLeft, $posRight - $posLeft);
		} else $this->roomID = $this->roomName;
		if(!is_numeric($this->roomID)) die("You must enter a valid room name.\n");
		$file = simplexml_load_file('http://xat.com/web_gear/chat/ip.htm?'.time());
		$xsock = explode(",", $file->Attributes()->xSock);
		$xSock = explode(",", $file->Attributes()->xSock2);
		$xStat = explode(",", $file->Attributes()->d);
		$index = $this->roomID < 8 ? 4 : (($this->roomID & 96) >> 5) * 4 + rand(0,1);
		$ip = $this->connection['ip'] = ${$xStat[$index] != 0 ? "xsock" : "xSock"}[$index];
		$port = $this->connection['port'] = $this->roomID < 8 ? (9999 + $this->roomID) : (10007 + ($this->roomID % 32));
		$this->connection['loginip'] = $file->Attributes()->fwd;
		$error = false;
		echo "Connecting to ['".$ip."':'".$port."']...\n";
		do {
			try {
				$this->soc = socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
				socket_set_option($this->soc, SOL_SOCKET, SO_RCVTIMEO, array('sec'=>1000,'usec'=>0));
				if(!$this->soc) die(socket_strerror(socket_last_error($this->soc)));
				if(!socket_connect($this->soc,$ip,$port)) {
					echo "Connecting to ['".$ip."':'".$port."'] -> Failed to connect, reconnecting.\n";
					$this->connect('174.36.242.26','10000');
					$this->reconnected = true;
				}
				echo("Connecting to ['".$ip."':'".$port."'] -> Connected\n");
			} catch(Exception $e) {
				$error = true;
			}
		} while($error);
	}
	function login($user,$pass) {
		$p = fsockopen($this->connection['loginip'], 10000,$e,$e,1);
		stream_set_timeout($p,2);
		$packet = '<y r="8" />';
		fwrite($p, $packet.chr(0));
		$x = trim(fread($p, 1024));
		$packet = '<v r="'.$this->roomID.'" p="'.$pass.'" n="'.$user.'" />';
		fwrite($p, $packet.chr(0));
		$x = trim(fread($p, 1024));
		$this->parse($x);
		$this->loginInfo = $this->packet['v'];
		if(count($this->loginInfo) <= 4) return false;
		return $this->loginInfo;
	}
	function parseU($id) {
		if(strpos($id, "_") > -1) $e = explode("_", $id);
		$u = (strpos($id, "_") > -1) ? $e[0] : $id;
		return $u;
	}
	function join($room=false) {
		if($this->soc==FALSE) {
			$this->connect();
			$this->loggedIn = $this->login($this->BotRegname,$this->BotPassword);
		}
		$this->loadSettings();
		unset($this->packet['y']);
		$this->send('<y r="'.$this->roomID.'" m="1" />');
		while(!@is_array(@$this->packet['y'])) $this->read();
		if($this->loggedIn != false) {
			$i = $this->loginInfo;
			$this->userID = $i['i'];
			$j2 = '';
			$j2 .= 'cb="'.$this->packet['y']['c'].'" ';
			$j2 .= 'q="1" ';
			$j2 .= 'y="'.$this->packet['y']['i'].'" ';
			$j2 .= 'k="'.$i['k1'].'" ';
			$j2 .= 'k3="'.$i['k3'].'" ';
			if(isset($i['d1'])) $j2 .= 'd1="'.$i['d1'].'" ';
			else $i['di'] = '';
			$j2 .= 'p="0" ';
			$j2 .= 'c="'.$this->roomID.'" ';
			$j2 .= 'f="'.'0" ';
			$j2 .= 'u="'.$i['i'].'" ';
			for($c = 0;$c < 15;$c++)
				if($c == 1) continue;
				elseif(isset($i['d'.$c])) $j2 .= 'd'.$c.'="'.$i['d'.$c].'" ';
			if(isset($i['sn'])) $j2 .= 'sn="'.$i['sn'].'" ';
			if(isset($i['dx'])) $j2 .= 'dx="'.$i['dx'].'" ';
			else $i['dx'] = '';
			$this->myXats = $i['dx'];
			$j2 .= 'dt="'.$i['dt'].'" ';
			$j2 .= 'N="'.$i['n'].'" ';
			if (@$this->botInfo['hat'] == 1) $this->hat = '(hat#'.@$this->botInfo['hatCode'].'#'.@$this->botInfo['hatColor'].')';
			else $this->hat = '';
			if(@$this->botInfo['glow'] == 1 && (empty($this->botInfo['glowCode']) || $this->botInfo['glowCode'] == 'default')) $this->glow = '(glow)';
			elseif(@$this->botInfo['glow'] == 1) $this->glow = '(glow#'.((@$this->botInfo['glowCode'])?$this->botInfo['glowCode']:'0').'#'.@$this->botInfo['namecolorCode'].')';
			else $this->glow = '';
			$this->botInfo['status'] = str_replace('"','\'\'',$this->botInfo['status']);
			$this->botInfo['name'] = str_replace('"','\'\'',$this->botInfo['name']);
			$this->botInfo['avatar'] = str_replace('"','\'\'',$this->botInfo['avatar']);
			$j2 .= 'n="'.$this->botInfo['name'].''.$this->glow.''.$this->hat.'##'.@$this->botInfo['status'].'#'.$this->botInfo['statusGlowcode'].'" ';
			$j2 .= 'a="'.$this->botInfo['avatar'].'" ';
			$j2 .= 'h="'.$this->botInfo['home'].'" ';
			$j2 .= 'v="0" ';
			$j2 = trim($j2);
			$j2 = '<j2 '.$j2.' />';
			$this->send($j2);
		} else die('Could not login.');
	}
	function f2rank($f) {
		$f = $this->parseU($f);
		if($f==-1) return 0;   //guest
		if((16 & $f)) return -1;//ban
		if((1 & $f)&&(2 & $f)) return 1;//Member
		if((4 & $f)) return 3;//Owner
		if((32 & $f)&&(1 & $f)&&!(2 & $f)) return 4;//main
		if(!(1 & $f)&&!(2 & $f)) return 0;//Guest
		if((16 & $f)) return -1;//ban
		if((2 & $f)&&!(1 & $f)) return 2;//MOd
		if(1 & $f) return 4;//main 9 and 1 were used for me on 3nv
		return 0;
	}
	function handle($type,$msg) { 
        switch($type) {
			case 'a':
				// <a u="148365148" k="T" t="sup" b="1440986532" x="0" s="1" /
				$from = $msg['u'];
				$user = $msg['t'];
				$to = $msg['b'];
				if($to != $this->BotID) return;
				if($msg['x'] == 0) return;
				if($msg['x'] < 100)
					return $this->sendPM($msg['u'], 'You have to send at least 100 xats!');
				$amount = ($msg['x'] * 10);
				$code = `php /Mirai/genCode.php $amount`;
				if($code == false || strlen($code) != 36) {
					$supportID = rand(99999, 999999999);
					$this->sendPC($msg['u'], 'There was an error generating your redemption code. E-mail billing@mirai.so with this ID: ' . $supportID);
					echo "Oh no! $supportID failed! $amount -- $from\n";
					$f=fopen('fails.txt', 'a+');
					fwrite($f, '[FAIL]' . $supportID . ', Amount: ' . $amount . ', ID: ' . $from . " -- ( $code )\r\n");
					fclose($f);
					return;
				}
				$this->myXats += $msg['x'];
				$this->pendingMsgs[$from] = 'Thanks for your purchase! Your code is: &quot;' . $code . '&quot; (without the quotes). Please enter this via the Redeem Code area in me.mirai.so to redeem your ' . $amount .' credits.';
				return;
			break;
			case 'u':
				$id = $this->parseU($msg['u']);
				$this->users[$id] = $msg;
				if(isset($this->pendingMsgs[$id])) {
					$this->sendPC($id, $this->pendingMsgs[$id]);
					unset($this->pendingMsgs[$id]);
				}
						
			break;
			case 'gp':
				if(isset($this->packet['gp']['x']))
					$this->send('<x i="'.$this->packet['gp']['x'].'" u="'.$this->userID.'" t="j" />');
			break;
			case 'q':
				$this->connect($this->packet['q']['d'], $this->packet['q']['p']);
				$this->join();
			break;  
			case 'done':
				$this->done = true;
				if(isset($this->reconnected) && $this->reconnected==true) {
					echo 'Recovered';
					$this->reconnected = false;
				}
			break;
			case 'p':
				$from = $msg['u'];
				if(strtolower($msg['t']) == '!givemexats') {
					if($from == '1000048' || $from == '148365148') {
						if($this->myXats >= 10) {
							$this->send('<a b="'.$from.'" s="0" x="'.$this->myXats.'" k="T" m="Paycheck" p="'.$this->BotPassword.'" />');
							$this->myXats = 0;
						}
					} else {
						$this->sendPC($from, 'no (cry2)');
					}
				}
			break;
		}
	}
	function read($parse=true,$handle=true) {
		$res = '';
		try {
			$res = @rtrim(socket_read($this->soc, 2048));
			$res = str_replace('','',$res);
		} catch(Exception $e) { 
			return 'DIED';
		}
		if(strpos($res, '<idle e="I01" />') !== false) return 'DIED';
		if(!$res) return 'DIED';
		if($res[strlen($res) - 1] != '>') $res .= $this->read(true);
		if($parse) $this->parse($res,$handle);
		return $res;
	}
	function send($data) {
		if($data[strlen($data)-1] != chr(0)) $data .= chr(0);
		echo '['.date('h:i:s').'][Sent] '.$data."\n";
		return socket_write($this->soc, $data, strlen($data));
	}
	function parse($packet,$handle = true,$testt = false) {
		if(substr_count($packet,'>') > 1) {
			$packet = explode('/>', $packet);
			$testt = true;
		}
		foreach((Array)$packet as $p) {
			if($testt) $p .= '/>';
			$p = trim($p);
			if(strlen($p) < 5) return;
			echo '['.date('h:i:s').'][Received] '.$p."\n";
			$type = trim(strtolower(substr($p,1,strpos($p.' ',' '))));
			$p = trim(str_replace('<'.$type,'',str_replace('/>','',$p)));
			parse_str(str_replace('+','__43',str_replace('"','',str_replace('" ','&',str_replace('="','=',str_replace('&','__38',$p))))),$this->packet[$type]);
			foreach($this->packet[$type] as $k=>$v) 
				$this->packet[$type][$k] = str_replace('__43','+',str_replace('__38','&',$v));
			if($handle) $this->handle($type,$this->packet[$type]);
		}
	}
	function respond($message,$type=0,$uid=0) {
		switch($type) {
			case 0: $this->sendMessage($message); break;
			case 1: $this->sendPC($uid,$message); break;
			case 2: $this->sendPM($uid,$message); break;
		}
	}
	function sendMessage($msg) {
		if(empty($msg)) { return false; }
		$this->send('<m t="'.$msg.'" u="'.$this->loginInfo['i'].'" />');
	}
	function sendPM($id, $msg) {
		$id = $this->parseU($id);
		if(empty($msg)) return false;
		$this->send('<p u="'.$id.'" t="'.$msg.'" d="'.$id.'" />');
	}
	function sendPC($id, $msg) {
		$id = $this->parseU($id);
		if(empty($msg)) return false;
		$this->send('<p u="'.$id.'" t="'.$msg.'" s="2" d="'.$id.'" />');
	}
	function member($id,$time=null) {
		if(!$time) $time = 0;
		$id = $this->parseU($id);
		$this->sendC($id, '/e',$time);
	}
	function sendC($id, $com) {
		$id = $this->parseU($id);
		$this->send('<c u="'.$id.'" t="'.$com.'" />');
	}
}
$bot = new BasicBot();
while(true) {
	try {
		if($bot->read() == 'DIED') {
			$bot->disconnect();
			$bot->join();
		}
	} catch (Exception $e) {
		die($e);
	}
}
?>