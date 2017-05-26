<?php

$me = __FILE__;
$server = $_SERVER["SERVER_NAME"];
$local = $_SERVER["SERVER_NAME"] === "127.0.0.1";
$me = '';  // à définir

//----------------------------------------------------------------------
function is_apch_pc()
{
    return getenv("COMPUTERNAME") == "APCH-PC-PRINCIP"; // je suis chez apch
}

//----------------------------------------------------------------------
function scan_dir($dir)
{ // scan récursif du rep $dir
    global $me;
    $myDir = opendir($dir) or die(erreur("Erreur : dans scan_dir : $me."));
    while ($f = @readdir($myDir)) {
        if (is_dir($dir . '/' . $f) && $f != '.' && $f != '..') {
            echo "<br/>";
            scan_dir($dir . '/' . $f);
        } else {
            if ($f != '.' && $f != '..') {
                echo "'$dir/$f', ";
            }
        }
    }
    closedir($myDir);
}

//----------------------------------------------------------------------
// Mon die qui done le nom du fichier et le numero de le ligne
function fc_die($str, $dans = 'origine inconnue')
{
    die("------------------------------------- <br>" .
        " erreur dans " . $dans .
        " <br>" .
        $str . "<br>" .
        "---------------------------------------- <br><br>"
    );
}

//-----------------------------------------------
// renvoie la valeur de l'UNIQUE variable de la ligne de commande
// attention la variable doit être unique
// renvoie faux si aucune variable n'est donnée sue la ligne de cde
function last_var_URL()
{
    $s = $_SERVER['REQUEST_URI'];
    $p = strpos($s, "=");

    if (!$p) {
        Return false;
    } else {
        Return trim(substr($s, $p + 1));
    }
}

