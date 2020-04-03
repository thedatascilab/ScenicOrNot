<?php

include ROOT . "/app/helper/h_place.php";
include ROOT . "/app/helper/h_top10.php";

function get_places($places)
{
   global $mySQL;
   
   foreach($places as $place_id => $ranking)
   {
      if (!$place_id) continue;
      $mySQL->query("select * from place where id=$place_id");
      $place = $mySQL->fetchArray();
         
      $places[$place_id] = $place;
      $places[$place_id]['score'] = $ranking;
      $places[$place_id]['image_link'] = local_image($places[$place_id]['image_uri']);

      $mySQL->query("select * from vote where place=$place_id");
      $places[$place_id]['votes'] = $mySQL->numRows();
   }

   return $places;
}

$stats = array('total_rated' => 0);
$mySQL->query("select place from vote group by place having count(place)>=3");
while($place = $mySQL->fetchObject()) {
   $stats['total_rated']++;
}

$top = $bottom = array();
$num = 5;

$mySQL->query("select place, count(place) as vote_count, avg(rating) as score from vote group by place having score=1 and vote_count>=3 order by vote_count desc limit $num");
while($place = $mySQL->fetchObject()) {
    $bottom[$place->place] = round($place->score, 1);
}
$bottom = get_places($bottom);

$mySQL->query("select place, count(place) as vote_count, avg(rating) as score from vote group by place having score>9 and vote_count>=3 order by score desc, vote_count desc limit $num");
while($place = $mySQL->fetchObject()) {
    $top[$place->place] = round($place->score, 1);
}
$top = get_places($top);

//
// Work out some stats
//

$stats['total_places'] = $config['site']['place_count'];
$stats['total_votes'] = $mySQL->singleValueQuery("select count(*) from vote");

// The percentage of images with 3 or more votes
$stats['percentage_rated'] = round($stats['total_rated'] / $stats['total_places'] * 100, 2);

// Total land mass of 229,334km obtained here: http://en.wikipedia.org/wiki/List_of_countries_and_outlying_territories_by_area
$stats['percentage_coverage'] = round($stats['total_places'] / 229334 * 100, 2);

//
// Go to view
//

include VIEW_DIR . "/_top10.php";

?>
