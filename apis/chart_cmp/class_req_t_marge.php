
<?php


class Req_t_marge
{
    private $id_camp = '';
    private $dv = '';
    private $dt1 = '';
    private $dt2 = '';

    public function __construct($id, $dv = 'm', $dt1 = '', $dt2 = '')
    {
        $this->id_camp = $id;
        $this->dv = $this->choix_bd($dv);
        $this->dt1 = $dt1;
        $this->dt2 = $dt2;
    }

    /*  ----------.----------.---------.----------*/
    public function t_marge_sql()
    {
        echo$this->dt1;
        echo$this->dt2;
        $where_exceptions = $this->w_exceptions();
        $dv = $this->choix_bd($this->dv);
        $p_qry = "SELECT" . "           
                d.marge_euros AS marge,
                d.date AS date
                FROM reporting_data$this->dv   AS d 
                WHERE   $where_exceptions 
                        AND (d.date BETWEEN '$this->dt1' AND '$this->dt2')
                        AND  d.id_campaign = $this->id_camp
                ORDER BY d.date
                ";
        //echo $p_qry;
        return $p_qry;
    }
    // no inner join in this query

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
//$m = new Req_t_marge(99,'dv', '2015-12-25','2016-01-10');
//echo $m->t_marge_sql();
?>