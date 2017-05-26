<?php
/**
 * Created by PhpStorm.
 * User: apch
 * Date: 17/08/2016
 *
 * Usage :
 * https://gameisio.com/xyz_new5/apis/marges.php
 * renvoi la marge globale des quatre bases connues
*/

include_once './class/02_db_functions.php';
include_once './class/10_class_req_marge_base.php';

// catch dates on  URL
$dt1='';
$dt2='';
$help='';
if (isset($_GET['dt1']))       { $dt1 =$_GET['dt1'];}   //echo $base  .'<br>';
if (isset($_GET['dt2']))       { $dt2 =$_GET['dt2'];}
if (isset($_GET['help']))       { $help  ='help';}          //echo $help;

if ($help=='help') {
    header("Location: http://gamisio.com/xyz_new5/doc/2016-utilisation-apiMarge.pdf");
    exit(0);
}

if      ($dt1=='' && $dt2 =='') {$dt1 = $dt2 = dddr();} // no date so dddr
elseif  ($dt1=='')              {$dt1=$dt2;}
elseif  ($dt2=='')              {$dt2=$dt1;}
verifDates($dt1,$dt2);// first small date 1st


$c = new Connect(); $con = $c ->logIn(); // conction

$m_dv  = get_base_marge('dv',$con, $dt1, $dt2);
$m_dp  = get_base_marge('dp',$con, $dt1, $dt2);
$m_m   = get_base_marge('m', $con, $dt1, $dt2);
$m_w   = get_base_marge('w', $con, $dt1, $dt2);
$m_o   = get_base_marge('o', $con, $dt1, $dt2);
$m_at  = get_base_marge('at', $con, $dt1, $dt2);
$total = $m_dv +$m_dp +$m_m +$m_w+$m_o+$m_at;

//print result
echo "{
        \"but\":\"Marges globales du $dt1 au $dt2\",
        \"total\":$total,
        \"dv\":$m_dv,
        \"dp\":$m_dp,
        \"m\":$m_m,
        \"w\":$m_w,
        \"o\":$m_o,
        \"at\":$m_at
}";
/*
 * ----------.----------.---------.----------
 * get 1 base marge; base is dv, m ...
 * ----------.----------.---------.----------
 **/
function get_base_marge($base, $con,$dt1, $dt2){
    $sql_ob= new Req_marge('but',$base, $dt1,$dt2);//init query
    $m_dv_sql = $sql_ob->marge_sql(); //init result and query marge
    $qry = new Sql_query($con,$m_dv_sql); // result in array or json
    $arr = $qry->getArray();

    return $arr[0]['marge'];
}
?>