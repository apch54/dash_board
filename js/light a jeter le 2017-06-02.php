<?php include_once './php/00_debut.php'; ?>

<!--
~~~~~~~~~~~_~~~~~_~~~~~~~~~~~
index dash-board
2015-07-31
 _      ____   ____  __ __  ______
| T    l    j /    T|  T  T|      T
| |     |  T Y   __j|  l  ||      |
| l___  |  | |  T  ||  _  |l_j  l_j
|     T |  | |  l_ ||  |  |  |  |
l_____j|____jl___,_jl__j__j  l__j

-->
<!-- un div blanc pour masquer le well fixed -->
<div id="id_menu_div_blanc"> &nbsp;

    <!--  loader  -->
    <div ng-show="pgs_bar.aff"
         style=" height: 1200px; "
         class="ng-cloak"
    >
        <br>
    </div>
</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!--  menu, affichage des filtres                                      -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<br>
<div class="well top_fixed light"
     ng-cloak
>
    <?php include "light/00L_menu.html"; ?>
</div>
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~ -->
<!-- afin de dérouler  une partie blanche sous le menu variable        -->

<div ng-class="height_blank_menu">&nbsp;</div>

<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->
<!--affichage de la table                                                -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~   -->

<section id="id_tableau"
         ng-show=" chk_aff_tableau"
         ng_cloak
>
    <?php include_once "light/05L_table.html" ?>
</section>
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->
<!-- test                                                -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~  -->

<!--TEST : 0 ; bd_graph2 <br> {{test}} <br><br>
TEST2: 02 ; bd_graph2{{test2}}br><br><br>
TEST2: 02 ; bdi{{test3}}
-->
<!-- début aff log -->



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
    include_once 'light/00L_fin.php';
?>
