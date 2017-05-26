<?php
// -----------------------------------------------------------------
// variables globales
// -----------------------------------------------------------------
$where_exceptions = "
        d.cvr != ''
        AND d.nb_clic != ''
        AND d.cout_dollard !=''
    ";

// -----------------------------------------------------------------
// requêtes sql

//outils-----

function choix_bd()
{
   //return '_dv';

    @$v_ou_p = (isset($_POST['v_ou_p'])) ? $_POST['v_ou_p'] : json_decode(file_get_contents("php://input"))->v_ou_p; // v_ou_p ? ajax : angular
    if (isset($v_ou_p) and ($v_ou_p == 'p')) {
        return '_dp';
    }
    if (isset($v_ou_p) and ($v_ou_p == 'v')) {
        return '_dv';
    }
    if (isset($v_ou_p) and ($v_ou_p == 'w')) {
        return '';
    }
    if (isset($v_ou_p) and ($v_ou_p == 'm')) {
        return '_m';
    }
}

// -----------------------------------------------------------------
function cal_date($str_dte, $days = 0)
{

    if (is_numeric($days)) {
        return date("Y-m-d", strtotime($str_dte) + 86400 * $days);
    } //
    elseif ($days == 'premier_de_ce_mois_ci') {
        return substr(ltrim($str_dte), 0, 8) . '01';
    } //
    elseif ($days == 'premier_du_mois_dernier') {
        $mois_dte = intval(substr(ltrim($str_dte), 5, 2));
        $annee_dte = intval(substr(ltrim($str_dte), 0, 4));
        return date('Y-m-d', mktime(0, 0, 0, $mois_dte - 1, 1, $annee_dte));
    } //
    elseif ($days == 'dernier_jour_du_mois_dernier') {
        $mois_dte = intval(substr(ltrim($str_dte), 5, 2));
        $annee_dte = intval(substr(ltrim($str_dte), 0, 4));
        return date('Y-m-d', mktime(0, 0, 0, $mois_dte, 0, $annee_dte));
    }
}
// -----------------------------------------------------------------
// calcule le nb de jours entre deux dates données
// au format '28-07-1954'
function nb_jours ($d1,$d2) {
    if ($d2 <  $d1) {
        $d = $d1;
        $d1 = $d2;
        $d2 = $d;
    }
    return (strtotime($d2) - strtotime($d1))/86400 + 1;
}

// -----------------------------------------------------------------

function inner_join($dv)
{
    return "
     INNER JOIN (
        SELECT  
        
            jeux,
            name_game,
            regie,
            id
    
            FROM reporting$dv
            WHERE display = 1
            
         GROUP BY id

        UNION
            SELECT jeux, 'AUTOPROMO' ,'Autopromo',1000
            FROM reporting_data$dv
            WHERE jeux ='AUTOPROMO'
    )";
}

// -----------------------------------------------------------------

function choix_periode_jeux()
{
    //return " and d.date between '2015-10-28' and '2015-10-28'";
    @$date_1 = (isset($_POST['date_1'])) ? $_POST['date_1'] : json_decode(file_get_contents("php://input"))->date_1;
    @$date_2 = (isset($_POST['date_2'])) ? $_POST['date_2'] : json_decode(file_get_contents("php://input"))->date_2;

    if ($date_2 < $date_1) return "  AND d.date BETWEEN '$date_2' AND '$date_1' ";
    else return "  AND d.date BETWEEN '$date_1' AND '$date_2' ";
}

// -----------------------------------------------------------------
// globale simple

function global_qry($whre = '', $lmit = '')
{
    global $where_exceptions;
    $dv = choix_bd();
    $join = inner_join($dv);

    $global_qry = " SELECT
            d.id_campaign   AS idCamp,
            d.date          AS Date,
            r.regie         AS Regie,
			r.name_game     AS Jeu,
			d.nom_campaign  AS Camp,
			ROUND(d.cout_dollard/d.nb_clic*(-1000),1) AS TjCPM,
			d.nb_transfo    AS Transfo,
			ROUND(d.cvr,2)  AS TjCVR,
			ROUND(d.bid,1)  As TjBid,
			d.nb_clic       As TjClic,
			Round(d.cout_dollard,2) AS TjCout,
			ROUND(d.gain_euros,2)   AS Gain,
			ROUND(d.ctr_login*100,2)AS CtrLogin,
			ROUND(d.ctr_game*100,2) AS CtrGame,
			ROUND(d.marge_euros,2)  AS Marge,
			IFNULL( 
			    ROUND( (-1)*d.marge_euros/d.cout_dollard*1.2 ,2 ),
			     SIGN(d.marge_euros)*1E308
			)As Renta,
			ROUND(d.contribution*100,2)          AS Contrib,
			ROUND(d.marge_euros/d.nb_clic*100,1) AS Val_1_clic

            FROM reporting_data$dv AS d

            $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

           WHERE  $where_exceptions    	$whre

           ORDER BY ROUND(marge_euros) DESC
           $lmit";

    return $global_qry;
}
// -----------------------------------------------------------------
// saisie pour une période

