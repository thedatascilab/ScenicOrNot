<?php

function http_status($status)
{
   header("{$_SERVER['SERVER_PROTOCOL']} {$status}");
}

function dump($var)
{
   ?><pre><? print_r($var); ?></pre><?
}

function generate_uuid()
{
   return md5(uniqid('', true));
}

function error_page($status, $heading, $error)
{
   include ROOT . "/app/error.php";
   die();
}

?>
