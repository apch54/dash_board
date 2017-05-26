<?php
/**
 * Created by PhpStorm.
 * User: apch
 * Date: 30/10/2016
 *
 * Usage :
 * https://gameisio.com/xyz_new5/apis/marges.php
 * renvoi la marge globale des quatre bases connues
*/

include_once '../class/02_db_functions.php';
include_once './class_req_t_marge.php';

// catch dates on  URL
$dt1    ='';
$dt2    ='';
$help   ='';
$base   = '';

if (isset($_GET['id']))        { $id =$_GET['id'];} else $id=-1;
if (isset($_GET['dt1']))       { $dt1 =$_GET['dt1'];}       //echo $base  .'<br>';
if (isset($_GET['dt2']))       { $dt2 =$_GET['dt2'];}
if (isset($_GET['help']))      { $help  ='help';}           //echo $help;
if (isset($_GET['base']))      { $base = $_GET['base'];} else {$base = '';} // default-base is m

if ($help=='help') {
    header("Location: http://gamisio.com/xyz_new5/doc/2016-utilisation-apiMarge.pdf");
    exit(0);
}

if  ($dt1=='' && $dt2 =='') { $dt1 = dddr();    $dt2 = cal_date($dt1, -30);} // no date so dddr to ddr -30
elseif  ($dt1=='')          { $dt1 = $dt2;      $dt2 = cal_date($dt1, -30); }
elseif  ($dt2=='')          { cal_date($dt1, -30);}

verifDates($dt1,$dt2);// first small date 1st


$c = new Connect(); $con = $c ->logIn();

$sql_ob     = new Req_t_marge($id, $base, '2015-12-25','2016-12-30');//init query

//$sql_ob     = new Req_t_marge(99, 'dv', '2015-12-25','2016-12-30');//init query
$tm_dv_sql  = $sql_ob->t_marge_sql(); //init result and query marge
$qry        = new Sql_query($con,$tm_dv_sql); // result in array or json
$arr        = $qry->getJson();

/*
----------.----------.---------.----------
test
----------.----------.---------.----------
*/
echo($arr);
//echo '<br>',$dt1,'<br>', $dt2;


?>