<?php

function display_place($place, $rank)
{
   ?>
   <div class="place">
      <img class="rank_no" src="assets/rank-<?=$rank;?>.png" alt="<?=$rank;?>." />
      
      <a href="view-<?=$place['id'];?>-<?=preg_replace('/\W+/', '-', $place['title']);?>">
         <img src="<?=$place['image_link'];?>" alt="<?=$place['title'];?>" />
      </a>
      
      <div class="place_text">
         <strong><?=$place['title'];?></strong> 
         (<a target="_new" href="http://www.bing.com/maps/default.aspx?v=2&amp;mapurl=<?=$place['geograph_uri'];?>.kml">map</a>)
         <p>
            Rating: <strong><?=$place['score'];?></strong> 
            <small>(from <?=$place['votes'];?> vote<?=($place['votes'] == 1 ? '' : 's');?>)</small>
         </p>
      </div>
   </div>
   <?
}

