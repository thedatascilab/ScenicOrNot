<?php

include "../prepend.php";

include ROOT . "/include/global.php";

echo date('r') . " Getting a list of places\n";

$mySQL->query("select place as id, count(place) as vote_count from vote group by place\n");

echo date('r') . " Updating vote count for " . $mySQL->numRows() ." places\n";

$subMySQL = clone $mySQL;
$subMySQL->query("update place set votes=0");

while($place = $mySQL->fetchObject())
{
   $subMySQL->query("update place set votes=$place->vote_count where id=$place->id");
}

echo date('r') . " Fin.\n";
?>
