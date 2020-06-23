<?php
	//Workarounds
date_default_timezone_set(@date_default_timezone_get());//Prevents date errors. Change if necessary
	//End workarounds
error_reporting(E_ALL | E_STRICT);
function __autoload ($className){
	//var_dump($className);
    $fileName = "INCLUDES/".str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
    $status = require($fileName);

    if ($status === false) {
        eval(sprintf('class %s {function __construct(){die("Class %s could not be found in the INCLUDES directory}', $className, $className));
    }
}
require "INCLUDES/general.php";
(@include "config2.php") || halt("Failed to open config.php");
// Set time limit to indefinite execution
set_time_limit (0);

// Set the ip and port we will listen on

foreach($config as $key =>  $c){
	if($c === null){
		halt("Option <$key> has not been set, shutting down.\n");
	}
}
eval(`php ./makeErrorArray.php`);
$server = new ClubPenguin($config);
$server->serverID = 102;
$server->run();
?>
