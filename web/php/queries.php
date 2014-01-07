<?php
include 'connect.php';
?>

<?php
if (isset($_POST['queries']))
   $search=$_POST[ 'queries' ];
else
   $search = array();

$output = array(array()); //holds all info about drinkers to output
$drinkerIDs = array(); //holds only drinkerIDs used to see if ID is already in list
if($search){
   foreach($search as $s){
      $tknize = explode(" : ",$s);

      if($tknize[0]=='bar'){
         $dbQuery = "SELECT * FROM frequents f, drinker d, fromCountry fr WHERE f.drinkerID = d.drinkerID AND f.barName='".$tknize[1]."' AND f.drinkerID=fr.drinkerID";
         $result = mysql_query($dbQuery,$conn);

         while($row=mysql_fetch_assoc($result)){
            if (!in_array($row['drinkerID'], $drinkerIDs)) {
               $drinkerIDs[]=$row['drinkerID'];
               $output[]=array("drinkerID"=>$row['drinkerID'],"name"=>$row['name'],"gender"=>$row['gender'],"age"=>$row['age'],"countryName"=>$row['countryName'],"hotness"=>$row['attraction']);
            }
         }
      } else if($tknize[0]=='beer'){
         $dbQuery = "SELECT * FROM likes l, drinker d, fromCountry fr WHERE l.drinkerID = d.drinkerID AND l.beerName='".$tknize[1]."' AND l.drinkerID=fr.drinkerID;";
         $result = mysql_query($dbQuery,$conn);

         while($row=mysql_fetch_assoc($result)){
            if (!in_array($row['drinkerID'], $drinkerIDs)) {
               $drinkerIDs[]=$row['drinkerID'];
               $output[]=array("drinkerID"=>$row['drinkerID'],"name"=>$row['name'],"gender"=>$row['gender'],"age"=>$row['age'],"countryName"=>$row['countryName'],"hotness"=>$row['attraction']);
            }
         }
      } else if($tknize[0]=='country'){
         $dbQuery = "SELECT * FROM fromCountry f, drinker d WHERE f.drinkerID = d.drinkerID AND f.countryName='".$tknize[1]."';";
         $result = mysql_query($dbQuery,$conn);

         while($row=mysql_fetch_assoc($result)){
            if (!in_array($row['drinkerID'], $drinkerIDs)) {
               $drinkerIDs[]=$row['drinkerID'];
               $output[]=array("drinkerID"=>$row['drinkerID'],"name"=>$row['name'],"gender"=>$row['gender'],"age"=>$row['age'],"countryName"=>$row['countryName'],"hotness"=>$row['attraction']);
            }
         }
      } else if($tknize[0]=='type'){
         $dbQuery = "SELECT * FROM acts a, drinker d, fromCountry fr WHERE a.drinkerID = d.drinkerID AND a.drunkType='".$tknize[1]."' AND a.drinkerID=fr.drinkerID;";
         $result = mysql_query($dbQuery,$conn);

         while($row=mysql_fetch_assoc($result)){
            if (!in_array($row['drinkerID'], $drinkerIDs)) {
               $drinkerIDs[]=$row['drinkerID'];
               $output[]=array("drinkerID"=>$row['drinkerID'],"name"=>$row['name'],"gender"=>$row['gender'],"age"=>$row['age'],"countryName"=>$row['countryName'],"hotness"=>$row['attraction']);
            }
         }
      } else {
         $dbQuery = "SELECT * FROM doesActivity a, drinker d, fromCountry fr WHERE a.drinkerID = d.drinkerID AND a.activityName='".$tknize[1]."' AND a.drinkerID=fr.drinkerID;";
         $result = mysql_query($dbQuery,$conn);

         while($row=mysql_fetch_assoc($result)){
            if (!in_array($row['drinkerID'], $drinkerIDs)) {
               $drinkerIDs[]=$row['drinkerID'];
               $output[]=array("drinkerID"=>$row['drinkerID'],"name"=>$row['name'],"gender"=>$row['gender'],"age"=>$row['age'],"countryName"=>$row['countryName'],"hotness"=>$row['attraction']);
            }
         }
      } 
   }
}

   ?>

<html>
   <head>
      <link rel="stylesheet" type="text/css" href="../lib/datatables/media/css/jquery.dataTables.css" />
      <link rel="stylesheet" type="text/css" href="../stylesheets/base.css" />
      <link rel="stylesheet" type="text/css" href="../stylesheets/skeleton.css" />
      <link rel="stylesheet" type="text/css" href="../stylesheets/layout.css" />
      <link rel="stylesheet" type="text/css" href="../lib/avgrund/style/avgrund.css" />
      <script type="text/javascript" src="../js/jquery-1.10.2.js"></script>
      <script type="text/javascript" src="../lib/datatables/media/js/jquery.dataTables.js"></script>
      <script type="text/javascript" src="../lib/avgrund/jquery.avgrund.js"></script>
   </head>
   <body>
      <div class="container" style="top:50px">
         <h1 class="remove-bottom"><a href="../index.php">beerHarmony</a></h1>
         <br>
         <hr>
         <br>
         <table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
            <thead>
               <tr>
                  <th> Name </th>
                  <th> Gender </th>
                  <th> Age </th>
                  <th> Country </th>
                  <th> Hotness </th>
               </tr>   
            </thead>
            <tbody>
            </tbody>
         </table>
      </div>
      <script>
<?php
   foreach($output as $drinker){
      if (isset($drinker['drinkerID']))
         echo "$('#example').dataTable().fnAddData(['".$drinker['name']."','".$drinker['gender']."','".$drinker['age']."','".$drinker['countryName']."','".$drinker['hotness']."']);";
   }
?>

         var oTable;
         var pName;
         var pGender;
         var pAge;
         var pCountry;
         var pHotness;
         var response;
      </script>
      <script type="text/javascript" src="../js/clickRow.js"></script>
   </body>
</html>
