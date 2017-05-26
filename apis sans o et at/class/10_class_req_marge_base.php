<?php

class Req_marge
{
    private $b = '';
    private $dv = '';
    private $dt1 = '';
    private $dt2 = '';

    public function __construct($b, $dv = 'm', $dt1 = '', $dt2 = '')
    {
        $this->b = $b;
        $this->dv = $this->choix_bd($dv);
        $this->dt1 = $dt1;
        $this->dt2 = $dt2;
    }

    /*  ----------.----------.---------.----------*/
    public function marge_sql()
    {
        $where_exceptions = $this->w_exceptions();
        $dv = $this->choix_bd($this->dv);
        $join = $this->inner_join($this->dv);

        $p_qry = "SELECT" . "           
                ROUND(SUM(d.marge_euros),2) AS marge 
                FROM reporting_data$this->dv   AS d
                
                $join  AS r ON  r.id = d.id_campaign 
                WHERE  $where_exceptions  AND (d.date BETWEEN '$this->dt1' AND '$this->dt2') 
            ";
        return $p_qry;
    }

    /*  ----------.----------.---------.----------*/
    public function inner_join($dv)
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
    public function w_exceptions()
    {
        return "
                d.cvr != ''
                AND d.nb_clic != ''
                AND d.cout_dollard !='' ";
    }

    /*
    ----------.----------.---------.----------
    donne l'extension de la base
    ----------.----------.---------.----------
    */
    private function choix_bd($base)
    {
        if (in_array($base, array('dv', 'dp', 'm'))) {
            return '_' . $base;
        } else {
            return '';
        }       // retourne la base w en cas d'erreur de base
    }
}

/*
----------.----------.---------.---------
tests
----------.----------.---------.----------
*/
//echo 'test : ';
//$m = new Req_marge('but','dv', '2015-12-25','2016-01-10');
//echo $m->marge();
?>