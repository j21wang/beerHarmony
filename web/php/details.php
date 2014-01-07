<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');

include "connect.php";

$q = sprintf("SELECT * FROM drinker a INNER JOIN fromCountry b on a.drinkerID=b.drinkerID WHERE name='%s' AND age='%s'", mysql_real_escape_string($_GET['name']), mysql_real_escape_string($_GET['age']));
$result = mysql_query($q,$conn);
$row = mysql_fetch_assoc($result);
$id = $row['drinkerID'];
$name = $row['name'];
$gender = $row['gender'];
$age = $row['age'];
$country = $row['countryName'];
$hotness = $row['attraction'];
$types = array();
$frequents = array();
$activities = array();
$likes = array();


$q = "SELECT drunkType FROM acts WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
while ( $row = mysql_fetch_row($result) ) {
   $types[] = $row[0];
}

$q = "SELECT barName FROM frequents WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
while ( $row = mysql_fetch_row($result) ) {
   $frequents[] = $row[0];
}

$q = "SELECT activityName FROM doesActivity WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
while ( $row = mysql_fetch_row($result) ) {
   $activities[] = $row[0];
}

$q = "SELECT beerName FROM likes WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
while ( $row = mysql_fetch_row($result) ) {
   $likes[] = $row[0];
}

/* UNDERAGE */
$q = "SELECT * FROM underageDrinker WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
if (mysql_num_rows($result) == 1) {
   $row = mysql_fetch_assoc($result);
   $provider = $row["alcoholProvider"];
}
/* SENIOR */
$q = "SELECT * FROM seniorDrinker WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
if (mysql_num_rows($result) == 1) {
   $row = mysql_fetch_assoc($result);
   $seniorHome = $row["seniorCitizenHome"];
}
/* OF AGE */
$q = "SELECT * FROM ofAgeDrinker WHERE drinkerID='".$id."'";
$result = mysql_query($q,$conn);
if (mysql_num_rows($result) == 1) {
   $row = mysql_fetch_assoc($result);
   $occupation = $row["occupation"];
}

?>

<center>
   <h3 id="name"><?php echo $name; ?></h3>
</center>
   <center><h6 id="gender"><strong>Gender:</strong> <?php echo ($gender === 'f')? "Female":"Male"; ?></h6>
   <h6 id="age"><strong>Age:</strong> <?php echo $age; ?></h6>
<?php
if (isset($provider))
   echo "<h6 id=\"drinkerSubclass\"><strong style='color:#ab423f'>WARNING: THIS DRINKER IS UNDERAGE!</strong><br><strong>The alcohol provider is:</strong> " . $provider . "</h6>";
if (isset($seniorHome))
   echo "<h6 id=\"drinkerSubclass\"><strong style='color:#ab423f'>WARNING: THIS DRINKER IS OLD!</strong><br> <strong>Senior Citizen Home:</strong> " . $seniorHome . "</h6>";
if (isset($occupation))
   echo "<h6 id=\"drinkerSubclass\"><strong>Occupation:</strong> " . $occupation . "</h6>";
?>
   <h6 id="country"><strong>Country:</strong> <?php echo $country; ?></h6>
   <h6 id="hotness"><strong>Hotness:</strong> <?php echo $hotness; ?></h6></center><br><hr><br>

<?php
echo '<center><h4>Drinking Info.</h4></center><h6 id="types"><strong>Type of Drunk:</strong> ';
$str="";
foreach ($types as $type) {
   $str=$str.$type." | ";
}
$str= substr($str, 0, -3);
echo $str;
echo '</h6><br>';
echo '<h6 id="bars"><strong>Bars Frequented:</strong> ';
$str="";
foreach ($frequents as $bar) {
   $str=$str.$bar." | ";
}
$str= substr($str, 0, -3);
echo $str;
echo '</h6><br>';
echo '<h6 id="beers"><strong>Beers Liked:</strong> ';
$str="";
foreach ($likes as $beer) {
   $str=$str.$beer." | ";
}
$str= substr($str, 0, -3);
echo $str;
echo '</h6><br>';
echo '<h6 id="activities"><strong>Drunken Activities:</strong> ';
$str="";
foreach ($activities as $activity) {
   $str=$str.$activity." | ";
}
$str= substr($str, 0, -3);
echo $str;
echo '</h6>';

?>
