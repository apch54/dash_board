<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_-->
<!-- pages modales                                                                 -->
<!-- 2015-11-28                                                                    -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_-->

<!-- Modal aide ~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~~_~~~~~~~~~~~_-->

<div class='modal fade ng-cloak' id='modal_aide' role='dialog'  ng-show="bd_levier.length >1">
    <div class='modal-dialog modal-lg'>
        <div class='modal-content'>
            <div class='modal-header' style="background: lavender; color : black;">
                <button type='button' class='close' data-dismiss='modal'>&times;</button>
                <h3 class='modal-title' style="color: blue;"> Liste des raccourcis clavier </h3>
            </div>
            <div class='modal-body' style = " font-size:  1.1em;">

                <div class="container-fluid">

                    <div class="row" id="id_hlp_cont">
                        <div class=" col-md-6 col-lg-6">
                            <ul>
                                <li><h4> h : </h4> <p> aide : affichage de cette page</p></li>
                                <li><h4> escape : </h4> <p> raz du système; opération longue : 5"</p></li>
                                <li><h4> b : </h4> <p>  affichage du bilan </p></li>
                                <li><h4> r : </h4> <p>  affichage pies jeux et régies  </p></li>
                                <li><h4> c : </h4> <p>  affichage des campagnes </p></li>
                                <li><h4> t : </h4> <p>  affichage du tableau </p></li>
                                <li><h4> x ou y: </h4>  affichage du graphe xy <p>  </p></li>
                                <li><h4> l : </h4> <p>  étude des campagnes inactives </p></li>
                                <li><h4> g : </h4> <p>  classement des jeux à faible marge  </p></li>
                                <li><h4> flèche haute ou basse : </h4> <p>  affichage ou repli du menu </p></li>
                            </ul>
                        </div>
                        <div class=" col-md-6 col-lg-6">
                            <ul>
                                <li><h4> a : </h4> <p> affichage de toutes les fenètres (all)</p></li>
                                <li><h4> n : </h4> <p> aucune fenètre affichée (none)</p></li>
                                <li><h4> j : </h4> <p> sélecteur de date : dernière maj <p>  </p></li>
                                <li><h4> s : </h4> <p> sélecteur de date : 7 derniers jours <p> </p></li>
                                <li><h4> m : </h4> <p> sélecteur de date : 30 derniers jours  </p></li>
                                <li><h4> e : </h4> <p> sélecteur de date : toute la base </p></li>
                                <li><h4> v : </h4> <p> changement de base : dv</p></li>
                                <li><h4> p : </h4> <p> changement de la base : dp  </p></li>
                                <li><h4> w : </h4> <p> changement de la base : w<p>  </p></li>
                            </ul>
                        </div>

                    </div>
                </div>

            </div>
            <div style = 'margin -10px auto; text-align: center' >Un appui long sur une touche permet la sélection unique de l'élément concerné.</div>

            <div class='modal-footer'>
                <button type='button' class='btn btn-default' style="background: lavender" data-dismiss='modal'>
                    Fermer
                </button>
            </div>
        </div>
    </div>
</div>
