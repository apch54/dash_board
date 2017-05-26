<?php
/**
 * SE charge seulement de la connection
 * User: apch
 * Date: 17/08/2016
 * Time: 10:50

----------.----------.---------.----------
 usage
1/ $c = new Connect();
2/ $con = $c ->logIn();
3/ $con->query($sql);
for $co is a LINK object
   ----------.----------.---------.----------
  */
class Connect{
    public $server=''; //show wich choose server
    /*
    ----------.----------.---------.----------
    context research, choose server
    ----------.----------.---------.----------
    */
    function __construct(){
        $s= gethostbyaddr ( $_SERVER['REMOTE_ADDR']);
        if ($s == 'apch-PC'){$this->server='local';}
        else {$this->server='gamisio';}
    }
    /*
   ----------.----------.---------.----------
   connexion à la base
   deux possibilités locale ou gameisio
    ----------.----------.---------.----------
   */
    public function logIn()
    {
        $vLink = $this->logs[$this->server] ;
        // echo $vLink['host']; echo '  '.$vLink['user']; echo '  '.$vLink['pass']; echo '  '.$vLink['base'];
        $link = mysqli_connect( $vLink['host'], $vLink['user'], $vLink['pass'], $vLink['base'] );

        // sinon erreur à traiter
        if (mysqli_connect_errno()){
            echo erreur ("Connection to MySQL failed: " , mysqli_connect_error());
        }
        return $link;
    }

    /*
    /*
   ----------.----------.---------.----------
   Variables de choix de la connexion
   ----------.----------.---------.----------
   */
    private $logs=array(

        "local"=> array(
            "host" => "localhost",
            "user" => "root",
            "pass" => "",
            "base" => "db_eric"
        ),

        "gamisio" => array(
            "host" => "clicmyphotos.cfjksv2azdoo.ap-southeast-1.rds.amazonaws.com",
            "user" => "clicpyphotos",
            "pass" => "webuser11",
            "base" => "clicmyphotos"
        ));
}
/*
  ----------.----------.---------.----------
  test
  ----------.----------.---------.----------

$c= new Connect();
echo $c->server;
*/
?>