function periode_qry($whre = '', $lmit = '')
{
    global $where_exceptions;
    $dv = choix_bd();
    $join = inner_join($dv);

    $p_qry = "SELECT
                    d.id_campaign  AS idCamp,
                    d.date         As Date,
                    r.regie        AS Regie,
                    r.name_game    AS Jeu,
                    d.nom_campaign AS Camp,
                    SUM(d.nb_transfo) AS Transfo,
                    ROUND(SUM(d.cout_dollard)/SUM(d.nb_clic)*(-1000),1)     AS TjCPM,
                    ROUND(SUM(d.nb_transfo)/SUM(nb_clic)*100,2)             AS TjCVR,
                    ROUND( (-1)*SUM(d.cout_dollard) / SUM(d.nb_transfo),1 ) As TjBid,
                    SUM(d.nb_clic) As TjClic,
                    ROUND(SUM(d.cout_dollard))  AS TjCout,
                    ROUND(SUM(d.gain_euros))    AS Gain,
                    ROUND(AVG(ctr_login)*100,1) AS CtrLogin,
                    ROUND(AVG(ctr_game)*100,1)  AS CtrGame,
                    ROUND(SUM(d.marge_euros),1) AS Marge,
                    IFNULL (
                          ROUND( (-1)*SUM(d.marge_euros)/SUM(d.cout_dollard)*1.2 ,2 ),
                          SIGN(SUM(d.marge_euros))*1E308
                    ) As Renta,
                    ROUND( AVG(d.contribution )*100,1) AS Contrib,
                    ROUND( SUM(d.marge_euros)/SUM(d.nb_clic)*100,1) AS Val_1_clic

              FROM reporting_data$dv   AS d

              $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

              WHERE  $where_exceptions    	$whre

              GROUP BY d.id_campaign

              ORDER BY Marge DESC";

    return $p_qry;
}
// -----------------------------------------------------------------
// saisie pour une période

function gain_0_qry($d1, $d2 = '', $lmit = '') {

    $dv     = choix_bd();
    $join   = inner_join($dv);
    $d7     = cal_date($d1,-6);
    $d30    = cal_date($d1,-29);

        $a_qry  = " SELECT
                        d.id_campaign   AS idCamp,
                        r.regie         AS Regie,
                        r.name_game     AS Jeu,
                        g7.Gain_7       AS Gain_7,
                        g30.Gain_30     AS Gain_30,
                        gall.Gain_all   AS Gain_all,
                        d.nom_campaign  AS Camp,
                        ROUND( AVG  (d.nb_clic))          As TjClic,
                        ROUND( AVG  (d.cout_dollard),2)   AS TjCout,
                        ROUND( AVG  (d.marge_euros) ,2)   AS Marge,
                        ROUND( AVG  (d.gain_euros)  ,2)   AS Gain

                  FROM reporting_data$dv   AS d
                  $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux
                  ".

                  // sur 7 jours
                  "INNER JOIN (
                        SELECT  id_campaign,
                        ROUND(AVG (gain_euros),2) AS Gain_7

                        FROM reporting_data$dv
                        WHERE date BETWEEN '$d7' AND '$d1'
                        GROUP BY id_campaign
                  ) AS g7  ON g7.id_campaign = d.id_campaign
                  ".

                 // sur 30 jours
                 "INNER JOIN (
                        SELECT  id_campaign,
                        ROUND(AVG (gain_euros),2) AS Gain_30

                        FROM reporting_data$dv
                        WHERE date BETWEEN '$d30' AND '$d1'
                        GROUP BY id_campaign
                 ) AS g30 ON g30.id_campaign = d.id_campaign
                  ".

                 // sur toute la base
                "INNER JOIN (
                        SELECT  id_campaign,
                        ROUND(AVG (gain_euros),2) AS Gain_all

                        FROM reporting_data$dv
                        GROUP BY id_campaign
                ) AS gall ON gall.id_campaign = d.id_campaign
                 ".

                 // filtre final
                 "WHERE     d.gain_euros < 1
                            AND d.date BETWEEN '$d1' AND '$d2'
                 GROUP BY d.id_campaign
                  ";

    return $a_qry;
}

