<?php

include ROOT . "/app/helper/h_place.php";

//
// Work out some stats
//

$stats['total_rated'] = $stats['partially_rated'] = 0;

$mySQL->query("select place, count(place) as vote_count from vote group by place");
while($place = $mySQL->fetchObject())
{
   if($place->vote_count >= 3)
   {
      $stats['total_rated']++;
   }
   else
   {
      $stats['partially_rated']++;
   }
}

$stats['total_places'] = $mySQL->singleValueQuery("select count(*) from place");
$stats['total_votes'] = $mySQL->singleValueQuery("select count(*) from vote");
$stats['total_users'] = $mySQL->singleValueQuery("select count(distinct uuid) from vote");

// The percentage of images with 3 or more votes
$stats['percentage_rated'] = round($stats['total_rated'] / $stats['total_places'] * 100, 2);

// The percentage of images with votes 0 < v < 3
$stats['percentage_partial'] = round($stats['partially_rated'] / $stats['total_places'] * 100, 2);

// Total land mass of 229,334km obtained here: http://en.wikipedia.org/wiki/List_of_countries_and_outlying_territories_by_area
$stats['percentage_coverage'] = round($stats['total_places'] / 229334 * 100, 2);
 
 
// Get the distribution of scores

$stats['scores'] = array();

$mySQL->query('select rating, count(rating) as vote_count from vote group by rating');
while($vote = $mySQL->fetchObject())
{
   $stats['scores'][$vote->rating] = $vote->vote_count;
}

$graph_uri = "http://chart.apis.google.com/chart?&cht=lc&chs=650x450&chd=t:" . implode(',', $stats['scores']) . "&chtt=ScenicOrNot: Ratings+Distribution&chts=554433,13&chxs=0,FF9900,12,-1|1,FF9900,12,-1&chxr=0,0,10|1,0," . max($stats['scores']) . "&chxt=x,y&chxl=0:|1|2|3|4|5|6|7|8|9|10";


//
// Display
//

include VIEW_DIR . '/_rankings.php';

?>
