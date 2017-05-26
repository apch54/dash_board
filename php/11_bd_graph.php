<?php

//---------------
//  apch : 25/7/15
//  maj	04/08/2015
//---------------

//include_once '03_tools.php'; // qq outils
include_once '09_que_pour_la_production.php'; // connection à la bd
include_once '10_sql.php';

//date_default_timezone_set('Europe/Paris');

// -----------------------------------------------------------------
// variables globales
// -----------------------------------------------------------------

$_foo_max_php_time_more_30_sec = set_time_limit(150); //  in seconds

// -----------------------------------------------------------------
// renvoie une requete mysql en json
function query_to_json($link, $query)
{
     
    $id_gam = 1;


    $req = $link->query($query);
    if (!$req) {
        fc_die("Echec lors de la requêe : (" . $link->errno . ") " . $link->error);
    }

    $json = ''; // sql -> arr
    While ($row = $req->fetch_assoc()) {
        $json[] = array_map("utf8_encode", $row); //$row;
    }

    $json = json_encode($json); // or fc_var_to_json($json) pour les vieux browsers;
    //return '{"records"' . $json . '}';
    return $json;
}

// ----------------------------------------------------------------
// affiche le résultat en fonction du fichier
function echo_result_page($stg)
{
    $on_11 = $GLOBALS['_je_suis_sur_le_fichier_11'];

    if ($on_11) {
        print_json($stg);
    } else {
        echo $stg;
    }
}

// ----------------------------------------------------------------

function load_db($link, $limit = '')
{
    // récupération des vars ajax

    $v_ou_p = (isset($_POST['v_ou_p'])) ? $_POST['v_ou_p'] : 'v';
    $but = (isset($_POST["but"])) ? $_POST["but"] : 'ERREUR';
    $date_1 = (isset($_POST["date_1"])) ? $_POST["date_1"] : 'Non en principe'; // mis sur le 10...php

    //$but = 'tous_les_jeux' ;
    //$but = 'camp~49' ;
    //$but = 'levier' ;
    //$but = 'modifs_bid';
    //$date_1 = '2015-12-20';

    if (isset($but)) {
        // on remonte les marges quotidiennes pour le graphe XY
        if ($but == 'marge') {/*and $date == '2016-07-28')*/
            return query_to_json($link, graph_qry("marge"));
        }

        // on remonte les marges des jeux sur une période pour un pie
        if ($but == 'jeux') {/*and $date == '2016-07-28')*/
            return query_to_json($link, graph_qry("jeux"));
        }
        if ($but == 'regies') {/*and $date == '2016-07-28')*/
            return query_to_json($link, graph_qry("regies"));
        }
        if ($but == 'jeux_et_regies') {/*and $date == '2016-07-28')*/
            return query_to_json($link, graph_qry("jeux_et_regies"));
        }

        // on remonte les marges des campagnes sur une période pour un pie
        if ($but == 'jeux_regies_et_camp') {/*and $date == '2016-07-28')*/
            return query_to_json($link, graph_qry("jeux_regies_et_camp"));
        }

        // on remonte simplement le nom de tous les jeux afin de remplir
        // la combo-list XY
        if ($but == 'tous_les_jeux') {
            return query_to_json($link, graph_qry('tous_les_jeux'));
        }

        // on remonte simplement le nom de toutes les régies afin de les mettre
        // ds la combo  du graph XY
        if ($but == 'toutes_les_regies') {
            return query_to_json($link, graph_qry("toutes_les_regies"));
        }

        // On remonte une seule régie ou on seul jeu ou une seule campagne en fonction du temps pour le graph XY

        $_reg_explode = explode('~', $but);
        if ($_reg_explode[0] == 'regie') {
            $regie = $_reg_explode[1];
            return query_to_json($link, graph_qry("une_regie", $regie));
        } elseif ($_reg_explode[0] == 'jeu') {
            $jeu = $_reg_explode[1];
            return query_to_json($link, graph_qry("un_jeu", $jeu));
        } elseif ($_reg_explode[0] == 'camp') {
            $camp = $_reg_explode[1];
            return query_to_json($link, graph_qry("une_campagne", $camp)); // camp est l'idCamp
        }

        // étude de l'effet de levier remonté des jeux, régies -> marges et Nb_clics
        if ($but == 'levier') {
            return query_to_json($link, graph_qry("levier"));
        }
        if ($but == 'modifs' and isset($date_1)) {
            return query_to_json($link, modifs_qry($date_1));
        }

        if ($but == 'modifs_bid' and isset($date_1)) {
            return query_to_json($link, bid_qry($date_1));
        }
    }
}

// début----------------------------------------------------------------
$link = my_connect(); // connection à la bd eric; en dur dans 03_bd....
$_je_suis_sur_le_fichier_11 = !true; //  BIEN METTRE NOT TRUE

//$but = 'camp~99'; echo $but; // il est préférable de modifier la ligne 85
//$date_1 = '2015-07-24';

$query_result = load_db($link, $lmit);

echo_result_page($query_result);

save_result($query_result);

$link->close();
