<?php

//
// Pick a suitable place for the user to rate
//
// The place should:
//
//  - Not be one that the user has already seen
//  - Have been ranked between 1 and 3 times already
//
// If these criteria cannot be met, pick a random place
//

function pick_place($uuid)
{
   global $mySQL, $config;
   
   define('DEBUG', false);
   define('TRY_PARTIALS', true);
   $limit = 20;
   
   if(DEBUG) { echo "<pre>"; }
   if(DEBUG && TRY_PARTIALS) { echo "Trying to get a partial\n"; }

   
   //
   // Pick a random place with less than 3 votes
   //
   
   for($k=1; $k<=$limit; $k++)
   {
      $rand = rand(1, $config['site']['place_count']);
      
      $mySQL->query("
         select 
            *, (select count(*) from vote where place=place.id) as vote_count
         from place 
         where 
                id=$rand
            and id not in (select place from vote where uuid='$uuid')
      ", DEBUG);
      
      $place = $mySQL->fetchObject();
      
      if(DEBUG) { print_r($place);} 
      
      if($place && $place->vote_count <= 3 && (!TRY_PARTIALS || $place->vote_count > 0)) 
      {
         if(DEBUG) { echo "Got place < 3 votes\n"; }
         
         return $place;
      }
   }
   
   
   //
   // If that didn't work, just pick a random place the user hasn't seen
   //
   
   for($k=1; $k<=$limit; $k++)
   {
      $rand = rand(1, $config['site']['place_count']);
      
      $mySQL->query("
         select *
         from place 
         where 
                id=$rand 
            and id not in (select place from vote where uuid='$uuid')
      ", DEBUG);
      
      $place = $mySQL->fetchObject();
      
      if($place) 
      {
         if(DEBUG) { echo "Got unseen place\n"; print_r($place); }
         return $place;
      }
   }
   
   
   //
   // If they've already seen everything (!) just pick a place at random.
   //
   
   for($k=1; $k<=$limit; $k++)
   {
      $rand = rand(1, $config['site']['place_count']);
      
      $mySQL->query("
         select * 
         from place 
         where id=$rand 
      ", DEBUG);
      
      $place = $mySQL->fetchObject();
      
      if($place) 
      {
         if(DEBUG) { echo "Got random place\n"; print_r($place); }
         return $place;
      }
   }

   //
   // And if that didn't work, something broke.
   //
   if(!$mySQL->numRows())
   {
      if(DEBUG) { echo "Got nothing.\n"; }
      throw new Exception("Unable to find a place");
   }
  
   return false;
}

function local_image($image_uri)
{
   global $config;
   
   $img_path = str_replace('http://www.geograph.org.uk/geophotos', '', $image_uri);
   $img_dir = substr($img_path, 0, strrpos($img_path, '/'));
   
   if(!file_exists($config['site']['image_sysdir'] . $img_path))
   {
      if(!file_exists($config['site']['image_sysdir'] . $img_dir))
      {        
         if(!mkdir($config['site']['image_sysdir'] . $img_dir, 0777, true))
         {
            error_page('500 Internal Server Error', 'Unable to create image directory', 'Couldn\'t create a directory to cache this image. The server is probably misconfigured (is the directory writeable?)');
         }
      }
      
      if(!copy($image_uri, $config['site']['image_sysdir'] . $img_path))
      {
         return false;
//         error_page('500 Internal Server Error', 'Unable to retrieve image from Geograph', 'Either the image no longer exists at Geograph, or the server is misconfigured (is the directory writeable?)');
      }
   }
   
   return $config['site']['image_webdir'] . $img_path;
}

function image_dims($image_uri)
{
   global $config;
   
   $img_path = str_replace('http://www.geograph.org.uk/geophotos', '', $image_uri);
   $img_dir = substr($img_path, 0, strrpos($img_path, '/'));
   
   if(!file_exists($config['site']['image_sysdir'] . $img_path))
   {
      return 0;
   }
   
   $dims = getimagesize($config['site']['image_sysdir'] . $img_path);
   
   $image_width = $dims[0];
   $image_height = $dims[1];
   
   $factor = $image_width / 450;
   
   $image_width = 450;
   $image_height = round($image_height/$factor);
   
   return array($image_width, $image_height);
}

function make_auth($place, $token)
{
   global $config;
   
   return hash('ripemd160', $config['site']['secret'] . $place . $token);
}
?>