// -----------------------------------------------------------------
// saisie de la requete sql  pour le calcul des variations

function variation_qry($whre = '', $signature= '', $lmit = '')
{
    global $where_exceptions;
    $dv    = choix_bd();
    $join  = inner_join($dv);

    $p_qry = "SELECT
                    d.id_campaign                 AS idCamp,
                    d.date                        AS date,
                    ' $signature'                 AS Signature,
                    MAX( r.regie )                AS Regie,
                    MAX( r.name_game)             AS Jeu,
                    MAX( d.nom_campaign )         AS Camp,
                    ROUND (AVG(d.cout_dollard),2) AS Cout,
                    ROUND(AVG(d.nb_clic),0)       AS TjClic,
                    ROUND(AVG(d.marge_euros))     AS Marge
              FROM reporting_data$dv              AS d

              $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

              WHERE  $where_exceptions    	$whre

              GROUP BY d.id_campaign

              ORDER BY Marge DESC";

    return $p_qry;
}

// -----------------------------------------------------------------
// saisie complète du bilan
function bilan_qry($dte, $dddp)
{

    global $where_exceptions;
    $dv = choix_bd();
    $join = inner_join($dv);

    if (!isset ($dv)) $dv = '_dv';
    $select_bilan = "  Max(Bilan) AS Bilan,
                       ROUND(AVG(a.MG),0)  AS Marge,
                       ROUND(AVG(a.nbClics),0) AS Nb_clics,
                       MAX(a.Date) AS Date
    ";
    return

        // ce jour --------------------
        "
            SELECT $select_bilan
            FROM (
                    SELECT
                            ' Ce jour' AS Bilan,
                            SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                    $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

                     WHERE  $where_exceptions  AND d.date = ' $dte'

                     GROUP BY d.date
            ) AS a "

        . " UNION " . // hier --------------------

        "
            SELECT  $select_bilan
            FROM (
                    SELECT
                            ' Hier' AS Bilan,
                            SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                    $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

                     WHERE  $where_exceptions  AND d.date = ' " . cal_date($dte, -1) . " '

                     GROUP BY d.date
            ) AS a "

        . " UNION " . // 7 derniers jours ----------

        "
            SELECT  $select_bilan
            FROM (
                    SELECT
                            ' 7 derniers jours' AS Bilan, SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                     $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

                     WHERE  $where_exceptions  AND d.date BETWEEN '" . cal_date($dte, -6) . "  ' AND '$dte'

                     GROUP BY d.date
            ) AS a "

        . " UNION " . // 30 derniers jours ----------

        "
            SELECT  $select_bilan
            FROM (
                    SELECT
                            ' 30 derniers jours' AS Bilan, SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                     $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

                     WHERE  $where_exceptions  AND d.date BETWEEN '" . cal_date($dte, -29) . "  ' AND '$dte'

                     GROUP BY d.date
            ) AS a "

        . " UNION " .

        //  le mois en cours  ----------
        "
                SELECT  $select_bilan
                FROM (
                    SELECT
                            ' Ce mois en cours' AS Bilan, SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                    $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

                    WHERE  $where_exceptions AND d.date BETWEEN '" . cal_date($dte, 'premier_de_ce_mois_ci') . "  ' AND '$dte'

                    GROUP BY d.date
         ) AS a "

        . " UNION " .    // le mois dernier ---------------

        "
        SELECT  $select_bilan
        FROM (
            SELECT
                    ' Le mois dernier ' AS Bilan, SUM(d.marge_euros) AS MG,
                    SUM(d.nb_clic) AS  nbClics,
                    d.date AS Date
            FROM    reporting_data$dv AS d

            $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

            WHERE  $where_exceptions
            AND d.date BETWEEN '" . cal_date($dte, 'premier_du_mois_dernier') . "  ' AND '" . cal_date($dte, 'dernier_jour_du_mois_dernier') . "'

         GROUP BY d.date
        ) AS a "

        . " UNION " . // toute la période

        "
             SELECT  $select_bilan
             FROM (
                    SELECT
                            ' A partir de: ".$dddp."' AS Bilan, SUM(d.marge_euros) AS MG,
                            SUM(d.nb_clic) AS  nbClics,
                            d.date AS Date
                    FROM    reporting_data$dv AS d

                    $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux

            WHERE   $where_exceptions
            AND d.date BETWEEN '" .$dddp. "' AND '$dte'


            GROUP BY d.date
            ) AS a
    ";
}

