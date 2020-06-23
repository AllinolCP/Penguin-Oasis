<?php
class Logger{
	private static $instance;
	private $file;
	private $name;
	public static function getInstance(){
		if(!isset(self::$instance))
		self::$instance = new Logger();
		return self::$instance;
	}

	function __construct($file = false, $name = "../log.txt"){
		if(!isset(self::$instance)){
			self::$instance = $this;
			//$this->ircsocket = open;
		}
		$this->file = $file;
		$this->name = $name;
	}

	function error($message){
		if($this->file){ $this->logToFile($message); }
		echo "[xmlServ:" . Client::$num . "] [" . $this->date() ."] ".$message."\n";
		//$this->logToFile($message);
		$this->logToIRC($message);
	}

	function logToIRC($message){
		$message = "[xmlServ:" . Client::$num . "] [" . $this->date() ."] ".$message."\n";
		//fwrite($this->ircsocket, $message);
	}

	function log($message){
		if($this->file)
			$this->logToFile($message);
		else
			echo "[xmlServ:" . Client::$num . "] [" . $this->date() ."] ".$message."\n";
	}

	function screen($message){
		echo "[xmlServ] [". $this->date() ."] ".$message."\n";
	}

	function logToFile($message){
		$fh = fopen($this->name, "a");
		fwrite($fh, "[xmlServ] [". $this->date() ."] ".$message."\n") or die("Could not write to log file!");
		fclose($fh);
	}

	function date(){
		//return date('d-m-y H:i:s');
		return date('H:i:s');
	}
}

class console{
		var	$mode = 1;
		function setmode($mode){
		$this->mode = $mode;
		}

		function colourize($str, $colour = null){
		if($this->mode == 1 || $this->mode == 2){
		$strarr = str_split($str);
		foreach($strarr as $char){
				global $pclconfig;
				if($pclconfig["Graphics"]["effects"] == 1){
					if(@$colour == null){
						if($char != " ")
							$char = "\033[07;01;3" . rand(1, 6) . "m" . $char;
						else
							$char = "\033[00;4" . "9" . "m" . $char;
					}
					else{
						if($char != " ")
							$char = "\033[42;3" . $colour . "m" . $char;
						else
							$char = "\033[00m" . $char . "\033[00m";
					}
					if($this->mode == 2){
						echo $char;
						pusleep($this->wait);
					}
				}
				else{
					echo $char;
					pusleep($this->wait);
				}
		}
		$str = implode($strarr, "");
		if($this->mode != 2){
				if($pclconfig["Graphics"]["effects"] == 1)
				$str .= "\033[00;39;49m";
				return $str;
		}
		if($pclconfig["Graphics"]["effects"] == 1)
		echo "\033[00;39;49m";
		}
		else{
		$strarr = str_split($str);
		foreach($strarr as &$char){
				$char = "\033[07;01;3" . rand(1, 6) . "m" . $char;
		}
		$str = implode($strarr, "");
		//$str = str_replace("\033[00;39m", "", $str);
		$str .= "\033[00;39;49m";
		echo $str;
		}
		}

		function stribet($inputstr, $delimiterLeft, $delimiterRight) { // Returns substring of $inputstr between $delimiterLeft and $delimiterRight
		$posLeft = stripos($inputstr, $delimiterLeft) + strlen($delimiterLeft);
		$posRight = stripos($inputstr, $delimiterRight, $posLeft);
		return substr($inputstr, $posLeft, $posRight - $posLeft);
		}

		function movecursor($line, $column){
		echo "\033[{$line};{$column}H";
		}
		function erasescreen(){
		echo "\033[2J";
		}
		function hidecursor(){
		echo "\033[?25l";
		}
		function showcursor(){
		echo "\033[?25h";
		}
		function saveposition(){
		echo "\033[s";
		}
		function restoreposition(){
		echo "\033[u";
		}
}
?>
