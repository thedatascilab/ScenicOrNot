<?php


function head($title, $styles = array(), $javascripts = array(), $head_tags = array())
{
   header("Content-type: text/html; charset=utf-8");

   ?>
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
   <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

      <?

      foreach($head_tags as $head_tag)
      {
        echo "   $head_tag\n";
      }

      ?>

      <title><?=$title;?>ScenicOrNot</title>

      <?

      foreach($javascripts as $script)
      {
        ?><script type="text/javascript" src="js/<?=$script;?>"></script>
        <?
      }


      ?>
      <link href="css/common.css" rel="stylesheet" type="text/css" />
      <?

      foreach($styles as $sheet)
      {
        ?><link href="css/<?=$sheet;?>" rel="stylesheet" type="text/css" />
        <?
      }

      ?>
   </head>

   <body>
  <!-- <div id="beta_message_wrap">
      <div id="beta_message">
            <h3>ScenicOrNot is in beta</h3>
      </div>
   </div> -->

   <div id="page_wrap">


   <div id="page">
   <?
}


function foot()
{
   ?>
      <div class="clear"></div>
      </div>
   </div>

   <div id="footer_wrapper">
      <div id="footer">
         <p>A mini-project originally created for <a href="http://www.mysociety.org">mySociety</a>. Now hosted by the <a href="http://datasciencelab.co.uk/"> Data Science Lab</a>, <a href="http://www.wbs.ac.uk/">Warwick Business School.</a><br />&nbsp;
            <a href="http://datasciencelab.co.uk/contact-us/">Contact us</a>.
            <a href="privacy">Privacy and cookies</a>.
         </p>
      </div>
   </div>
   <script type="text/javascript">

     var _gaq = _gaq || [];
     _gaq.push(['_setAccount', 'UA-65751732-2']);
     _gaq.push(['_gat._anonymizeIp']);
     _gaq.push(['_trackPageview']);

     (function() {
       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
     })();

   </script>
   </body>
   </html>
   <?
}

function header_box()
{
   ?>

   <ul>
      <li id="menu_logo"><a href="/"><img src="assets/scenicornot.jpg" alt="Scenic Or Not" /></a></li>

      <li id="menu_home" class="menu"><a href="/">Home</a></li>
      <li id="menu_faq" class="menu"><a href="/faq">FAQ</a></li>
      <li id="menu_top10" class="menu"><a href="/leaderboard">Leaderboard</a></li>

   <?
}

?>
