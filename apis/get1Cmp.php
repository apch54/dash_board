<?php
//   _                     _            _
//  (_)_ __  _ __  ___ _ _| |_ __ _ _ _| |_
//  | | '  \| '_ \/ _ \ '_|  _/ _` | ' \  _|
//  |_|_|_|_| .__/\___/_|  \__\__,_|_||_\__
//          |_|
// initile de modifier la ligne 123 pour trouver  le bon site
// en local : http://127.0.0.1:8080/dashboard/apis/get1Cmp.php?base=o&dt1=2014-12-31&idCmp=114
//

header('Content-Type: application/json');

include_once '../php/03_tools.php';
include_once './class/classRequete.php';
include_once './class/classApiDb.php';

$but    ='';    // init var URL
$base   ='';
$dt1    ='';    
$dt2    ='';    
$idCmp  ='';
$tvl    ='';    // interval
$param  ='';    // param
$help   ='';

/*
----------.----------.---------.----------
get var URL
----------.----------.---------.----------
*/
if (isset($_GET['base']))       { $base  =$_GET['base'];}   //;echo $base  .'<br>';
if (isset($_GET['dt1']))        { $dt1   =$_GET['dt1'] ;}   //echo $dt1   .'<br>';
if (isset($_GET['dt2']))        { $dt2   =$_GET['dt2'] ;}   //echo $dt2   .'<br>'; ;
if (isset($_GET['idCmp']))      { $idCmp =$_GET['idCmp'];}  //echo $idCmp .'<br>';
if (isset($_GET['interval']))   { $tvl  =$_GET['interval'];}//echo $itvl;
if (isset($_GET['param']))      { $param  =$_GET['param'];} //echo $param.'<br>';
if (isset($_GET['help']))       { $help  ='help';}          //echo $help;

if ($help=='help') {
  header("Location: http://gamisio.com/xyz_new5/doc/2016-utilisation-apiget1Cmp.pdf");  
  exit(0);
}


/*
----------.----------.---------.----------
context research, choose server
implémentation de l'objet oneCmp
en fonction du serveur
----------.----------.---------.----------
*/ 
$oneCmp =newApiDb(); //instanciate requete
if( $base =='') {$base='m';}
/*
----------.----------.---------.----------
is it an interval ?
----------.----------.---------.----------
*/
if( $tvl != "")
{
    $tvl= intval($tvl) ;
    $dt1= $oneCmp->getDddr($base); // $d1 is now dddr ; SEARCH DDDR 
    // calculate date dddr - n interval in day
    $dt2 = calDateMinusN($dt1, $tvl-1);// tde : string et tvl : interval
    
}else // config date
{
    if( $dt1 == '' || $dt2=='' ){
        $dt1 = $oneCmp->getDddr($base); // $d1 is now dddr SEARCH DDDR 
        $dt2 = $dt1;       
    }
}

$oneCmp->set1Camp ( $base,  $dt1, $dt2, $idCmp); // init object
$dta= $oneCmp->getData(); // get data
printData($dta, $param);

// fin du script de l'API ================

//gamisio ='rof76-2-88-179-32-88.fbx.proxad.net'
/*$_GET['variable']
----------.----------.---------.----------
affiche le résultat de la requête
----------.----------.---------.----------
*/
function printData($dta, $param='' ){ 
 
    if($param == ''){ echo ( $dta);}// affiche le json au cpmplet
    else{ // affiche uniquement un champ

        $tmp = json_decode($dta,true);
        switch ($param) {

            case 'camp':        echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'cout_dollard':echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'CPM':         echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'nb_transfo':  echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'CVR':         echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'ctr_game':    echo  "'$param' : '".$tmp[$param]."'"; break;            
            case 'ctr_login':   echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'gain_euro':   echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'jeu':         echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'marge':       echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'regie':       echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'renta':       echo  "'$param' : '".$tmp[$param]."'"; break;
            case 'val_1_clic':  echo  "'$param' : '".$tmp[$param]."'"; break;
            
            default: echo erreur('Error : bad param parameter URL in get1Camp.php file');   break;
        }
    }

}
/*
----------.----------.---------.----------
calcul des dates suite à une période: $i jours avant
----------.----------.---------.----------
*/
function calDateMinusN($d,$i){
   $t= strtotime($d);  
   return $d2 =gmdate('Y-m-d', $t-$i*86400);
}

/*
----------.----------.---------.----------
context research, choose server
----------.----------.---------.----------
*/
function newApiDb(){
    if ( gethostbyaddr ( $_SERVER['REMOTE_ADDR'] ) == 'apch-PC') // mon pc
         {$oneCmp = new ApiDB('local'  );}
    else {$oneCmp = new ApiDB('gamisio');}

    return $oneCmp;
}
?>