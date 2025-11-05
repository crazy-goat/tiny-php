<?php
if (($_SERVER['SCRIPT_NAME'] ?? '/') === '/info') {
   phpinfo();
   exit;
}
die('Hello world!');

