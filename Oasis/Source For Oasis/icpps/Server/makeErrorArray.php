<?php
$lines = file_get_contents("errors.as");
$lines = explode("\n", $lines);

foreach($lines as $l){
	$l = trim($l);
	$l = str_replace("var ", 'define("', $l);
	$l = str_replace(" = ", '", ', $l);
	$l = str_replace(";", ');', $l);
	echo $l . "\n";
}
?>
