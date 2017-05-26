<?php include_once './php/00_debut.php'; ?>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->
<!-- index dash-board                                                 -->
<!-- 2015-07-31                                                       -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->
<!-- corps de page                                                    -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->

<!-- un div blanc pour masquer le well fixed -->
<div id="id_menu_div_blanc"> &nbsp;

    <!--  loader  -->
    <div ng-show="pgs_bar2.show"
         style=" height: 1200px; tableau"
         class="ng-cloak"
    >
        <br>
    </div>
</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!--  menu, affichage des filtres                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->

<!-- un div blanc fixe pour compenser la hauteur du menu fixe-->
<div id= 'id_top' class="height_3" >&nbsp; </div>


<div class="well top_fixed" ng-cloak >
    <?php include "00_menu.html"; ?>
</div>
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!-- afin de dérouler  une partie blanche sous le menu variable        -->

<div class="height_blank_menu_1" ng-show="show_menu">&nbsp;</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--affichage du bilan                                                  -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--class="fade_1"-->
<section id="id_bilan"
         ng-include src="'04_bilan.html'"
         ng-show="chk_aff_bilan && board.bilan "
         ng_cloak
>
</section> <!-- fin bilan -->
<!--
    <h2>map: {{backUp_db.map.length}}</h2>
    {{backUp_db.map}}<br>

    <h2>main-bd : {{backUp_db.main_base.length}}</h2>

    {{main_db.main_base}}
-->

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--affichage gu gain_0 2015-12-17                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->

<section id="id_gain_0"
         ng_cloak
>
    <?php include_once "06_gain_0.html" ?>
</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->
<!--affichage de la table                                                -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->


<section id="id_tableau"
         ng_cloak
>
    <?php include_once "05_table.html" ?>
</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- Grapgh pies et xy et la  table des modifications                                                 -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<section id="id_section_xy"  ng_cloak>
    <iframe id="graph_lgn"
            ng_cloak
            ng-show="chk_aff_graph_lgn"
            src="01_graph.php"
            wframeborder="0" scrolling="no"
    >
        <p>Votre navigateur ne prend pas en charge les "iframes")</p>
    </iframe>
</section>

<!-- début aff log -->
<div ng-show="logs.chk.xy">
    <div class="logs_title_base"> Base : bd_graph2 </div><!-- Nom de la base comme titre-->
    <div ng-repeat="x9 in bd_graph2"
         class="align_left" ;
    >
        <p ng-class-odd="'odd'" ng-class-even="'even'">
            {{x9}}
        </p>
    </div>
    <br>
</div>
<!-- fin aff  log -->

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--    Modifications  jeux et bid                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~~ -->

<section> <?php
        include_once './08_modifs.html';
        include_once './09_bid.html';
    ?>
 </section>
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- graph-pie                                                          -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~~ -->

<section>
    <?php
         include_once './02_graph_pie.html'
    ?>
</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- levier                                                             -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~~ -->

<section id="id_levier"
         ng-cloak
         ng-include="'03_levier.html'">

</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- contexte final                                                     -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<span></span>
<div id="id_fin">
    <br><br><br><br><br><br>
    <br><br><br><br><br><br>
    <br><br><br><br><br><br>
</div>

<?php
    include_once './07_hidden_table.html';
    include_once './php/00_fin.php';
?>