//-------------------------------------------------------------------
//  retourne la variable $v passée ds la ligne de cde ; exit si erreur
//   faire précéder les variables par _  : prudence
//   une erreur va se produire si la définition d'une variable est contenu dans l'autre
//  ressemble à la précédente fonctionmais plus précise
// plus utile utiliser davantage  la var glob $_GET
function var_URL($v)
{
    $s = $_SERVER['REQUEST_URI'];

    if ($p = strpos($s, $v)) {
        $s = substr($s, $p);
        if ($p1 = strpos($s, "=")) {
            if ($p2 = strpos($s, "&")) {
                $rr = trim(substr($s, $p1 + 1, $p2 - 1 - $p1));
            } else {
                $rr = trim(substr($s, $p1 + 1));
            }
            $rr = ereg_replace(" ", "%20", $rr);
            return $rr;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

//-------------------------------------------------------------------
//  retourne VRAI la variable $v passée ds la ligne de cde existe
//   faire précéder les variables par _  : prudence
//   une erreur va se produire si la définition d'une variable est contenu dans l'autre
//  usage if(var_URL_exits("toto"){$toto=var_URL('toto');}

function var_URL_exists($v)
{
    $s = $_SERVER['REQUEST_URI'];

    if (strpos($s, $v)) {
        Return true;
    } else {
        Return false;
    }
}

//-----------------------------------------------
// calcule le chemin du script en cours
// chemin depuis le serveur
function path_script()
{
    $ss = explode("/", " " . $_SERVER['SCRIPT_NAME']);
    $rs = " ";
    for ($ii = 1; $ii < count($ss) - 1; $ii++) {
        $rs .= $ss[$ii];
        if ($ii < count($ss) - 2) {
            $rs .= "/";
        }
    }
    Return $rs; // retourne le chemin
}

//-----------------------------------------------
function est_valide_mail($email)
{
    $mail_valide = ereg("([A-Za-z0-9]|-|_|\.)*@([A-Za-z0-9]|-|_|\.)*\.([A-Za-z0-9]|-|_|\.)*", $email);

    if ($mail_valide) return 1;
    else return 0;
}

//------------------------------------------------
// Extraire une chaine
function extraire($text, $deb, $fin)
{
    $d = strpos($text, $deb); // début
    if ($d === false) {
        return "err_fc";
    };
    $d = $d + strlen($deb);
    $f = strpos($text, $fin);
    if ($f === false) {
        return "err_fc";
    };
    //echo $d, "    ", $f;
    return trim(substr($text, $d, $f - $d));
}
/*
----------.----------.---------.----------
erreur
----------.----------.---------.----------
*/
function erreur($t1,$t2='', $coul='red'){
    return " 
        <br>
        <br><div style='color:$coul'> $t1 ; $t2 </div>
        <br>
    ";
}
//-----------------------------------------------
function fc_alert($str)
{
    echo
        "<div style='background-color : #ebcccc'>\n
	    ------------------------------------- <br><br>\n
		erreur dans " . __FILE__ .
        "<br>
		<center>$str </center><br><br>
		------------------------------------- <br><br>
		</div>";
}

//-----------------------------------------------
function fc_dump($str)
{
    echo "<pre>\n";
    echo $str;
    echo "</pre>\n";
}

// affiche une string json -----------------------
// ne pas utiliser avec angullarjs
function print_json($input_str)
{
    $m = ""; // marge
    $f = array("}", "]");
    $o = array("{", "[");
    $ind_str = $ind_guill = $guill_ouvert = 0;
    $max = 300;
    while ($ind_str < strlen($input_str)) {
        $c = $input_str[$ind_str++];

        if (in_array($c, $o)) {
			
            echo "<br>" . $m . $c . "&nbsp&nbsp;";
            $m = $m . "&nbsp;&nbsp;&nbsp;&nbsp;"; // marge
        } elseif (in_array($c, $f)) {
            $m = substr($m, 0, strlen($m) - 24);
            echo "<br>" . $m . $c;
        } elseif ($c == ",") {
            if ($input_str[$ind_str - 2] == '"') echo $c . "<br>" . $m;
            else {
                if ($ind_guill <= $max) {
                    echo $c;
                }
            }
        } elseif ($c == '"') {
            if ($guill_ouvert and $ind_guill >= $max) echo '...';
            echo $c;
            $guill_ouvert = !$guill_ouvert;
            $ind_guill = 0;
        } elseif ($c == ':') {
            echo " $c ";
            //$guill_ouvert = !$guill_ouvert;
            $ind_guill = 0;
        } elseif ($guill_ouvert) {
            $ind_guill++;
            if ($ind_guill < $max) echo $c;
        } else echo $c;
    }
}
 function echo_json($json, $html = true, $tabspaces = 4)
    {
        $tabcount = 0;
        $result = '';
        $inquote = false;
        $ignorenext = false;

        if ($html) {
            $tab = str_repeat("&nbsp;", ($tabspaces == null ? 4 : $tabspaces));
            $newline = "<br/>";
        } else {
            $tab = ($tabspaces == null ? "\t" : str_repeat(" ", $tabspaces));
            $newline = "\n";
        }

        for($i = 0; $i < strlen($json); $i++) {
            $char = $json[$i];

            if ($ignorenext) {
                $result .= $char;
                $ignorenext = false;
            } else {
                switch($char) {
                    case ':':
                        $result .= $char . (!$inquote ? " " : "");
                        break;
                    case '{':
                        if (!$inquote) {
                            $tabcount++;
                            $result .= $char . $newline . str_repeat($tab, $tabcount);
                        }
                        else {
                            $result .= $char;
                        }
                        break;
                    case '}':
                        if (!$inquote) {
                            $tabcount--;
                            $result = trim($result) . $newline . str_repeat($tab, $tabcount) . $char;
                        }
                        else {
                            $result .= $char;
                        }
                        break;
                    case ',':
                        if (!$inquote) {
                            $result .= $char . $newline . str_repeat($tab, $tabcount);
                        }
                        else {
                            $result .= $char;
                        }
                        break;
                    case '"':
                        $inquote = !$inquote;
                        $result .= $char;
                        break;
                    case '\\':
                        if ($inquote) $ignorenext = true;
                        $result .= $char;
                        break;
                    default:
                        $result .= $char;
                }
            }
        }

        echo $result;

    }

//--------------------------------------------------------
// 2015/07/10 fc : à utiliser si le pack json pas install
// Transform recursive)a variable into its json
// @param mixed the variable
// @return string json
function fc_var_to_json($var)
{
    $asso = false;
    switch (true) {
        case is_null($var) :
            return 'null';
        case is_string($var) :
            return '"' . addcslashes($var, "\"\\\n\r/") . '"';
        case is_bool($var) :
            return $var ? 'true' : 'false';
        case is_scalar($var) :
            return (string)$var;
        case is_object($var) :
            $var = get_object_vars($var);
            $asso = true;
        case is_array($var) :
            $keys = array_keys($var);
            $ikey = count($keys);
            while (!$asso && $ikey--) {
                $asso = $ikey !== $keys[$ikey];
            }
            $sep = '';
            if ($asso) {
                $ret = '{';
                foreach ($var as $key => $elt) {
                    $ret .= $sep . '"' . $key . '":' . fc_var_to_json($elt);
                    $sep = ',';
                }
                return $ret . "}";
            } else {
                $ret = '[';
                foreach ($var as $elt) {
                    $ret .= $sep . fc_var_to_json($elt);
                    $sep = ',';
                }
                return $ret . "]";
            }
    }
    return false;

    if (!function_exists('json_encode')) {

        function json_encode($v)
        {
            return fc_var_to_json($v);
        }
    }
}

//-----------------------------------------------
// 2015/06/29 affiche une image lien bootstap
function a_img($_a_url = '#myModal', $_a_path_img = "./img/error_img.jpg", $_a_width = 100, $_a_txt = '', $_a_shape = "circle")
{
    if (!file_exists($_a_path_img)) {
        $_a_path_img = './img/error_img.jpg';
        $_a_txt = 'Error in img path';
        $_a_width = 100;
        $_a_shape = thumbnail;
    }
    return
        "<a href=' $_a_url ' data-toggle='modal'>
			<img src='$_a_path_img  '  alt='Sioux' width='$_a_width' class='img-\$_a_shape' >
		</a>
		<p style='text-align : center;'>$_a_txt</p>";
}

//-----------------------------------------------
// renvoie une stg qui donne aujourd'hui - $nd
function date_before_today ($nd=0){
    return date("Ymd", mktime(0,0,0,date("m"),date("d")-$nd,date("Y")));

}
/*
-----------------------------------------------
on scrute le répertoire supérieur
-----------------------------------------------
*/
function scan_dir_up($needle)
{
    $f_trouve = '';
    $myDir = opendir('../') or die(erreur('Erreur ds le scan de répertoire ',' - 03_tools.php'));
    while ($f = @readdir($myDir)) { 

       
        if (strpos($f,$needle)!==false) {            
           if ($f>$f_trouve ) {$f_trouve = $f;}
           //echo $f .' =? '.$needle.' <br>';
        }
    }
    closedir($myDir);
    if ($f_trouve>'') { return $f_trouve;}
    else  return false;
}
//-----------------------------------------------
// retourne vrai si le  dossier de sauvegarde existe ex: xyz_20160209
function save_folder_exists($nd){

    //echo 'xyz_'.date_before_today($nd).'<br>';
    $dte = date_before_today($nd);
    return scan_dir_up('xyz_'.$dte);
}

//-----------------------------------------------
// retourne le nom du fichier de sauvegarde   ex: xyz_20160209
function saved_folder(){

    $i=0; $fl='';
    while ( ($fl = save_folder_exists($i++) ) === false){
        if ($i>183) return 'Aucune sauvegarde récente.';
    }

    return " Lst vers working: <a href='../$fl'  target='_blank' > $fl </a>";
    //return 'xyz_'.date_before_today($i);
}
//-----------------------------------------------
// tests
//echo saved_folder();
//echo save_folder_exists(61)?'true' : 'false';
//echo saved_folder();

// FIN DES OUTILS ===============================
?>

