<? head('', array('rankings.css', 'generic.css')   ); ?>

<div id="side">
   <? header_box(); ?>
   </ul>
</div>

<div id="content">
   <div id="generic">
      <img src="assets/generic-top.jpg" alt="------------" />
      <table id="summary">
      <tr>
         <th>Total Places</th>
         <th>Total Votes</th>
      </tr>
      <tr>
         <td>
            <p><?=number_format($stats['total_places']);?></p>
            <small>(<?=$stats['percentage_coverage'];?>% of Great Britain)</small>
         </td>
         <td>
            <p><?=number_format($stats['total_votes']);?></p>
            <small>(from approx <?=number_format($stats['total_users']);?> users)</small>
         </td>
      </td>
      </tr>
      <tr>
         <th>Total Rated</th>
         <th>% Complete</th>
       <!--  <th>Distribution</th> -->
      </tr>
      <tr>
         <td>
            <p><?=number_format($stats['total_rated']);?> done, <?=number_format($stats['partially_rated']);?> partial</p>
            <small>(<?=$stats['percentage_rated'];?>%, <?=$stats['percentage_partial'];?>%)</small>
         </td>
         <td>
            <img src="http://chart.apis.google.com/chart?chs=200x100&cht=gom&chd=t:<?=$stats['percentage_rated'];?>" alt="<?=$stats['percentage_rated'];?> percent complete" />
         </td>
      </tr>
      <!--<tr>
         <td colspan="2">
            <a href="<?=$graph_uri;?>"><img src="<?=$graph_uri;?>" width="100" alt="Distribution Graph" /></a>
         </td>
      </tr> -->
      </table>
   </div>
   
   <img src="assets/generic-bottom.jpg" alt="------------" />
</div>

<? foot(); ?>
