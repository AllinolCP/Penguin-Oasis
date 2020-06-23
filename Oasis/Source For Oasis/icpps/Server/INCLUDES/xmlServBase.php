<?php
abstract class xmlServBase{
	public $ip,$port,$zones,$log,$clients,$config;
	public $mainSocket = NULL;
	public $success = false;
	public $xmldefaulttypehandlers = array(
			'sys' => array(
				'verChk' => "handleVerChk",	//Smartfox API Verson check
				'login' => "handleLogin",	//Login handler
				'rndK'	=> "handleRndK",	//Request for a random key.(Used in password hashing, so sniffed hasses can't be used!
			)
		);
	public $sendhandlers = array();
	public $handlers = array();
	private $torun = 0;

	function onReceive($data){
		//Overriden in child
	}
	
	function log_memory() {
		/*$this->stats['memory'][] = array(
			'time'   => microtime(true),
			'memory' => ($m = memory_get_usage()),
		);*/
		$m = memory_get_usage();
		$this->stats['memory']['peak'] = memory_get_peak_usage(true);
		$this->stats['memory']['current'] = $m;
	}

	function show_memory(){
		$this->log_memory();
		$inc = memory_get_usage() - $this->stats['memory']['old'];
		$this->stats['memory']['old'] = memory_get_usage();
		$newt = time();
		$tt = $newt - $this->oldt;
		$this->oldt = $newt;
		$inc += 80;//Workaround for memory used in calculations, may be different on 32bit systems, not sure, haven't tested.
		$this->log->screen("YAWN! None of your " . Client::$num . " clients have sent any data. Memory usage: " . memory_get_usage() . " Memory change in $tt seconds: $inc");

	}

	function __construct($config, $isLogin = false){
		echo("iCPPS_Multi by DJ_MuTeD, original creators - iCPPS team\n");
		$this->oldt = time();
		$this->stats['memory']['old'] = 0;
		define("ATTRIB", "@attributes");
		if(isset($this->xmltypehandlers)) {
		$this->xmltypehandlers = @array_merge((Array)$this->xmldefaulttypehandlers, (Array)$this->xmltypehandlers);
		} else {
		$this->xmltypehandlers = @array_merge((Array)$this->xmldefaulttypehandlers, Array());
		}
		$this->ip = $config["ADDRESS"];
		$this->port = $config["PORT"];
		$this->zones = array();
		$this->log = new Logger;
		$this->clients = array();
		$this->config = $config;
		//declare(ticks = 100); // log every 50 ticks (low level instructions)
		register_tick_function(array($this, "log_memory"));
		$this->construct();
		$this->success = $this->initialise();
		$this->islogin = $isLogin;
	}

