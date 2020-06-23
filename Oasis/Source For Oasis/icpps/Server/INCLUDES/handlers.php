<?php
function handleReceive($data = NULL, $client = -1, $type = "str"){
	if($data === NULL || ($data != NULL && func_num_args() > 3)){
		$data = func_get_args();
		$client == shift($data);
	}
}
?>
