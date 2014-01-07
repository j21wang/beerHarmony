<?php
   error_reporting(E_ALL);
   ini_set('display_errors', '1');

   $conn = mysql_connect("localhost","csuser","cs2deb75")
   or die("error: could not connect to db");

   mysql_select_db('bbd_plusplus',$conn) or die('a fiery death');

?>

