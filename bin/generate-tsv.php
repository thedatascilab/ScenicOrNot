#!/usr/bin/php -q
<?php
/* 
 * generate-tsv:
 * Run from cron to generate a TSV file of average ratings.
 *
 * Copyright (c) 2009 UK Citizens Online Democracy. All rights reserved.
 * Email: matthew@mysociety.org. WWW: http://www.mysociety.org/
 *
 * $Id: generate-tsv.php,v 1.7 2010-02-16 00:13:48 matthew Exp $
 *
 */

include dirname(__FILE__) . '/../web/prepend.php';
include ROOT . "/include/global.php";

$mySQL->query("select place, lat, lon, avg(rating), var_pop(rating), group_concat(rating), geograph_uri from vote, place
    where place = place.id
        and uuid not in ('2a92cf77c3908f132b856af79f0c3267', 'fd0fd60993feaa3463c43581ee60eeba', 'd2947b36351a635e7381a17a5b22b0ba')
    group by place
    having count(rating) >= 3
");

$out = "ID\tLat\tLon\tAverage\tVariance\tVotes\tGeograph URI\n";
while ($row = $mySQL->fetchArray()) {
    $out .= "$row[0]\t$row[1]\t$row[2]\t$row[3]\t$row[4]\t$row[5]\t$row[6]\n";
}

$fp = fopen(ROOT . '/votes.tsv.new', 'w');
fwrite($fp, $out);
fclose($fp);
rename(ROOT . '/votes.tsv.new', ROOT . '/votes.tsv');
