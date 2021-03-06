<?php

//---------------
//  apch : 25/7/15
//  maj	04/08/2015
//---------------


//$bd_var_ready = false;

//include_once '03_tools.php'; // qq outils
include_once '09_que_pour_la_production.php'; // connection à la bd
include_once '10_sql.php';

//date_default_timezone_set('Europe/Paris');

// -----------------------------------------------------------------
// variables globales
// -----------------------------------------------------------------

/*
$_foo_max_php_time_more_30_sec = set_time_limit(150); //  in seconds

$_table = array("reporting_data", "reporting_data_dv");
$_globale_table = array("reporting", "reporting_dv");


//Paramétrage des reduction TJ : 15% WEBI - 0% DV
$_coefficient = array(1.18, 1);

$idx_gamisio = 1;

// VISU ZOOM PARAMETRAGE
if ($idx_gamisio == 1) { // ==> i est l'index des tables en cours d'utilisation
    $_visu_zoom = "DV";
} else {
    $_visu_zoom = "W";
}

*/

// -----------------------------------------------------------------
// renvoie une requete mysql en json
function query_to_json($link, $query)
{

    // $link->query("SET NAMES 'utf8'"); // don't forget out of production
    $_url_analysis = array(// deux termes annexes peu important
        "http://gamisio.com/adsense/login/examples/visu_zoom_moyenne.php?source=W&id=",
        "http://gamisio.com/adsense/login/examples/visu_zoom_moyenne.php?source=DV&id="
    );
    $id_gam = 1;

    $req = $link->query($query);
    if (!$req) {
        fc_die("Echec lors de la requete : (" . $link->errno . ") " . $link->error);
    }

    $json = ''; // sql -> arr
    While ($row = $req->fetch_assoc()) {
        $json[] = $row;
    }
    // retour des dates bd
    @$but = (json_decode(file_get_contents("php://input"))->but);
    @$date_1 = (json_decode(file_get_contents("php://input"))->date_1);
    @$date_2 = (json_decode(file_get_contents("php://input"))->date_2);
    // (json_decode(file_get_contents("php://input"))->v_ou_p);
    @$_dd = (json_decode(file_get_contents("php://input"))->v_ou_p);
    @$v_ou_p = ($_dd != 'w') ? 'd' . $_dd : $_dd;

    //$date_1 = '2015-10-27';
    //$date_2 = '2015-10-28';
    //$but = 'but';


    if (isset($date_1))                 // info pour le retour
        $json[0]['Date'] = $date_1;

    if (isset($date_2))
        $json[1]['Date'] = $date_2;

    if (isset ($but))
        $json[2]['Date'] = $but;

    if (isset ($v_ou_p))
        $json[3]['Date'] = $v_ou_p;

    $json = json_encode($json); // or fc_var_to_json($json) pour les vieux browsers;
    return '{"records":' . $json . '}';
}

// ----------------------------------------------------------------
// affiche le résultat en fonction du fichier
function echo_result_page($stg)
{
    $on_04 = $GLOBALS['_je_suis_sur_le_fichier_04'];

    if ($on_04) {
        print_json($stg);
    } else {
        echo $stg;
    }
}

if (isset($but) and $but == 'variation' and isset($date_1) and isset($date_2)) {
    if ($date_2 < $date_1) {
        $t = $date_2;
        $date_2 = $date_1;
        $date_1 = $t;
    }
    return query_to_json($link, variation_qry("AND d.date BETWEEN '$date_1' AND '$date_2'", 'variation'));
}
// ----------------------------------------------------------------

function load_db($link, $limit = '')
{
    global $bd_var_ready;
    // récupération des vars ajax
    @$but = (json_decode(file_get_contents("php://input"))->but);
    @$date_1 = (json_decode(file_get_contents("php://input"))->date_1);
    @$date_2 = (json_decode(file_get_contents("php://input"))->date_2);
    //$but = 'variation';
    //$but = 'dddr';
    //$date_1 = '2016-01-03';
    //$date_2 = '2016-01-04';

    if (isset($but)) {

        if ($but == 'date' and isset($date_1)) {
            return query_to_json($link, global_qry(" AND d.date = ' " . $date_1 . "'", $limit));
        }

        if ( $but == 'periode' and isset($date_1) and isset($date_2)) {
            if ($date_2 < $date_1) {
                $t = $date_2;
                $date_2 = $date_1;
                $date_1 = $t;
            }
            if ($date_1 == $date_2) {
                return query_to_json($link, global_qry(" AND d.date = ' " . $date_1 . "'", $limit));
            } else {
                return query_to_json($link, periode_qry("AND d.date BETWEEN '$date_1' AND '$date_2'", $limit));
            }
        }

        if ($but == 'variation' and isset($date_1) and isset($date_2)) {
            if ($date_2 < $date_1) {
                $t = $date_2;
                $date_2 = $date_1;
                $date_1 = $t;
            }

            //$bd_var_ready = true;

            return query_to_json($link, variation_qry("AND d.date BETWEEN '$date_1' AND '$date_2'", 'variation'));
        }

        if ( $but == 'gain_0' and isset($date_1) and isset($date_2)) {
            if ($date_2 < $date_1) {
                $t = $date_2;
                $date_2 = $date_1;
                $date_1 = $t;
            }
            return query_to_json($link, gain_0_qry($date_1, $date_2, 'gain_0'));
        }

        if ( $but == 'bilan' and isset($date_1) and isset($date_2)) {
            return query_to_json($link, bilan_qry($date_1, $date_2));
        }

        if ($but == 'bilan_init' and isset($date_1)) {
            return query_to_json($link, bilan_qry(" '" . date_reporting() . "' "));
        }

        if ($but == 'dddr') { // date du dernier rapport
            return query_to_json($link, "SELECT `date` FROM `reporting_data_dv`  ORDER BY `date` DESC LIMIT 1");
        }

        return query_to_json($link, global_qry(" AND d.date = '" . $date_1 . "' ", $limit));
    }
}

// début----------------------------------------------------------------
$link = my_connect(); // connection à la bd eric; en dur dans 03_bd....
$_je_suis_sur_le_fichier_04 = !true;

//$but = 'date_du_dernier_rapport';
//$date_1 = '2015-07-24';

$query_result = load_db($link, $lmit);

echo_result_page($query_result);

//save_result($query_result);

$link->close();