	public function initialise(){
		$this->mainSocket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP) or $this->log->error("Could not create socket. Please check php.ini to see if sockets are enabled!");
		socket_set_option($this->mainSocket, SOL_SOCKET, SO_REUSEADDR, 1);
		socket_set_nonblock($this->mainSocket);
		socket_bind($this->mainSocket, $this->config["ADDRESS"], $this->config["PORT"]) or $this->log->error("Could not bind to port. Make sure the port is over 1024 if you are using linux");
		socket_listen($this->mainSocket, 5);
		return true;
	}

	function run($clients = NULL){
		if($clients == NULL){ $clients = $this->clients; }
		$this->clients = $clients;
		unset($clients);
		updateStatus($this->serverID, Client::$num);
		$status = 0;
		while($status === 0)
			$status = $this->listenToClients();
		if($this->config["DEBUG"])
			echo "Fatal error: $status\n";
		$this->log->error("listenToClients() failed, error: $status");
		return $status;
	}

	function write($data, $sock, $flags = MSG_EOR){
		$data .= chr(0);
		$len = socket_send($sock, $data, strlen($data), $flags);
		return $len ? true : false;
	}

	public function listenToClients(){
		$this->torun++;
		if($this->torun > 199){
			$this->torun = 0;
			$this->cleanUp();
		}
		$sockets = $this->getSockets($this->clients) or $this->log->error("Could not get client array");
		$write = NULL;
		$except = NULL;
		$w_sec = rand(60,120);
		if (socket_select($sockets, $write, $except,  $w_sec) < 1){//Replaces $sockets with array of changed sockets
			$this->show_memory();
			return 0;
		}
		foreach($sockets as $key => &$s){
			if($s == $this->mainSocket){
				if($this->addClient() == -1) $this->log->error("Could not accept client, over MAX_CLIENT limit");
				continue;
			}
			$len = socket_recv($s, $recv, 8192, 0);
			if($len == false){
				$this->removeClientBySock($s);
				continue;
			}
			$recv = explode(chr(0), $recv);
			foreach($recv as $data){
				if($data == "")
					continue;
				$data .= chr(0);
				$this->parseData($data, $this->getClientIdFromSock($s));
			}
			unset($recv);
		}
		return 0;
	}

	function cleanUp(){
		
	}

	function parseData($str, $clientid){
		$this->onReceive($str);
		if(stripos($str, "<policy-file-request/>") !== false){ $this->sendPolicyFile($this->clients[$clientid]); }
		if($this->config["RAW_STR"] && $str[0] == $this->config["RAW_SEPERATOR"]) return $this->parseRawData($str, $clientid);
		$xmlar = @simplexml_load_string($str, 'SimpleXMLElement', LIBXML_NOCDATA);
		if(!$xmlar && stripos($str, "<policy-file-request/>")){
			$this->log->error("Malformed packet $str sent by $clientid");
			return;
		}
		$data = @json_decode(@json_encode((array) $xmlar),1);
		
		if(empty($data)) return -1;
		$t = $data[ATTRIB]["t"];
		$called = false;
		if(isset($this->xmltypehandlers[$t])){
			$a = $data["body"][ATTRIB]["action"];
			if(isset($this->xmltypehandlers[$t][$a])){
				$f = $this->xmltypehandlers[$t][$a];
				if(method_exists($this, $f)){
					$this->$f($data, $str, $clientid);
					$called = true;
				}
			}
		}
		if(!$called) $this->unknownHandler($data, $str, $clientid);
		return 0;
	}

	function parseRawData($data, $clientid){
		if(!is_object(@$this->clients[$clientid])){
			$this->log->error("Couldn't parse data \"$data\" from $clientid");
			return;
		}
		$this->clients[$clientid]->time = time();
		$d = explode($this->config["RAW_SEPERATOR"], $data);
		if($d[0] === ""){
			unset($d[count($d) - 1]);
			unset($d[0]);
			$d = array_values($d);
		}
		$zone = $d[0]; //Currently not used, all treated as if same zone!
		$called = false;
		if($d[1] == $this->config["SEND_HANDLER"] || !@is_array(@$this->handlers[$d[1]])){
			if($this->config["USE_SEND_HANDLER"]){
				if($d[1] == $this->config["SEND_HANDLER"]){
					if(isset($this->sendhandlers[$d[2]]) && @method_exists($this, $f = @$this->sendhandlers[$d[2]])){
						$this->$f($d, $data, $clientid);
						$called = true;
					}
				}
				else{
					if(@method_exists($this, @$f = @$this->handlers[$d[1]])){
						$this->$f($d, $data, $clientid);
						$called = true;
					}
				}
			}
		}
		else{
			if(!is_array(@$this->handlers[$d[1]]) && @method_exists($this, $f = @$this->handlers[$d[1]])){
				$this->$f($d, $data, $clientid);
				$called = true;
			}
			elseif(isset($this->handlers[$d[1]][$d[2]]) && @method_exists($this, $f = @$this->handlers[$d[1]][$d[2]])){
				$this->$f($d, $data, $clientid);
				$called = true;
			}
		}
		if(!$called){
			$this->unknownHandler($d, $data, $clientid);
		}
	}

	function unknownHandler($d, $data, $clientid){
		$this->log->log("Received unknown message from client $clientid, message: $data");
	}

	function getSockets($clients){
		$sockets = array();
		$sockets[0] = $this->mainSocket;
		foreach($clients as $key => $client){ $sockets[$key + 1] = $client->getSocket(); }
		$isn = false;
		foreach($sockets as $s){
			if($s){
				$isn = true;
				break;
			}
		}
		if($isn)
			return $sockets;
		$this->log->error("No sockets found in call to getSockets()!");
		return array();
	}

	function addClient($data = null){
		if(Client::$num >= $this->config["MAX_CLIENTS"]){
			socket_close(socket_accept($this->mainSocket));
			return -1;
		}
		for ($i = 0; $i < $this->config["MAX_CLIENTS"]; $i++) {
			if (!isset($this->clients[$i])) {
				$this->clients[$i] = new Client(socket_accept($this->mainSocket), $this, $i);
				socket_set_nonblock($this->clients[$i]->sock);
				//socket_set_option($this->clients[$i]->sock, SOL_SOCKET, SO_LINGER, 4);//Wait 4 seconds before closing a socket(After close)
				socket_set_option($this->clients[$i]->sock, SOL_SOCKET, SO_REUSEADDR, 1);//Allow address reuse
				$this->sendPolicyFile($this->clients[$i]);
				$this->log->log("Client created, ID:{$this->clients[$i]->uniqueid}, Socket ID: $i, rndK: {$this->clients[$i]->p['rndK']}");
				$this->onConnect($this->clients[$i]);
				return 0;
			}
		}
	}

	function sendPolicyFile($client){
		$client->write('<cross-domain-policy><allow-access-from domain="*" to-ports="'. $config["PORT"] .'"/></cross-domain-policy>');
	}

	function getClientIdFromSock($socket){
		foreach ($this->clients as $key => &$c){ if($c->sock === $socket){ return $key; }}
		return -1;
	}

	function removeClient($num){
		unset($this->clients[$num]);
	}

	function removeClientBySock($socket){
		foreach ($this->clients as $key => &$c){
			if($c->sock === $socket){
				unset($this->clients[$key]);
				$this->log->log("Client $key removed");
				return 0;
			}
		}
		return -1;
	}
}
?>
