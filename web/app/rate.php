<?php

include_once ROOT . "/app/helper/h_place.php";

$params = sanitise($_REQUEST, array(
   'uuid' => STRING_ENCODED,
   'token' => STRING_ENCODED,
   'auth' => STRING_ENCODED,
   'place' => NUMBER,
   'rating' => NUMBER,
   'rating_1_x' => NUMBER,
   'rating_2_x' => NUMBER,
   'rating_3_x' => NUMBER,
   'rating_4_x' => NUMBER,
   'rating_5_x' => NUMBER,
   'rating_6_x' => NUMBER,
   'rating_7_x' => NUMBER,
   'rating_8_x' => NUMBER,
   'rating_9_x' => NUMBER,
   'rating_10_x' => NUMBER,
));


//
// We could put some anti-abuse code here, one day. Eg:
//
//  - Don't permit loads of votes on one place in too short a period
//  - Don't permit loads of votes from one uuid in too short a period
//  - Look at originating IP, user agent, etc, and see if it looks like 
//    lots of uuids are coming from one place
//
// For now, let's just assume that everyone's playing nice.
//


//
// They haven't sent back a cookie. Bad.
//

if(!$params['uuid'])
{
   // Doesn't return
   error_page(
      '400 Bad Request',
      'Error: <em>uuid</em> is a required parameter',
      'Have you enabled cookies for this site? ScenicOrNot requires cookies to be enabled.');
}


//
// These are both wtf errors -- someone's probably messing about.
//

if(!$params['place'])
{
   // Doesn't return
   error_page(
      '400 Bad Request',
      'Error: <em>place</em> is a required parameter',
      'We couldn\' tell which place you want to rate.');
}

if(!$params['token'])
{
   // Doesn't return
   error_page(
      '401 Unauthorized',
      'Error: <em>token</em> is a required parameter',
      'We need it to stop people cheating!');
}


if(!$params['auth'])
{
   // Doesn't return
   error_page(
      '401 Unauthorized',
      'Error: <em>auth</em> is a required parameter',
      'We need it to stop people cheating!');
}


if(!$params['rating'])
{
   //
   // If no rating is specified, check to see which input image was clicked
   //
   
   for($i = 1; $i <= 10; $i++)
   {
      if($params["rating_{$i}_x"] != '')
      {
         $params['rating'] = $i;
         
         break;
      }
   }
   
   
   //
   // Did we get anything?
   //
   
   if(!$params['rating'])
   {
      // Doesn't return
      error_page(
         '400 Bad Request',
         'Error: <em>rating</em> is a required parameter',
         'Without it, we don\'t know how scenic you think the place is.');
   }
}

//
// Find the place
//

try
{
   $mySQL->query("select * from place where id={$params['place']}");
   $place = $mySQL->fetchObject();
}
catch(MySQLException $e)
{
   // Doesn't return
   error_page(
      '500 Internal Server Error',
      'Error: We couldn\'t fetch the place',
      'A database error ocurred.');
}

if(!$place)
{
   // Doesn't return
   error_page(
      '404 Not Found',
      'Error: The specified place was not found',
      'We couldn\'t find a place with that ID');
}


//
// Check that they've supplied an authorised place
//

$auth = make_auth($params['place'], $params['token']);


if($params['auth'] != $auth)
{
   // Doesn't return
   error_page(
      '403 Forbidden',
      'Error: The supplied authorisation hash is not valid',
      '');
}


//
// Create the vote
//

try
{
   //
   // Only record their vote if they haven't rated this place already
   //
   
   $mySQL->query("select id from vote where uuid='{$params['uuid']}' and place={$place->id}");
   if(!$mySQL->numRows())
   {
      //
      // Insert the vote, and update the vote count
      //
      
      $mySQL->query("insert into vote(place, uuid, rating, token, ip, user_agent) values({$place->id}, '{$params['uuid']}', {$params['rating']}, '{$params['token']}', '{$_SERVER['REMOTE_ADDR']}', '" . addslashes($_SERVER['HTTP_USER_AGENT']) . "')");
      
      if(!$mySQL->affectedRows())
      {
         // Doesn't return              
         error_page('500 Internal Server Error', 'We tried to record your vote, but it didn\'t work', 'A database error ocurred.');
      }
      else
      {
         //$mySQL->query("update place set votes=votes+1 where id={$place->id}");

         $mySQL->query("select * from vote where place=$place->id");
         $place->votes = $mySQL->numRows();
      }
   }
}
catch(MySQLException $e)
{
   // Doesn't return
   error_page('500 Internal Server Error', 'Error: We couldn\'t record your vote', 'A database error ocurred.');
}

//
// Save this place, and its current rating, for display in the view
//

$rated_place = $place;
unset($place);

$rated_image_link = local_image($rated_place->image_uri);

try
{
   $average_rating = round($mySQL->singleValueQuery("select avg(rating) from vote where place={$rated_place->id}"), 1);
}
catch(MySQLException $e)
{
   // Doesn't return
   error_page('500 Internal Server Error', 'Error: we couldn\'t get the place\'s current rating', 'A database error ocurred.');
}





//
// Move to home
//

include ROOT . "/app/home.php";

?>
