<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');
include 'php/connect.php';
?>

<html>
   <head>
      <title>beerHarmony</title>   
      <link rel="stylesheet" type="text/css" href="lib/chosen/chosen.css" />
      <link rel="stylesheet" type="text/css" href="stylesheets/base.css" />
      <link rel="stylesheet" type="text/css" href="stylesheets/skeleton.css" />
      <link rel="stylesheet" type="text/css" href="stylesheets/layout.css" />
      <script type="text/javascript" src="js/jquery-1.10.2.js"></script>
   </head>
   <body id="home">
      <div class="container">
         <h1 class="remove-bottom"><a href="index.php">beerHarmony</a></h1>
         <h3>From no friends to friends.</h3>
         <div class="nine columns offset-by-two">
         <form class="formContent" action="php/queries.php" method="post">
         <select name="queries[]" data-placeholder="What qualities should a drinking buddy have?" style="width:500px;" class="chosen-select" multiple>
            <option value=""></option>
            <optgroup class="barGroup" label="Bar"></optgroup>
            <optgroup class="beerGroup" label="Beer"></optgroup>
            <optgroup class="countryGroup" label="Country"></optgroup>
            <optgroup class="typeDrunkGroup" label="Type of Drunk"></optgroup>
            <optgroup class="activitiesGroup" label="Drunk Activities"></optgroup>
         </select>
         <div class="six columns offset-by-one">
         <input type="submit" class="submit" value="Search" class="submit button" />
         </div>
         </select>
         </form>
      </div>
      <script type="text/javascript" src="lib/chosen/chosen.jquery.js"></script>
      <script type="text/javascript" src="js/search.js"></script>
      <script>
         <?php 
            $beerQuery = "select beerName from beer c where (select count(*) from likes f where f.beerName = c.beerName) > 0"; //my query, could be any query
            $result = mysql_query($beerQuery, $conn);

            while ( $row = mysql_fetch_assoc($result) ) {
               echo "$('.beerGroup').append('<option value=\"beer : ".$row['beerName']."\">Beer : ".$row['beerName']." </option>');";
               echo "$('.chosen-select').trigger('chosen:updated');";
            }

            $barQuery = "select barName from bar c where (select count(*) from frequents f where f.barName = c.barName) > 0"; //my query, could be any query
            $result = mysql_query($barQuery, $conn);

            while ( $row = mysql_fetch_assoc($result) ) {
               echo "$('.barGroup').append('<option value=\"bar : ".$row['barName']."\"> Bar : ".$row['barName']."</option>');";
               echo "$('.chosen-select').trigger('chosen:updated');";
            }

            $countryQuery = "select countryName from countries c where (select count(*) from fromCountry f where f.countryName = c.countryName) > 0"; //my query, could be any query
            $result = mysql_query($countryQuery, $conn);

            while ( $row = mysql_fetch_assoc($result) ) {
               echo "$('.countryGroup').append('<option value=\"country : ".$row['countryName']."\"> Country : ".$row['countryName']."</option>');";
               echo "$('.chosen-select').trigger('chosen:updated');";
            }

            $typeDrunkQuery = "select drunkType from typeOfDrunk c where (select count(*) from acts f where f.drunkType = c.drunkType) > 0"; //my query, could be any query
            $result = mysql_query($typeDrunkQuery, $conn);

            while ( $row = mysql_fetch_assoc($result) ) {
               echo "$('.typeDrunkGroup').append('<option value=\"type : ".$row['drunkType']."\">Drunk-type : ".$row['drunkType']."</option>');";
               echo "$('.chosen-select').trigger('chosen:updated');";
            }

            $activityQuery = "select activityName from drunkActivity c where (select count(*) from doesActivity f where f.activityName = c.activityName) > 0"; //my query, could be any query
            $result = mysql_query($activityQuery, $conn);

            while ( $row = mysql_fetch_assoc($result) ) {
               echo "$('.activitiesGroup').append('<option value=\"activity : ".$row['activityName']."\">Activity : ".$row['activityName']."</option>');";
               echo "$('.chosen-select').trigger('chosen:updated');";
            }
         ?>
         //console.log(beers);
         //console.log(bars);         
         //console.log(country);
         //console.log(typeDrunk);
         //console.log(activity);

      </script>
   </body>
</html>
