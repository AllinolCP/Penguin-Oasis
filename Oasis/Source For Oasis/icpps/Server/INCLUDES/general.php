<?php
function halt($text = "Fatal error", $code = 1){
		fwrite(STDERR, "$text" . "\n");
		exit($code);
}
?>
