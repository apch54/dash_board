<?php

/*
       __         ______                        __
.----.|  |.-----.|   __ \.-----.-----.  .-----.|  |--.-----.
|  __||  ||__ --||      <|  -__|  _  |__|  _  ||     |  _  |
|____||__||_____||___|__||_____|__   |__|   __||__|__|   __|
                                  |__|  |__|         |__|
23-06-2016
==========.==========.==========.==========
 calcule la requête
 utilisation :
    1/ construction : req =  new Requete($base, $but, $dte1, $dte2, $v);
    2/ appel de qry : $qry=  req->oneCmpSql();
==========.==========.==========.==========
*/
class Requete{

    private $base ='';  // variables d'instance
    private $but  ='';  //'1camp',...
    private $dt1  ='';  //dt1 <dt2
    private $dt2  ='';
    private $idCmp='';

    function __construct ($bse, $bt, $d1, $d2, $v){
        $this->base  =$bse;
        $this->but   =$bt;
        $this->dt1   =$d1;
        $this->dt2   =$d2;
        $this->idCmp =$v;  // var supplémentaire
    }

    /*
    ----------.----------.---------.----------
    fonction pratiques d'interface
    ----------.----------.---------.----------
    */
    public function setBut   ($b) {$this->but=$b;}
    public function setdt1   ($d) {$this->dt1=$d; }
    public function setdt2   ($d) {$this->dt2=$d;}
    public function setIdCmp ($c) {$this->idCmp=$c;}
    public function setBase  ($b) {$this->base=$b;}
    public function getDddr  ()   {return $this->dddr($this->base);}
    public function oneCmpSql()   {return $this->oneCmpSqlfull();}

    /*
    ----------.----------.---------.----------
    cal de la dddr ; la date la plus haute ds la base
    on choisit par deéfaut la base dv
    ----------.----------.---------.----------
    */
    private function dddr($base){
        $dv=$this->choix_bd($base);
        return "SELECT `date`
                FROM `reporting_data_dv`  
                ORDER BY `date` 
                DESC LIMIT 1
         ";
    }

     /*
    ----------.----------.---------.----------
    cal 1 line request
    base est dv, dp w ou m
    ----------.----------.---------.----------
    */
    private function oneCmpSqlfull() {

        $this->verifDates();

        $where_exceptions = $this->w_exceptions();
        $dv=$this->choix_bd($this->base);
        $join = $this->inner_join_2($dv);

        $p_qry = "SELECT
                '==> base =$dv ; idCmp = $this->idCmp  ;  dt1 = $this->dt1 ; dt2 = $this->dt2' AS req,
                d.id_campaign AS idCamp,
                MAX( r.regie ) AS regie,
                MAX(r.name_game) AS jeu,
                MAX(d.nom_campaign ) AS camp,
                SUM(d.nb_transfo) AS nb_transfos,
                ROUND(SUM(d.cout_dollard)/SUM(d.nb_clic)*(-1000),2) AS CPM,
                ROUND(SUM(d.nb_transfo)/SUM(nb_clic)*100,2) AS CVR,
                SUM(d.nb_transfo) AS nb_transfo,
                ROUND( (-1)*SUM(d.cout_dollard) / SUM(d.nb_transfo),2 ) As bid,
                SUM(d.nb_clic) As nb_clics,
                ROUND (SUM(d.cout_dollard),2) AS cout_dollard,
                ROUND(SUM(d.gain_euros)) AS gain_euro,
                ROUND( AVG(ctr_login)*100,2) AS ctr_login,
                ROUND(AVG(ctr_game)*100,2) AS ctr_game,
                ROUND(SUM(d.marge_euros),2) AS marge,
                ROUND( (-1)*SUM(d.marge_euros)/SUM(d.cout_dollard)*1.2 ,2 ) As renta, 
                ROUND( SUM(d.marge_euros)/SUM(d.nb_clic)*100,2) AS val_1_clic

        FROM reporting_data$dv   AS d

        $join  AS r ON  r.id = d.id_campaign -- r.jeux = d.jeux 
        WHERE  d.id_campaign= $this->idCmp
            AND (d.date BETWEEN '$this->dt1' AND '$this->dt2')
        GROUP BY d.id_campaign
        ORDER BY Marge DESC
        ";
        //echo $p_qry;
        return $p_qry;
    }

     /*---------.----------.---------.----------
    jointure et exception
    texte permettant une factorisation de la jointure
    ----------.----------.---------.----------
    */
    public function inner_join_2($dv)
    {
        return "
     INNER JOIN (
        SELECT  
        
        MAX(jeux) as jeux,
        MAX(name_game) as name_game,
        MAX(regie) as regie,
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

    /*
    ----------.----------.---------.----------
     erreurs de base éliminées par convention
    ----------.----------.---------.----------
    */
    public  function w_exceptions() {
       return "
        d.cvr != ''
        AND d.nb_clic != ''
        AND d.cout_dollard !='' 

        ";
       
       //return "  d.crv != '#&{' ;"
    }

     /*
    ----------.----------.---------.----------
    donne l'extension de la base
    ----------.----------.---------.----------
    */
    private function choix_bd($base) {
        echo $base;
        if   (in_array( $base, array('dv','dp','m','o','at'))) {return '_'.$base;}
        else {return '';}       // retourne la base w en cas d'erreur de base
    }


    /*
    ----------.----------.---------.----------
    petite date avant
    ----------.----------.---------.----------
    */
    private function verifDates() {
        if ($this->dt1 > $this->dt2) {//petite date avant
            $d3= $this->dt2;
            $this->dt2= $this->dt1;
            $this->dt1= $d3;
        }
    }
}