// -----------------------------------------------------------------
// saisie partielle du bilan

function b_qry($select, $whre = '', $group = '', $order='')
{
    global $where_exceptions;
    $dv = choix_bd();
    $join = inner_join($dv);

    if (!isset ($dv)) $dv = '_dv';
    if ($order = '')  $order= '  ORDER BY d.date ASC ';

    $b_qry = "  SELECT   $select
                FROM reporting_data$dv AS d
                $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux
                WHERE  $where_exceptions  $whre
                $group

                $order

                ";
    return $b_qry;
}
// -----------------------------------------------------------------
// saisie partielle du bilan
// idem précédente mais que pour une campagne
// on a enlevé l'exception

function b_qry_une_campagne($select, $whre = '', $group = '', $order='')
{
    global $where_exceptions;
    $dv = choix_bd();
    $join = inner_join($dv);

    if (!isset ($dv)) $dv = '_dv';
    if ($order = '')  $order= '  ORDER BY d.date ASC ';

    $b_qry = "  SELECT   $select
                FROM reporting_data$dv AS d
                $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux
                WHERE  1 $whre
                $group

                $order

                ";
    return $b_qry;
}

// -----------------------------------------------------------------
// graph line sql
function graph_qry($type = 'marge', $opt = 'pour 1 regie ou 1 jeu uniquement')
{
    $date = (isset($_POST["date_1"])) ? $_POST["date_1"] : '2015-11-25' ;

    if (choix_bd() == '') {$field_bd = 'Mrg_w';}
    else { $field_bd ='Mrg'.choix_bd(); } //W base name case

    switch ($type) { // selection de la marge pour le graph XY
        case 'marge' :
            $select = " d.date AS Date,
                        ROUND(SUM(d.marge_euros),2) AS $field_bd ,
                        ROUND(SUM(d.nb_clic)/1000) AS Nb_clics ";
            $group = 'GROUP BY d.date';
            $where = " AND d.date > '$date' ";// limitation de la période
            return b_qry($select, $where, $group);
            break;

        case 'jeux': // selection de la marge des jeux pour le graph pie jeu sur une période
            $select = "
                d.date AS Date,
                'jeux' as Category,
                r.name_game AS Name,
                ROUND(SUM(d.marge_euros),2) AS Marge,
                ROUND(SUM(d.cout_dollard),2) AS Cout
            ";
            $group = 'GROUP BY  Name';
            $where = choix_periode_jeux();
            return b_qry($select, $where, $group,' ORDER BY r.name_game ');
            break;

        // on remonte simplement tous LES NOMS de tous le JEUX pour le graph XY
        case 'tous_les_jeux':
            $select = "  DISTINCT r.name_game AS Jeux,'ts_jeux' as Category  ";
            $group = '';
            $where = "  AND d.date > '$date' ";// limitation de la période
            return b_qry($select, $where, $group);
            break;

        //  On remonte la marge d'UN SEUL JEU en fonction du temps pour le graphe xy
        case 'un_jeu' :
            $select = " d.date AS Date, ROUND(SUM(d.marge_euros),2) AS Marge, ROUND(SUM(d.nb_clic)/1000) AS Nb_clics, r.name_game as Jeu ";//
            $group = 'GROUP BY d.date';
            $where = "  AND r.name_game = '$opt'   AND d.date > '$date' "; // $opt is the regie name
            return b_qry($select, $where, $group);
            break;

        // pies
        case 'regies' :
            $select = "
                d.date AS Date,
                'regies' AS Category,
                r.regie  AS Name,
                ROUND(SUM(d.marge_euros),2) AS Marge,
                ROUND(SUM(d.cout_dollard),2) AS Cout
            ";
            $group = 'GROUP BY  Name';
            $where = choix_periode_jeux();
            return b_qry($select, $where, $group);
            break;

        // on remonte simplement tous LES NOMS de toutes régies pour le graph XY
        case 'toutes_les_regies':
            $select = "  DISTINCT r.regie AS Regies,'tt_regies' as Category  ";
            $group = '';
            $where = "   AND d.date > '$date' ";
            return b_qry($select, $where, $group);
            break;

        case 'une_regie' ://  On remonte la marge d'UNE SEULE REGIE en fonction du temps pour le graphe xy
            $select = " d.date AS Date, ROUND(SUM(d.marge_euros),2) AS Marge, ROUND(SUM(d.nb_clic)/1000) AS Nb_clics, r.regie as Regie ";
            $group = 'GROUP BY d.date';
            $where = "  AND r.regie = '$opt'   AND d.date > '$date' "; // $opt is the regie name
            return b_qry($select, $where, $group);
            break;

        case 'une_campagne' ://  On remonte la marge d'UNE SEULE Campagne en fonction du temps pour le graphe xy
            $select = " d.date AS Date, ROUND(SUM(d.marge_euros),2) AS Marge, ROUND(SUM(d.nb_clic)/1000) AS Nb_clics, d.id_campaign as IdCamp ";
            $group = 'GROUP BY d.date';
            $where = "  AND d.id_campaign = '$opt'    AND d.date > '$date' "; // $opt is the camp id
            return b_qry_une_campagne($select, $where, $group);
            break;

        case 'camp' : // remonte la marge des campagnes sur une période
            $select = "
                d.date AS Date,
                'camp' AS Category,
                CONCAT( '~',r.regie,'~',d.nom_campaign,'~',r.name_game , '~')  AS Name,
                ROUND(SUM(d.marge_euros),2) AS Marge,
                ROUND(SUM(d.cout_dollard),2) AS Cout
            ";
            $group = 'GROUP BY  Name';
            $where = choix_periode_jeux();
            return b_qry($select, $where, $group);
            break;

        case 'campaigns' : // idem précédent, autre méthode
            $select = "
                d.date AS Date,
                'camp' AS Category,
                d.nom_campaign AS Name,
                r.regie AS Regies ,r.name_game AS Jeux,
                ROUND(SUM(d.marge_euros),2) AS Marge
            ";
            $group = ' GROUP BY  Name ';
            $where = choix_periode_jeux();
            return b_qry($select, $where, $group);
            break;

        case 'jeux_et_regies' :
            return '(' . graph_qry('jeux') . ')  UNION   (' . graph_qry('regies') . ')';
            break;

        case 'jeux_regies_et_camp' :
            return '(' . graph_qry('jeux') . ')  UNION   (' . graph_qry('regies') . ')  UNION   (' . graph_qry('camp') . ')';
            break;

        case 'levier' : // idem précédent, autre méthode
            $select = "
               r.name_game AS Jeux,
               r.regie AS Regie,
               ROUND(SUM(d.marge_euros),2) AS Marge,
               SUM(d.nb_clic) AS Nb_clics
            ";
            $where = choix_periode_jeux();
            $group = ' GROUP BY r.name_game, r.regie ';
            return b_qry($select, $where, $group);
            break;
    }
}

