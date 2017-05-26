<?php

/**
 * Created by PhpStorm.
 * User: apch
 * Date: 17/08/2016
 * Time: 15:43
 * ----------.----------.---------.----------
 * usage
1/ $m_v= new Sql_to_json($con,$m_dv_sql,'pas de but');
2/$m_vv= $m_v->getJson() // retun the string Json Variable
 *
 */

class Sql_query
{
    private $link = '';
    private $sql = '';
    private $but = '';

    function __construct($lk, $sl, $bt = 'no_goal')
    {
        $this->link= $lk;
        $this->sql = $sl;
        $this->but = $bt;
    }
    /*
    ----------.----------.---------.----------
    retourne la requête demandée ds un json
    ----------.----------.---------.----------
    */
    public function getJson()
    {
        $req = $this->link->query($this->sql);
        if (!$req) {
            die(erreur("Query failed : (" . $this->link->errno . ") ","in class Sql-query"));
        }
        $json = ''; // sql -> arr
        While ($row = $req->fetch_assoc()) {
            $json[] = $row;
        }
        if (!isset($json[0])) { // base vide
            die (erreur("ERROR in URL parameters : data empty : class 'Requete'"));
        }
        if ($this->but != 'no_goal') $json['but']= $this->but;

        return json_encode($json );
    }
    /*
    ----------.----------.---------.----------
    retourne la requête demandée ds un json
    ----------.----------.---------.----------
     */
    public function getArray()
    {
        $req = $this->link->query($this->sql);
        if (!$req) {
            die(erreur("Query failed : (" . $this->link->errno . ") ,\"in class Sql-query\""));
        }
        $json = ''; // sql -> arr
        While ($row = $req->fetch_assoc()) {
            $json[] = $row;
        }
        if (!isset($json[0])) { // base vide
            die (erreur("ERROR in URL parameters : data empty : class 'Requete'"));
        }
        if ($this->but != 'no_goal') $json['but']= $this->but;

        return $json;
    }
}
/*
----------.----------.---------.----------
test
----------.----------.---------.----------
 */