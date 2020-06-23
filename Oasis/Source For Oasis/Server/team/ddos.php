<?php
$f = fopen('/root/ddos-' . time() . '.txt', 'w');
fwrite($f, shell_exec("netstat -anp |grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n"));
fclose($f);
?>