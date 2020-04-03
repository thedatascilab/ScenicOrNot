<?php

//
// Global includes
//

include ROOT . '/config.php';
include ROOT . '/include/mysql.class.php';
include ROOT . '/include/sanitise.php';
include ROOT . '/include/functions.php';
include ROOT . '/include/pagefunctions.php';


//
// Connect to MySQL
//

$mySQL = new MySQL($config['mySQL']['server'], $config['mySQL']['username'], $config['mySQL']['password'], $config['mySQL']['database']); 


error_reporting(E_ALL);

?>
