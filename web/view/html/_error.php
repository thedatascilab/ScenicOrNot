<? head("$title - ", array('generic.css')); ?>

<div id="side">
   <? header_box(); ?>
   </ul>
</div>

<div id="content">
   <div id="generic">
      <img src="assets/generic-top.jpg" alt="------------" />
      
      <h1><?=$title;?></h1>
      <h2 class="content"><?=$heading;?></h2>
      <p class="content"><?=$error;?></p>
      <p class="content">If this was unexpected and you haven't found a solution, please <a href="http://datasciencelab.co.uk/contact-us/">contact us</a>.</p>
   </div>
   <img src="assets/generic-bottom.jpg" alt="------------" />
</div>


<? foot(); ?>
