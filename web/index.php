<?php

define('ROOT', dirname(__FILE__));

include ROOT . '/include/global.php';

$route = sanitise($_REQUEST, array(
   'action' => array(ENUM, array('home', 'rate', 'about', 'privacy', 'top10', 'view', 'rankings')),
   'format' => array(ENUM, array('html')),
), array(
   'action' => 'home',
   'format' => 'html',
));


// They're not allowed to unset format on purpose -- set it here, even if the query string has it empty
if(!$route['format'])
{
   $route['format'] = 'html';
}

define('VIEW_DIR', ROOT . "/view/{$route['format']}");

include ROOT . "/app/{$route['action']}.php";

?>
