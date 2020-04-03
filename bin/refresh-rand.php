<?php

include "../web/prepend.php";
include ROOT . "/include/global.php";

ini_set('display_errors', 1);

echo date('r') . " Fetching places... \n";

//
// This is lots of queries instead of one big one
// so that the table doesn't get locked (and stop the
// site from working) while this update happens
//
$mySQL->query("select * from place where rand < 1");
$subMySQL = clone $mySQL;

echo date('r') . " Updating rand column\n";

while($place = $mySQL->fetchObject())
{
   if($place->votes > 3)
   {
      $rand = 1;
   }
   else
   {
      $rand = "rand()";
   }

   $subMySQL->query("update place set rand=$rand where id=$place->id");
   usleep(100000);
}


echo date('r') . " Done.\n";

?>
