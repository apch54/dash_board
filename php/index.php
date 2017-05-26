<?php include_once './php/00_debut.php'; ?>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->
<!-- index dash-board                                                 -->
<!-- 2015-07-31                                                       -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->
<!-- corps de page                                                    -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~-->

<!-- un div blanc pour masquer le well fixed -->
<div style="background-color: #ffffff; position : fixed ; top : 0 ;z-index : 100; width : 100% ;"> &nbsp;

    <!--  loader  -->
    <div ng-show="pgs_bar.aff"
         style=" margin-top: -20px; height: 1200px; text-align: center;"
         class="ng-cloak"
    >
        <br>
    </div>
</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!--  menu, affichage des filtres                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->

<div class="well top_fixed"
     ng-cloak
>
    <?php include "00_menu.html"; ?>
</div>
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!-- afin de dérouler  une partie blanche sous le menu variable        -->
<!--<div style="height : 20em">&nbsp;</div>-->
<div ng-style="{'height': height_blank_menu }">&nbsp;</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--affichage du bilan                                                  -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->

<section id="id_bilan"
         ng-include src="'04_bilan.html'"
         style="margin: 10px;text-align : center; text-height: auto"
         ng-show="chk_aff_bilan"
         ng_cloak
>
</section> <!-- fin bilan -->

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!--affichage gu gain_0 2015-12-17                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->

<section id="id_gain_0"
         ng-show=" chk_aff_gain_0"
         ng_cloak
         style=" margin-top: -1em;"
>
    <?php include_once "06_gain_0.html" ?>
</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->
<!--affichage de la table                                                -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->

<section id="id_tableau"
         ng-show=" chk_aff_tableau"
         ng_cloak
         style=" margin-top: -1em;"
>
    <?php include_once "05_table.html" ?>
</section>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- Grapgh pies et xy et la  table des modifications                                                 -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->

<iframe id="graph_lgn"
        ng_cloak
        ng-show="chk_aff_graph_lgn"
        src="01_graph.php"
        wframeborder="0" scrolling="no"
>
    <p>Votre navigateur ne prend pas en charge les "iframes" ... ))</p>
</iframe> 

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- Modifications  jeux et bid                                         -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~~ -->

<section>
    <?php
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
         ng-show="chk_aff_levier"
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
