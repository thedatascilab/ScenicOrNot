<? head('', array('home.css'), array('prototype-1.6.js', '_home.js')); ?>

<div id="side">
   <? header_box(); ?>
   
   <li id="rated_place_wrap">
      <div id="rated_place">
         <img src="assets/rated-board-top.jpg" alt="-----------" />
         
         <? if(isset($rated_place)): ?>
            <div id="rated_picture">
               You've just rated:
               <img src="<?=$rated_image_link;?>" width="150" alt="<?=$rated_place->title;?>" />
            </div>
            
            <div id="rating">
            <strong><?=$rated_place->title;?></strong> (<a target="_new" href="http://www.bing.com/maps/default.aspx?v=2&amp;mapurl=<?=$rated_place->geograph_uri;?>.kml">map</a>)
               <p>
                  Rating: <strong><?=$average_rating;?></strong> <small>(from <?=$rated_place->votes;?> vote<?=($rated_place->votes == 1 ? '' : 's');?>)</small>
               </p>
            </div>
            <? else: ?>
            <div id="intro">
               ScenicOrNot helps you to explore every corner of 
               England, Scotland and Wales, all the while 
               comparing your aesthetic judgements with fellow 
               players.           
            </div>
         <? endif; ?>
      </div>
      <img src="assets/rated-board-bottom.jpg" alt="------------" />
   </li>
   </ul>
</div>

<div id="content">
   <div id="rate">
      <form id="rate_form" action="/" method="post">
      <div>
         <img id="not" src="assets/not-scenic.jpg" alt="Not Scenic" />
      
         <input class="rating_btn" type="image" name="rating_1" src="assets/1.jpg" />
         <input class="rating_btn" type="image" name="rating_2" src="assets/2.jpg" />
         <input class="rating_btn" type="image" name="rating_3" src="assets/3.jpg" />
         <input class="rating_btn" type="image" name="rating_4" src="assets/4.jpg" />
         <input class="rating_btn" type="image" name="rating_5" src="assets/5.jpg" />
         <input class="rating_btn" type="image" name="rating_6" src="assets/6.jpg" />
         <input class="rating_btn" type="image" name="rating_7" src="assets/7.jpg" />
         <input class="rating_btn" type="image" name="rating_8" src="assets/8.jpg" />
         <input class="rating_btn" type="image" name="rating_9" src="assets/9.jpg" />
         <input class="rating_btn" type="image" name="rating_10" src="assets/10.jpg" />       
         
         <img id="hot" src="assets/very-scenic.jpg" alt="Very Scenic" />
         
         <input type="hidden" name="place" value="<?=$place->id;?>" />
         <input type="hidden" name="token" value="<?=$token;?>" />
         <input type="hidden" name="auth" value="<?=$auth;?>" />
         <input name="action" type="hidden" value="rate" />
      </div>
      </form>
   </div>
   
   <div id="place">      
      <div id="frame" style="width: <?=($image_width+44);?>px;">
         <div id="top"><img src="assets/pictureframe-top.jpg" class="left" alt="Please rate the scenicness of the place, not the skill of the photographer -- thanks!" /><img src="assets/pictureframe-tr.jpg" class="right" alt="tr" /></div>
         <div id="left" style="height: <?=($image_height);?>px;"></div>
         <div id="right" style="height: <?=($image_height);?>px;"></div>
         <img id="picture" src="<?=$image_link;?>" alt="<?=$place->title;?>" />
         <div id="bottom"><img src="assets/pictureframe-bl.png" class="left" alt="bl" /><div id="bottom-middle" style="width: <?=$image_width;?>px;"></div><img src="assets/pictureframe-br.png" class="right" alt="br" /></div>
      </div>
   </div>
   
  <div id="license">
     <a href="<?=$place->geograph_uri;?>">Photo</a> by <a href="<?=$place->creator_uri;?>"><?=$place->creator;?></a> (<a href="<?=$place->license_uri;?>">Licence</a>)
        
     <? if($_SERVER['REMOTE_ADDR'] == '77.86.122.155'): ?>
     <p>
         We've noticed that you've been playing this game a lot of times - thanks!
         Would you mind dropping us a line to <a href="mailto:hello&#64;mysociety.org">hello&#64;mysociety.org</a> to chat about it?
     </p>
     <? endif; ?>
  </div>
</div>
<? foot(); ?>