// -----------------------------------------------------------------
// Saisie des modifs
// -----------------------------------------------------------------
function modifs_qry($date_1)
{
    $dv = choix_bd();
    $n_jours = 3; // 7 jours effectifs

    switch ($dv) {
        case '_dv'  : $dv_dp = 'DV';            break;
        case '_dp'  : $dv_dp = 'DP';            break;
        case ''     : $dv_dp = 'W';             break;
        case '_m'   : $dv_dp = 'M';             break;
        default     : $dv_dp = 'DV'; $dv='_dv'; break;
    }
    $qry = " SELECT
                    mdf.cid AS IdCamp,
                    mdf.date AS Date,
                    rdv.regie AS Regie,
                    rdv.name_game AS Jeu,

                    ( SELECT AVG(marge_euros)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN DATE_ADD(mdf.date, INTERVAL -$n_jours  DAY) AND mdf.date ) AND (mdf.cid = id_campaign)
                    ) AS avg_mrg_avant,
                    ( SELECT AVG(nb_clic)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN DATE_ADD(mdf.date, INTERVAL -$n_jours  DAY) AND mdf.date ) AND (mdf.cid = id_campaign)
                    ) AS avg_clc_avant,
                    ( SELECT AVG(marge_euros)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN mdf.date AND DATE_ADD(mdf.date, INTERVAL  $n_jours  DAY) ) AND (mdf.cid = id_campaign)
                    ) AS avg_mrg_apres,
                    ( SELECT AVG(nb_clic)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN mdf.date AND DATE_ADD(mdf.date, INTERVAL  $n_jours  DAY) ) AND (mdf.cid = id_campaign)
                    ) AS avg_clc_apres,

                    dta.name_campaign AS Camp,
                    mdf.texte AS Modif

             FROM modifs AS mdf

             INNER JOIN reporting$dv as rdv   ON rdv.id = mdf.cid

             INNER JOIN(
                SELECT
                      id_campaign,
                      MAX(nom_campaign) AS name_campaign
                FROM reporting_data$dv
                GROUP BY id_campaign
             ) AS dta
             ON dta.id_campaign =mdf.cid

             WHERE ( mdf.famille LIKE '%$dv_dp%' ) AND ( mdf.date >= '$date_1' )
             ORDER BY avg_mrg_apres DESC
             LIMIT 20
    ";
    return $qry;
}

