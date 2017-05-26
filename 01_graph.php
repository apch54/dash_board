<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/>
    <title>E Graph XY</title> 
    <link rel="stylesheet" href="./bs/bootstrap-3.3.6-dist/css/bootstrap.css">
    <link rel="stylesheet" href="./css/fc.css">
    <link type="text/css" href="./css/amc_export.css" rel="stylesheet">

</head>
<body id="body"
      ng-app="app_graph"
      ng-controller="ctl_graph"
      class='mp0'
      ng-class="class_cursor"
      ng-cloak=""
>
<!-- attente de 2 sec afin que la première partie de l'appli se charge-->
<?php $foo=sleep(2)  ?>

<div id="id_xy_principal" class="container-fluid mp0">
    <!-- titre XY ~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~ -->
    <div class="container">
        <div class="row">
            <div class="col-sm-10">
                <h2 class="milieu">Marges des régies, campagnes et jeux en fonction du temps
                    {{titre1}}
                </h2>
            </div>
            <div class="col-sm-2">
                &nbsp;
            </div>
        </div>
    </div>

    <!-- graphique de gauche ~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~ -->
    <div class="container">
        <div class="row">

            <div class="col-sm-10">
                <h3 class="centrer">{{titreh3}}</h3>

                <div id="chart_lgn"></div>
            </div>
            <br>

            <!-- ¨¨¨¨¨¨¨¨¨¨¨¨ outils de droite ~¨¨¨¨¨¨¨¨¨¨¨¨~ -->

            <div id="id_xy_tools" class="col-sm-2">

                <!-- dv ou dp ~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~ -->

                <div class="inline_block logs_title" ng-show="logs.show">
                    Lgs:
                    <input id="chk_aff_logs_bilan"
                           type="checkbox"
                           ng-model="logs.chk.xy"
                           ng-click="clc_change_lgs(logs.chk.xy) ">
                </div>

                <form name="radio_dv_ou_dp" ng-click="change_dv()">
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="v">dv
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="p">dp
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="w">w<br />
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="m"> m
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="o" > o
                    <input type="radio" ng-model="rdio_dv" ng-focus="set_cursor('wait')" value="at" >at
                </form>

                <!-- select regie or jeux ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~ -->

                <form>
                    <label id="id_xy_lbl1" for="month_prd">
                        <button ng-click="set_cursor('dte'); xy_change_begining_prd(day_prd)"
                        > jours:
                        </button>

                    </label>
                    <input id="day_prd" class="dte"
                           ng-model="day_prd"
                           type="number"
                           min="2"
                           max="1000"
                    >
                    <a ng-href="#" ng-click="set_cursor('wait',5000);">
                        <select
                            id="id_fortes_var_select"
                            name="regieSelect"
                            size='20'
                            multiple
                            ng-model="regies_select"
                        >
                            <optGroup label="Mrg globales">
                                <option value='Marge'
                                        class="{{xy_bg_color_2(y.value)}}"
                                        ng-click="add_xy('marge',{type: 'ligne', dashLength: 0},true);"

                                > Mrg globales
                                </option>
                            </optGroup>

                            <optGroup label="Mrg par régie">
                                <option ng-repeat="y in bd_regies"
                                        value="{{y.value}}"
                                        class="{{xy_bg_color_2(y.value)}}"
                                        ng-click="add_xy(regies_select,{type: 'ligne'},true)"
                                >
                                    {{y.name}}
                                </option>
                            </optGroup>

                            <optGroup label="Mrg par jeux">
                                <option ng-repeat="y in bd_jeux"
                                        value="{{y.value}}"
                                        class="{{xy_bg_color_2(y.value)}}"
                                        ng-click="add_xy(regies_select,{type: 'ligne', dashLength: 0},true)"
                                        class="mp0"
                                >
                                    {{y.name}}
                                </option>
                            </optGroup>
                            <optGroup label="Cmp forte var marge">
                                <option id="id_fortes_var_option"
                                        ng-repeat="z in top_3"
                                        value="{{z.value}}"
                                        class="{{xy_bg_color_2(z.value)}}"
                                        ng-click="add_xy(regies_select,{type: 'variation', dashLength: 2, index: $index, title : z.Regie+'['+z.Camp+']'+z.Jeu },true);"
                                >
                                    {{z.Regie}}[{{z.Camp}}]{{z.Jeu}}
                                </option>
                            </optGroup>

                        </select>
                    </a>

                    <br>
                    <section id="id_graph_col2">
                        <input type="checkbox" ng-model="chk_area" ng-click="area_or_var()"
                               ng-mousedown="set_cursor('wait')">aires
                        <br>
                        <input type="checkbox" ng-model="chk_mrg_glob" ng-click="change_mrg_glob()"
                               ng-mousedown="set_cursor('wait')">marges globales <br>
                        <input type="checkbox" ng-model="chk_top_var" ng-click="area_or_var()"
                               ng-mousedown="set_cursor('wait')">Cmp à fortes var<br>

                        <button ng-click="aff_modifs()">
                            <!-- affichage des tableaux -->
                            Mdf CVR
                        </button>
                        <button ng-click="aff_bid()">
                            Mdf Bid
                        </button>
                    </section>
                </form>

                <!-- Fin des forms XY  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~ -->

            </div>
        </div>
    </div>
</div>

<script src="amc/amcharts.js" type="text/javascript"></script>
<script src="amc/serial.js" type="text/javascript"></script>
<script src="./amc/plugins/export/export.min.js" type="text/javascript"></script>
<script src="amc/themes/light.js" type="text/javascript"></script>
<script src="./ang/ang-1.5.7/angular.min.js" type="text/javascript"></script>

<script src="js/02_ctl_graph.js?v=2016-05-11"></script>
<script src="js/10_def_xy.js?2016-04-23"></script>
</body>
</html>
