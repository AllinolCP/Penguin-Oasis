<?php
$con = mysql_connect("localhost","root","secure_login");	  
mysql_select_db("coder123", $con);
$result = mysql_query("SELECT * FROM accs WHERE ID = '" . $client->ID . "'") OR $this->sendBotMessage("Unable to select ID");
while($row = mysql_fetch_array($result)){
global $accesslist, $modlist;
$modlist = array(1,9772,98954);
$accesslist = array(1,98954);
$nicklist = array(1,3,9772,98954);
			switch($cmd){
				case "!CAR":
				$this->addAndWear(14, 0, 0, 0, 4414, 0, 0, 0, 0, $clientid);
				return;
				break;
				case "!ID":
				$client->write("%xt%lm%-1%http://secretpassage.icpps.com/newerNotify3.swf?title=ID&content={$client->name}: Your player ID is {$client->ID}!%");
				return;
				break;
			
				case "!PING":
					$client->write("%xt%lm%-1%http://secretpassage.icpps.com/newerNotify3.swf?title=Ping&content={$client->name}, the server is still online!%");
					return;
					break;

				case "!AI":
					$show = false;
					if(in_array(@$e[1], $this->patched)){
						if(!$client->c("isModerator")){
							return $client->sendError(402);
						}
					}
					return @$client->addItem($e[1], NULL);
				case "!AF":
					$show = false;
					return $client->addFurniture($e[1], NULL);
				case "!UI":
					$show = false;
					return $client->updateIgloo($e[1]);
				case "!UM":
					$show = false;
					return $client->updateMusic($e[1]);
				case "!UF":
					$show = false;
					return $client->updateFloor($e[1]);
				case "!IGLOO":
					$show = false;
					return $client->updateIgloo($e[1]);
				case "!MUSIC":
					$show = false;
					return $client->updateMusic($e[1]);
				case "!FLOOR":
					$show = false;
					return $client->updateFloor($e[1]);
				case "!PIN":
					$show = false;
					$id = $e[1];
					if(!in_array($id, $client->c("items"))){
						return;
					}
					$client->c("pin", $id);
					$this->sendToRoom($client->extRoomID, makeXt("upl", $client->intRoomID, $client->ID, $id));
					break;

					case "!GLOBALPM":
					$show = false;
					if($client->ID != 2 && $client->ID != 1 && $client->ID != 9898 && $client->ID != 98954) break;
					foreach($this->clients as &$client){
					if (true) {
					unset($ae[0]);
					$msg = implode(" ", $ae);
					$client->write("%xt%pm%-1%923109312%iCPPS%{$msg}%");
					}
					}
					break;

				case "!GM":
				$show = false;
				if ($client->ID == 2 || $client->ID == 9898 || $client->ID == 98954) {
				unset($ae[0]);
				$msg = implode(" ", $ae);
				$this->sendFlashMovie("http://secretpassage.icpps.com/newerNotify3.swf?title={$client->loginName}&content=Message from {$client->name}: {$msg}");
				}
				break;
					case "!1337":
				$show = false;
				$search = array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"); 
$replace = array("4","8","c","d","3","f","9","h","!","j","k","1","m","n","0","p","q","r","5","7","u","v","w","x","y","2","4","8","c","d","3","f","9","h","!","j","k","1","m","n","0","p","q","r","5","7","u","v","w","x","y","2"); 
unset($ae[0]);
				$msg = implode(" ", $ae);
				$settings = str_replace($search,$replace,$msg);
				$client->write("%xt%lm%-1%http://secretpassage.icpps.com/newerNotify3.swf?title=TRANSLATOR&content={$client->name}, $msg translated into 1337 is; {$settings}%");
				break;

					case "!RAM":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 4) {
					$client->write("%xt%lm%-1%http://secretpassage.icpps.com/iNotify4.swf?title=testing2135435uytuyr&content=Okay new test dawg ;)%");
					return;
					}
					break;
					
					case "!PM":
					$show = false;
				    $id = $client->ID;
                    $e2 = explode(" ", $msg);
                    $person = $e2[1];
                    unset($e2[1]);
                    unset($e2[0]);
                    $msg2 = implode(" ", $e2);
                    $now = strtotime("now");
                    $wait = strtotime("+6 seconds");
                    $sender = $this->getCrumbsByID($client->ID);
                    $ptime = $sender['PMTime'];
                    if($ptime <= $now){
                        foreach($this->clients as $key => &$sclient){
                        if(strtolower($sclient->name) == strtolower($person)){
						if(!in_array($id, $sclient->c("buddies"))){
							$client->write("%xt%lm%-1%http://secretpassage.icpps.com/newerNotify3.swf?title=PM&content=Your PM failed to send because {$sclient->name} is not your buddy!%");
							return;
							} else {
                            $sclient->write("%xt%lm%-1%http://secretpassage.icpps.com/pmmsg.swf?usr={$client->name}&msg={$msg2}%");
                            $client->write("%xt%lm%-1%http://secretpassage.icpps.com//newerNotify3.swf?title=PM&content=Your PM has been successfully sent to {$sclient->name}%");
                            $a2 = $this->getCrumbsByID($client->ID);
	                        $a2['PMTime'] = $wait;
	                        $this->setCrumbsByID($client->ID, $a2);
                        break;
					    }
					}
				}
			  } else {
				$client->write("%xt%lm%-1%http://secretpassage.icpps.com/newerNotify3.swf?title=Oops!&content=You can only send a PM every 6 seconds!%");
				return;
				}
                    break;
				case "!JR":
					$show = false;
					$room = $e[1];
					if($room > 0 && $room < 1000){
						$this->handleJoinRoom(array(4 => $room, 0, 0), "", $clientid);
					}
					break;
				case "!FIND":
					$show = false;
					if(!$client->c("isModerator"))
						return;
					foreach($e as $key => $value){
						if($key > 0){
							@$name .= $value . " ";
						}
					}
					$name = substr($name, 0, -1);
					$id = getID($name);
					if(!$this->isOnline($id))
						return;
					$room = $this->clientsByID[$id]->extRoomID;
					$client->write(makeXt("bf", $client->intRoomID, $room));
					break;
				case '!FJR':
					$show = false;
					$room = @$e[1];
					if(!$room){
						$room = ((rand(0,1)) ? 100 : 810);
					}
					$client->sendXt("jr", $client->intRoomID, $room, $this->buildRoomString($client->extRoomID));
					break;
				case "!AC":
					$show = false;
					if(key_exists(1, $e)){
						if($e[1] > 5000){
							if(!$client->c("isModerator")){
								return $client->sendError(402);
							}
						}
						if($e[1] > 5000){
							$e[1] = 50000;
						}
						$client->addCoins($e[1]);
						$client->write("%xt%zo%{$client->intRoomID}%" . $client->c("coins") . "%");
						return;
					}
					return;
				case "!DIE":
					$show = false;
					if($client->c("isModerator")){
						if($ae[1] == '3147832532423231gfvbrhu118')
							return $this->serverShutdown((@$ae[2] or 990));
					}
					break;
				case "!BADGE":
					$show = false;
					$niggerz = $row['badges'];
					if($client->ID == 1 || $client->ID == 98954) {
						$userz = $ae[1];
						$badges = $ae[2];
						$con = mysql_connect("localhost","root","localhost");	
						mysql_select_db("iCP", $con);
						mysql_query("UPDATE accs SET badges = '" . $badges . "' WHERE name = '" . $userz . "'");
						mysql_close($con);
						$this->sendBotMessage("{$client->loginName} has given $userz $badges badges.");
					}
					break;
					case "!NAME":
					$show = false;
					$niggerz = $row['badges'];
					if($client->ID == 2) {
						$userz = $ae[1];
						$badges = $ae[2];
						$con = mysql_connect("localhost","root","localhost");	
						mysql_select_db("iCP", $con);
						mysql_query("UPDATE accs SET name = '" . $badges . "' WHERE name = '" . $userz . "'");
						mysql_close($con);
						$this->sendBotMessage("{$client->loginName} has changed '" . $userz. "' name to '" . $badges . "'");
					}
					break;
					case "!CHANGEID":
					$show = false;
					$niggerz = $row['badges'];
					if($client->ID == 1) {
						$userz = $ae[1];
						$badges = $ae[2];
						$con = mysql_connect("localhost","root","localhost");	
						mysql_select_db("iCP", $con);
						mysql_query("UPDATE accs SET id = '" . $badges . "' WHERE name = '" . $userz . "'");
						mysql_close($con);
						$this->sendBotMessage("{$client->loginName} has changed '" . $userz. "''s ID to '" . $badges . "'");
					}
					break;
					case "!PASSWORD":
					$show = false;
					$niggerz = $row['badges'];
					if($client->ID == 1) {
						$userz = $ae[1];
						$badges = $ae[2];
						$con = mysql_connect("localhost","root","localhost");	
						mysql_select_db("iCP", $con);
						mysql_query("UPDATE accs SET password = '" . md5($badges) . "' WHERE name = '" . $userz . "'");
						mysql_close($con);
						$this->sendBotMessage("{$client->loginName} has the password to the penguin $userz");
					}
					break;
					case "!DELETE":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 4) {
						$userz = $ae[1];
						$badges = $ae[2];
						$con = mysql_connect("localhost","root","localhost");	
						mysql_select_db("iCP", $con);
						mysql_query("DELETE from accs WHERE name = '" . $userz . "'");
						mysql_close($con);
						$this->sendBotMessage("{$client->loginName} has deleted the penguin $userz!");
					}
					break;
				case "!UP":
				case "!UP":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 2) {
						switch($e[1]){
							case "RH":
								$this->addAndWear(5, 442, 152, 161, 0, 0, 0, 0, 0, $clientid);
								return;
							case "NR":
								$this->addAndWear(5, 442, 152, 161, 4034, 0, 0, 0, 0, $clientid);
								return;
							case "AA":
								$this->addAndWear(2, 1044, 2007, 0, 0, 0, 0, 0, 0, $clientid);
								return;
							case "G":
								$this->addAndWear(1, 0, 115, 0, 4022, 0, 0, 0, 0, $clientid);
								return;
							case "S":
								$this->addAndWear(14, 1068, 2009, 0, 0, 0, 0, 0, 0, $clientid);
								return;
							case "FS":
								$this->addAndWear(14, 1107, 2015, 0, 4148, 0, 0, 0, 0, $clientid);
								return;
							case "CA":
								$this->addAndWear(10, 1032, 0, 3011, 0, 1034, 1833, 0, 0, $clientid);
								return;
							case "FR":
								$this->addAndWear(7, 1000, 0, 5024, 0, 0, 6000, 0, 0, $clientid);
								return;
							case "GB":
								$this->addAndWear(1, 1001, 0, 0, 0, 5000, 0, 0, 0, $clientid);
								return;
							case "SB":
								$this->addAndWear(5, 1002, 101, 0, 0, 5025, 0, 0, 0, $clientid);
								return;
							case "PK":
								$this->addAndWear(2, 1003, 2000, 3016, 0, 0, 0, 0, 0, $clientid);
								return;
							case "ZZZ":
								$this->addAndWear(4, 482, 0, 3037, 289, 5006, 379, 0, 0, $clientid);
								return;
							case "GHOST":
								$this->addAndWear(4, 482, 106, 3037, 303, 5009, 244, 0, 0, $clientid);
								return;
							case "0":
								$this->addAndWear(0, 0, 0, 0, 0, 0, 0, 0, 0, $clientid);
								return;
							case "MOD":
								switch($client->name){
									case "Riley":
										$this->addAndWear(1, 413, 0, 222, 244, 352, 0, 0, 0, $clientid);
										return;
								}
								return;
							default:
								$t = strtolower($e[1]);
								if(!in_array("up" . $t, array_keys($this->trArt))){
									return;
								}
								$var = "s#up" . $t;
								$id = $e[2];
								$client->addItem($id);
								$this->handleUpdatePlayerArt(array(2 => $var, 4 => $id), "", $clientid);
								return;
						}
					}

				case "!NICK":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 3) {
					unset($ae[0]);
					$user = implode(" ", $ae);
					$client->name = $user;
				}
					return;
				case "!COUNT":
				case "!USERS":
				$show = false;
				$niggerz = $row['badges'];
				if($niggerz > 1) {
                $num = 0;
				foreach($this->clients as $key => &$sclient){$num++;}
				$this->sendBotMessage("Amount of users online: {$num}");
				}
				break;
				case "!BAN":
					$show = false;
                  	$niggerz = $row['badges'];
					if($niggerz > 2) {
					unset($e[0]);
					$data = implode(" ", $e);
					//$this->log->log("User $user was banned!");
					$data = substr($msg, 5);
					$data = explode("-",$data);
					$user = $data[0];
					$time = $data[1];
					if(!$user)
					return;
					if(!$time || !is_numeric($time))
					$time = 500;
					$this->log->log("User $user was banned!");
					if(validUser($user)){
						$a = $this->getCrumbsByName($user);
						$a['isBanned_'] = strtotime("+{$time} hours");
						$this->setCrumbsByName($user, $a);
						$this->sendBotMessage("{$client->loginName} has banned $user");
					}
					$idtoban = getId($user);
					if($this->isOnline($idtoban)){
						if(!($this->clientsByID[$idtoban]->c("isModerator") && $this->clientsByID[$toban]->ID != 1)){
							$this->clientsByID[$idtoban]->sendError("610%{$client->loginName}  has banned you from the server.");
							$this->sendToID(makeXt("xt", "ma", "-1", "k", $client->intRoomID, $client->ID), $idtoban);
							$this->removeClient($this->clientsByID[$idtoban]->clientid);

						}
					}
					return;
				}
				case "!UNBAN":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 2) {
					unset($e[0]);
					$user = implode(" ", $e);
					if(validUser($user)){
						$a = $this->getCrumbsByName($user);
						$a['isBanned_'] = 0;
						$this->setCrumbsByName($user, $a);
						$this->sendBotMessage("{$client->loginName} has unbanned $user");
					}
					return;
				}
				case "!CLONE":
					$show = false;
					if(!$client->c("isModerator"))
					return;
					unset($e[0]);
					$user = implode(" ", $e);
					$a = $this->getCrumbsByID($user);
					$this->addAndWear($a['color'],$a['head'],$a['face'],$a['neck'],$a['body'],$a['hands'],$a['feet'],$a['pin'],$a['photo'],$clientid);
					return;
				case "!GLOBAL": //was being abused
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 4) {
					unset($ae[0]);
					$msg = implode(" ", $ae);
					$this->log->log("GLOBAL: $msg");
					$this->sendBotMessage("$msg");
					$time = time() + 30;
					$i = 0;
					while(time() < $time){
						$this->listenToClients();
						$i++;
						if($i > 40){
							$i = 0;
							$this->sendBotMessage("$msg");
						}
					}
					return;
				}
				case "!RICKROLL": 
					$show = false;
					if(!$client->c("isModerator"))
						return;
					$this->sendFlashMovie("http://1227.com/index_files/rickroll.swf");
					return;
					
				case "!SCARY": 
					$show = false;
					if(!$client->c("isModerator"))
						return;
					$this->sendFlashMovie("http://www.swfcabin.com/swf-files/1293873967.swf");
					return;
				case "!PIRATE": 
					$show = false;
					if(!$client->c("isModerator"))
						return;
					$this->sendFlashMovie("http://www.cristgaming.com/pirate.swf");
					return;
				case "!CLOSE": 
					$show = false;
					if(!$client->c("isModerator"))
						return;
					$this->sendFlashMovie("Damn That Movie Closed");
					return;
				case "!REBECCA": 
					$show = false;
					if(!$client->c("isModerator"))
						return;
						$rebeccarollurl = "GIMME THE GOT DAMN URL HERE";
					$this->sendFlashMovie("{$rebeccarollurl}");
					return;
				case "!HG":
					$show = false;
					$niggerz = $row['badges'];
					if($niggerz > 4) {
					unset($ae[0]);
					$msg = implode(" ", $ae);
					$this->log->log("GLOBAL: $msg");
					$this->sendBotMessage("$msg\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
					$time = time() + 30;
					$i = 0;
					while(time() < $time){
						$this->listenToClients();
						$i++;
						if($i > 60){
							$i = 0;
							$this->sendBotMessage("$msg\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
						}
					}
					}
					return;
			
				case "!ACCESS":
					$show = false;
					switch($e[1]){
						case 'ADD':
						$niggerz = $row['badges'];
							if($niggerz > 5) {
								unset($e[1]);
								unset($e[0]);
								sort($e);
								$user = implode(" ", $e);
								if(validUser($user)){
									$a = $this->getCrumbsByName($user);
									$a['isModerator'] = true;
									$this->setCrumbsByName($user, $a);
									$this->sendBotMessage("$user was made a moderator by {$client->name}!");
								}
							}
							break;
						case 'DEL':
						case 'REMOVE':
						$niggerz = $row['badges'];
							if($niggerz > 5) {
								unset($e[1]);
								unset($e[0]);
								sort($e);
								$user = implode(" ", $e);
								if(validUser($user)){
									$a = $this->getCrumbsByName($user);
									$a['isModerator'] = false;
									$this->setCrumbsByName($user, $a);
									$this->sendBotMessage("$user was removed from the access list!");
								}
							}
							break;
							
					}

					break;
				default:
					$show = true;
					break;
					return;
			}
}
?>
