
<?php

/*
==========.==========.==========.==========
déclenche la recherche d'une campagne sur gameisio
ou pour le test
adaptée pour toute sorte de requçetes
METHODE = GetDddr
==========.==========.==========.==========
*/

class ApiDB{
    // requête demandée du type Requete ; 
    // founie par la func getDta(...) ; c'est un obj peu exploitable
    private $reqSql; 
    // requête sous forme texte; 
    // fournie par getDta  requete lisible
    private  $qry; 
    // connexion à la bd fournie par la func lgin(...)   
    public $link;     
    private $lgin;   // init par __construct
    //private $raw = false;

    /*
    ----------.----------.---------.----------
     Interface utilisateur
    ----------.----------.---------.----------    
    */    
    public function set1Camp  ($base, $dte1, $dte2, $idCmp){$this->setReq($base,'1 camp', $dte1, $dte2, $idCmp);}
    public function getData   ()   {return $this->getJson($this->link);}    
    public function setDate1  ($dt){$this->reqSql->setdt1  ($dt);}
    public function setDate2  ($dt){$this->reqSql->setdt2  ($dt);}
    public function setBase   ($b) {$this->reqSql->setbase ($b);}
    public function setIdCmp  ($b) {$this->reqSql->setIdCmp($b);}
    public function updateData()   {$this->updateReq(); $this->getData();}
    public function getDddr   ()   {return $this->dddr();} 

    /*
    ----------.----------.---------.----------
     constructeur :le constructeur ne fait que localiser la base
    ----------.----------.---------.----------
    */ 
    function __construct($lgin='gamisio') { 
        $this->lgin=$lgin;
    } 

    /*
    ----------.----------.---------.---------
    Appelle la raquête retourne une instance Requete (objet)
    qui n'est que la formulation de la req
    puis se connecte
    ----------.----------.---------.----------
    */

    public function  setReq($base, $but, $dte1, $dte2, $v){
       
        // écriture de la requête
        $this->reqSql = new Requete($base, $but, $dte1, $dte2, $v);        
        // transformation de la reqête en texte
        $this->qry=$this->reqSql->oneCmpSql(); 
        // connexion
        $this->logIn($this->lgin); 
    }

    private function updateReq() {$this->qry=$this->reqSql->oneCmpSql(); }

    //  renvoi la requete sous forme de sql texte
    //  reqSql est une instance de Requete
    //  util en dbug seulement
    public function reqSqlTxt() { return $this->reqSql->oneCmpSql();}

     /*
    ----------.----------.---------.---------
    demande dddr; methode
    ----------.----------.---------.----------
    */
    private function dddr(){ 

        // 1/ création de la requete
        // 2/ remplir qry par la méthode reqSql
        // 3/ se connecter e
        // 4/ envoyer la requete la transformer en json ou en autre 

        $this->reqSql = new Requete('', 'dddr','', '', '');// 'dddr': but
        $this->qry=$this->reqSql->getDddr();
        $this->logIn($this->lgin); 
        $foo=$this->getArray($this->link);
        return $foo[0]['date'];
    }

    /*
    ----------.----------.---------.----------
    connexion à la base
    deux possibilités locale ou gameisio
     ----------.----------.---------.----------
    */
    public function logIn($lgin){
  
        if( $lgin == 'gamisio'){$vLink = $this->logs["gamisio"] ; }
        else { $vLink = $this->logs["local"] ;}

        // echo $vLink['host']; echo '  '.$vLink['user']; echo '  '.$vLink['pass']; echo '  '.$vLink['base'];
        $this->link = mysqli_connect( $vLink['host'], $vLink['user'], $vLink['pass'], $vLink['base'] );

        // sinon erreur à traiter
        if (mysqli_connect_errno()){
            echo erreur ("Connection to MySQL failed: " , mysqli_connect_error());
        }
        /*
        else{
            echo "<div style = 'color:#0333ff'>Connection '$lgin' réussie </div><br>";
        }*/
    }

    /*
    ----------.----------.---------.----------
    retourne la requête demabdé ds un json
    ----------.----------.---------.----------
    */
    private function  getJson($link){
        $req= $link->query($this->qry);
        if (!$req) {
            die(erreur("Query failed : (" . $link->errno . ") "));
        }

        $json = ''; // sql -> arr
        While ($row = $req->fetch_assoc()) {
            $json[] = $row;
        }
        if (!isset($json[0]))  { // base vide
            die (erreur("ERROR in URL parameters : data empty : class 'Requete'"));
        }
        
        return json_encode($json[0]);

        //if ($this->raw) echo $json ;
        //else  echo print_json($json);
    }
     /*
    ----------.----------.---------.----------
    retourne la requête demabdé ds un array
    ----------.----------.---------.----------
    */
    private function  getArray($link){
        $req= $link->query($this->qry);
        if (!$req) {
            die( erreur("Query failed: (", $link->errno . ")"));
        }
        $arr = ''; // sql -> arr
        While ($row = $req->fetch_assoc()) {
            $arr[] = $row;
        }
        if (!isset($arr[0]))  { // base vide
            die (erreur("ERROR in URL parameters : data empty","class 'Requete'"));
        }        
        return $arr;
    }

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

}// fin de la classe OneLine
