<?php
/**
 * Created by PhpStorm.
 * User: apch
 * Date: 19/08/2016
 * Time: 11:56
 */
include_once '00_class_connect.php';
include_once '01_class_query.php';
/*
 ----------.----------.---------.----------
 cal de la dddr ; la date la plus haute ds la base
 on choisit par deéfaut la base dv
 ----------.----------.---------.----------
*/
function dddr($bse='_dv')
{
    $c = new Connect();
    $con = $c ->logIn();

    $q=" SELECT `date`  FROM `reporting_data$bse` ORDER BY `date` DESC LIMIT 1   ";
    $qry = new Sql_query($con,$q); // result in array or json
    $arr = $qry->getArray();
    return $arr[0]['date'];
}
/*
----------.----------.---------.----------
afficche l'erreur
----------.----------.---------.----------
*/
function erreur($t1,$t2='', $coul='red'){
    return " 
        <div style='color:$coul'> 
        <br>----------.
        <br> $t1; $t2 
        <br>----------. 
        </div>
    ";
}
function verifDates(&$d1 ,&$d2) {
    if ($d1 >  $d2) {//petite date avant
        $d3 = $d2;
        $d2 = $d1;
        $d1 = $d3;
    }
}
/*
 ----------.----------.---------.----------
 tests
 ----------.----------.---------.----------
*/
//echo var_dump(dddr());
//$d1=1;$d2=0; verifDates($d1,$d2); echo "d1= $d1 d2=$d2";