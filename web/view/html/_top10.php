<? head('', array('generic.css', 'top10.css')); ?>

<div id="side">
   <? header_box(); ?>
   </ul>
</div>

<div id="content">
   <div id="generic">
      <img src="assets/generic-top.jpg" alt="------------" />
      
      <h1>Leaderboard</h1>
      
      <p class="content">
         This page shows the current prettiest and ugliest places, according to your
         votes. It only uses the votes we've gathered so far, and that's only
         <?=$stats['percentage_rated'];?>% of the country &mdash; if you think that they're wrong, get voting!
      </p>
      
      <div id="top10">
         <? 
         $rank = 1;
         foreach($top as $place):         
            display_place($place, $rank++);
         endforeach; 
         ?>
      </div>
      <div id="bottom10">
         <? 
         $rank = 1;
         foreach($bottom as $place):         
            display_place($place, $rank++);
         endforeach; 
         ?>
      </div>
      
      
   </div>
   <img src="assets/generic-bottom.jpg" alt="------------" />
</div>

<? foot(); ?>
