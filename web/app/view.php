<?php

include_once ROOT . "/app/helper/h_place.php";

$params = sanitise($_REQUEST, array(
   'place' => NUMBER,
   'geograph_id' => NUMBER
));


//
// Has the user visited before? If not, set a cookie.
//

if(!$params['place'] && !$params['geograph_id'])
{
   // Doesn't return
   error_page(
      '400 Bad Request',
      'Error: Either <em>place</em> or <em>geograph_id</em> must be specified',
      'Have you followed a broken link? We\'re not sure what you\'re trying to look at.');
}


//
// Get a place
//

try
{
   if($params['place'])
   {
      $mySQL->query("select * from place where id={$params['place']}");
   }
   else
   {
      $mySQL->query("select * from place where geograph_uri like '%/{$params['geograph_id']}'");
   }
   
   if(!$mySQL->numRows())
   {
      error_page(
      '404 Not Found',
      'The specified place couldn\'t be found',
      'Have you followed a broken link? We can\'t find the place you\'re looking for.');
   }
   
   $place = $mySQL->fetchArray();
   
   $place['score'] = round($mySQL->singleValueQuery("select avg(rating) from vote where place={$place['id']}"), 1);
   $place['image_link'] = local_image($place['image_uri']);
   
   $mySQL->query("select rating from vote where place={$place['id']}");
   $place['votes'] = $mySQL->numRows();

   list($image_width, $image_height) = image_dims($place['image_uri']);  
}
catch(Exception $e)
{   
   error_page('500 Internal Server Error', 'Error: couldn\'t retrieve the place', 'A database error ocurred.' . $e->getMessage());
}


//
// Display
//

include VIEW_DIR . '/_view.php';

?>
