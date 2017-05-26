<?php

/*
 *  fc le 2015-08-10
 */

// ----------------------------------------------------------------
// connection à la base : corriger à mettre en dur
// ----------------------------------------------------------------
function my_connect()
{

    $host = 'fdb4.biz.nf';
    $user = '1910954_apch';
    $pass = 'apch1448';
    $base = '1910954_apch';

    $link = mysqli_connect($host, $user, $pass, $base)
    or fc_die("Erreur a l'ouverture de la base" . mysqli_error($link));

    return $link;
}

// ----------------------------------------------------------------
// limit à mettre en dur.  pour Eric : $lmit='';
// ----------------------------------------------------------------

$lmit = 'LIMIT 110'; // '' pour la production

// ----------------------------------------------------------------
//Sauvegarde de la bd en json; ne faitrien pour la production
// ----------------------------------------------------------------
function save_result($stg = ' ', $path = "../Sauvegarde_quotidienne", $fle = "extraction_du_")
{
    if (!file_exists($path)) {
        mkdir($path);
    }
    $fullpath = $path . "/" . $fle . date('Y-m-d') . '.json';
    if (!file_exists($fullpath)) {
        $fp = fopen($fullpath, 'w');
        if (!is_resource($fp)) {
            fc_die('Erreur lors de la sauvegarde;');
        }
        fwrite($fp, $stg);
        fclose($fp);
    }
}

// ---------------------------------------------------------------------
// date du rapport
//----------------------------------------------------------------------

function date_reporting($dte = '2015-07-28')
{// mettre la date de l'extraction de la base sur le pc local

    // if (is_apch_pc()) {
    //     return "$dte";
    //  } else {
    return date('Y-m-d', (time() - (3600 * 8) - (3600 * 24))); // apostrophes dans la query
    // }
}


?>