// -----------------------------------------------------------------
// Saisie des modifs des bid
// -----------------------------------------------------------------
function bid_qry($date_1)
{
    $dv = choix_bd();
    $n_jours = 6; // 7 jours effectifs

    switch ($dv) {
        case '_dv'  : $dv_dp = 'DV';            break;
        case '_dp'  : $dv_dp = 'DP';            break;
        case ''     : $dv_dp = 'W';             break;
        case '_m'   : $dv_dp = 'M';             break;
        default     : $dv_dp = 'DV'; $dv='_dv'; break;
    }
    $qry = " SELECT
                    mdf.cid AS IdCamp,
                    mdf.date AS Date,
                    mdf.new_bid AS New_bid,
                    rdv.regie AS Regie,
                    rdv.name_game AS Jeu,

                     ( SELECT AVG(marge_euros)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN DATE_ADD(mdf.date, INTERVAL -$n_jours  DAY) AND mdf.date ) AND (mdf.cid = id_campaign)
                    ) AS avg_mrg_avant,
                    ( SELECT AVG(nb_clic)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN DATE_ADD(mdf.date, INTERVAL -$n_jours  DAY) AND mdf.date ) AND (mdf.cid = id_campaign)
                    ) AS avg_clc_avant,
                    ( SELECT AVG(marge_euros)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN mdf.date AND DATE_ADD(mdf.date, INTERVAL  $n_jours  DAY) ) AND (mdf.cid = id_campaign)
                    ) AS avg_mrg_apres,
                    ( SELECT AVG(nb_clic)
                          FROM reporting_data$dv
                          WHERE (date BETWEEN mdf.date AND DATE_ADD(mdf.date, INTERVAL  $n_jours  DAY) ) AND (mdf.cid = id_campaign)
                    ) AS avg_clc_apres,

                    dta.name_campaign AS Camp,
                    mdf.comment AS Modif,
                    mdf.new_bid AS New_bid,
                    mdf.old_bid AS Old_bid

             FROM modifs_bid AS mdf

             INNER JOIN reporting$dv as rdv
             ON rdv.id = mdf.cid

             INNER JOIN(
                SELECT
                      id_campaign,
                      MAX(nom_campaign) AS name_campaign
                FROM reporting_data$dv
                GROUP BY id_campaign
             ) AS dta
             ON dta.id_campaign = mdf.cid

             WHERE ( mdf.famille LIKE '%$dv_dp%' ) AND ( mdf.date >= '$date_1' )
             ORDER BY mdf.date DESC
    ";
    return $qry;
}

// ----------- TESTS

//$date_1 = '2015-12-27';$date_2 = '2015-10-28';
//echo modifs_qry($date_1);

//$d = '2016-01-03';
//echo gain_0_qry($date_1,$date_2);
//echo graph_qry('une_regie','V_TJ' ).' <br>' ;
//echo graph_qry('levier' ).' <br>' ;
//echo cal_date($d, 'premier_de_ce_mois_ci').' '. cal_date($d, 'dernier_jour_du_mois_dernier');
//echo '<br>';
//echo bilan_qry($d);
//$m = 7;
//$y = 2015;
//$mois = 7;
//echo intval(date("t", $mois)) . '<br>';
//$MoisPrecedent = date('m', mktime(12, 0, 0, date("m"), 0, date("Y")));
//echo $MoisPrecedent;
//echo variation_qry("AND d.date BETWEEN '$date_1' AND '$date_2'",'v7');
//echo nb_jours($date_1, $date_2). '<br>';
