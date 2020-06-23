<?php
class ClientBase{
	static $num = 0;
	static $count = 0;
	public $properties = array();
	public $p = null;
	public $sock;
	public $parent;
	public $room;
	public $uniqueid = 0;
	public $inGame = false;
	public $xpos = 0;
	public $ypos = 0;
	public $clientID = 0;
	public $name = "";

	function __construct($sock, $server, $clientid){
		self::$num++;
		self::$count++;
		$this->parent =& $server;
		$this->uniqueid = self::$count;
		$this->sock = $sock;
		$this->p =& $this->properties;//p and properties are for temporary properties.
		$this->p['rndK'] = $this->makeRndK();
		$this->clientID = $clientid;
	}
	
	/*function __destruct(){
		self::$num--;
		@socket_close($this->sock);
	}*/

	function write($data, $flags = null){
		$data .= chr(0);
		$sendLen = strlen($data);
		$len = @socket_send($this->sock, $data, $sendLen, null);
		return $len ? true : false;
	}
	function makeRndK(){
		$c = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxwz0123456789?~{}[]|_";
		$l = rand(6,14);
		$s = "";
		for(;$l > 0;$l--)
			$s .= $c{rand(0,strlen($c) - 1)};
		return $s;
	}

	function buildClientString($type = "raw", $s = "%"){
		if($type == "xml"){
			return $this->buildXmlPlayer();
		}
		return $this->buildRawPlayer($s);
	}

	function getSortedProperties(){
		
	}

	function buildRawPlayer($s){
		return implode($this->getSortedProperties(), $s);
	}

	function getSocket(){
		return $this->sock;
	}
}
?>
