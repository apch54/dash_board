<?php

/*
 *  fc le 2015-08-10
 */

// ----------------------------------------------------------------
// connection à la base : corriger à mettre en dur
// ----------------------------------------------------------------
function my_connect() {

    $host = 'clicmyphotos.cfjksv2azdoo.ap-southeast-1.rds.amazonaws.com';
    $user = 'clicpyphotos';
    $pass = 'webuser11';
    $base = 'clicmyphotos';

    $link = mysqli_connect($host, $user, $pass, $base)
            or fc_die("Erreur a l'ouverture de la base" . mysqli_error($link));
    
    return $link;
}

// ----------------------------------------------------------------
// limit à mettre en dur.  pour Eric : $lmit='';
// ----------------------------------------------------------------

$lmit = '';

// ----------------------------------------------------------------
function save_result($stg = ' ', $path = "../Sauvegarde_quotidienne", $fle = "extraction_du_"){
	
	// ne fait rien en production : pas de sauvegarde
	$i=0;
}

// ---------------------------------------------------------------------
// date du rapport
//---------------------------------------------------------------------- 

function date_reporting ($dte = '2015-07-28'){// mettre la date de l'extraction de la base sur le pc local
	//if(is_apch_pc()){
	//	return "$dte";
	//} else{
		return date('Y-m-d', ( time() - (3600*8) - (3600*24))); // apostrophes dans la query 
		//console.log 
	//}
}
// ----------------------------------------------------------------

