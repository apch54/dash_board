### maj 2017-05-26 by fc ###
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
window.angular.module('app_mrc')
.controller "ctl_graph_pie", ($scope, $http, $rootScope,$timeout) -> # child of mrc scope
#     ___ _____                  __
#    / _ \___ /        ___ ___  / _|
#   | | | ||_ \       / __/ _ \| |_
#   | |_| |__) |  _  | (_| (_) |  _|
#    \___/____/  (_)  \___\___/|_|
#
#show tools.apch()
    $$ = $scope # for that's a short name
    ajx_fl = "php/11_bd_graph.php" # ajax file to call

    $$.bd_graph_jeux = []
    $$.bd_graph_regies = []
    #$$.bd_graph_geo = []
    $$.bd_graph_campaign_saved = $$.bd_graph_campagnes = []
    $$.bd_camp_neg = []
    $$.bd_camp_small = []
    $$.niveau_petites_camp = 5 # en pourcentage
    chart_pie_jeux = chart_pie_regies = chart_pie_campagnes = false

    $$.rdio_dv = 'v'
    $$.titre1 = '[dv]'
    $$.but = 'jeux_regies_et_camp'
    $$.show_bse_m= false
    $$.TimeOffset = new Date().getTimezoneOffset() * 60 * 1000

    pie_colors = $$.pie_colors # definition dans le parent

    #console.log $$.pie_colors
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Les dates                                                                *
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.date_0 = $$.date_2 = window.top.date_0
    dte_last_report = () -> new Date(new Date($$.dddr).getTime() + 1 * $$.TimeOffset)

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Amchart  mise a jour de la bd                                            *
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    AmCharts.loadJSON = (url, but = 'jeux', v_ou_p = 'v', date1, date2) ->

        # create the request 'old ajax'
        if window.XMLHttpRequest # IE7+, Firefox, Chrome, Opera, Safari
            request = new XMLHttpRequest()

        else # code for IE6, IE5
            request = new ActiveXObject("Microsoft.XMLHTTP")

        # load it
        request.open "POST", url, false
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.send "but=" + but + '&v_ou_p=' + v_ou_p + "&date_1=" + date1 + "&date_2=" + date2 # variables
        # console.log "but="+but+'&v_ou_p='+v_ou_p+"&date1="+date1+"&date2="+date2  # variables

        #$scope.t=request.responseText
        regies_jeux_et_camp_bd = JSON.parse request.responseText

        try
            #smart_name_game(regies_jeux_et_camp_bd) # shorten name game
            smart_name_campaigns(regies_jeux_et_camp_bd)
            sort_by_marge regies_jeux_et_camp_bd # sort asc
            fill_bds regies_jeux_et_camp_bd

            $$.bd_graph_jeux = handle_bd_graph $$.bd_graph_jeux, 'jeux'
            $$.bd_graph_regies = handle_bd_graph $$.bd_graph_regies, 'regies'
            $$.bd_graph_campagnes = handle_bd_camp $$.bd_graph_campagnes, 'camp', $$.niveau_petites_camp
            #$$.bd_graph_geo = handle_bd_geo copy_by_val regies_jeux_et_camp_bd
            #$$.ttt = $$.bd_graph_campagnes
        catch error
            console.log error + '. in ctl pies : db empty --> (fc)'

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #  tri de la base asc et place les marges < 0 en  valeur abs et en premier pour les allumer en rouge
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    copy_by_val = (bd) -> # copie par valeur afin de préserver la bd initiale
        t = []
        t.push {Date: y.Date, Name: y.Name, Category: y.Category, Marge: y.Marge} for y in bd
        t

    tri = (a, b) -> parseFloat(a.Marge) - parseFloat(b.Marge)
   # sort_by_marge = (b)-> b.sort(tri)
    sort_by_marge = (array) ->
        array.sort = (a,b) ->
            if a.Marge < b.Marge
                -1
            else if a.Marge > b.Marge
                1
            else
                0

    # on remplit les 4 bd # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    fill_bds = (bd) -> # fill all the 4 bds
        $$.bd_graph_campagnes = []
        $$.bd_graph_regies = []
        $$.bd_graph_jeux = []
        $$.bd_graph_campaign_saved = []

        for y in bd
            cat = y.Category
            switch cat # copies par valeur
                when "jeux" then $$.bd_graph_jeux.push {
                    Date    : y.Date,
                    Name    : y.Name,
                    Category: y.Category,
                    Marge   : y.Marge
                }
                when "regies" then $$.bd_graph_regies.push {
                    Date    : y.Date,
                    Name    : y.Name,
                    Category: y.Category,
                    Marge   : y.Marge
                }
                when "camp"
                    $$.bd_graph_campagnes.push {
                        Date    : y.Date,
                        Name    : y.Name,
                        Category: y.Category,
                        Marge   : y.Marge,
                        Cout    : y.Cout
                    }
                    # une sauvegarde pour les petites marges
                    $$.bd_graph_campaign_saved.push {
                        Date    : y.Date,
                        Name    : y.Name,
                        Category: y.Category,
                        Marge   : y.Marge,
                        Cout    : y.Cout
                    }

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # 1/ rename campaigns ; 2/ handle bd campaigns
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    smart_name_campaigns = (bdc) -> # rename campaigns with short_names

        for y in bdc when y.Category == 'camp'
            narr = y.Name.split('~')
            if narr[1]? then rg = narr[1] else rg = 'regie name error'
            if narr[2]? then cp = narr[2] else cp = 'campaign name error'

            if narr[3]?
                jx = narr[3] # concerne les jeux afin de leur donner des noms simples
                #if (pos = jx.lastIndexOf '-') > 0 then jx = jx.slice 0, pos else jx = jx.slice 0, 7
                #jx = " [#{jx}]"
            else jx = 'game name error'

            cp = 'www' for z in ['WW, excluding live countries', 'Global', 'www'] when cp.lastIndexOf(z) > 0
            if cp.lastIndexOf('(') >= 0 then cp = cp.slice(cp.lastIndexOf("(") + 1, cp.lastIndexOf(")"))

            else if cp.lastIndexOf('premium') >= 0 then cp = 'Premium'
            else if cp.lastIndexOf('KITTY - ') >= 0 then cp = 'www'
            cp = " [#{cp}] "


            #aff_s 4, rg + ' ~/~ ' + cp + ' ~/~ '+ jx
            y.Name = rg + cp + jx

    # @formatter:off
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # handle < 0 and small marges

    handle_bd_camp = (bd = $$.bd_graph_campagnes, fld = 'camp', small_level = 2) ->
        val_neg = 0
        name_neg = 'Marge < 0 '
        val_small = 0
        $$.small_name = "0<= Marge < #{small_level}% " # titre de la liste des petites campagnes
        tot = 0
        $$.bd_camp_neg = []
        $$.bd_camp_small = []
        arr = [] # on groupe les  negatifs et les petits

        for x in bd
            x.Marge = parseFloat(x.Marge)
            x.Cout = parseFloat(x.Cout)
            if x.Marge < 0
                val_neg += x.Marge
                $$.bd_camp_neg.push {
                    Name    : x.Name,
                    Marge   : x.Marge,
                    pourCent: x.Marge / tot * 100,
                    Renta   : x.Marge / x.Cout * 1.2
                }
            tot += x.Marge # Marge total
            min = small_level * tot / 100 # valeur maxi pour retenir une petite marge ( 2% au demarrage)

        for x in bd
            if 0 < x.Marge < min
                val_small += x.Marge
                $$.bd_camp_small.push {
                    Name    : x.Name,
                    Marge   : x.Marge,
                    pourCent: x.Marge / tot * 100,
                    Renta   : -x.Marge / x.Cout * 1.2
                }

        val_neg *= (-1) if val_neg != 0
        arr.push {
            'Date'    : '2015-07-28'
            'Category': fld
            'Name'    : name_neg
            'Marge'   : val_neg.toFixed 2
        } # <0 first to be red

        arr.push {
            'Date'    : '2015-07-28'
            'Category': fld
            'Name'    : $$.small_name
            'Marge'   : val_small.toFixed 2
        } # small in second

        arr.push x for x in bd when x.Marge > min #other camp > min
        arr
    # @formatter:on
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Handle bd regies and jeux après chargement
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    handle_bd_graph = (bd, fld = 'jeux') -> # regie ou jeux
        val_neg = 0;
        val_Name = 'Negatif ';
        arr = [] # on groupe les  negatifs et les petits

        for x in bd
            x.Marge = parseFloat(x.Marge)
            #console.log x
            if parseFloat(x.Marge) < 0 #and x.Category == fld
                val_neg += x.Marge
                val_Name += ", #{x.Name}"
        #console.log val_neg+ '-- ** --'+val_Name

        val_neg *= (-1) if val_neg != 0 # pie ne prend que des valeurs >0
        val_neg = val_neg.toFixed 2
        arr.push {'Date': '2015-07-28', 'Category': fld, 'Name': val_Name, 'Marge': val_neg} # <0 first to be red

        arr.push x for x in bd when x.Marge > 0 # and x.Category == fld
        arr # that's the return arr

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # appel de la base                                     *
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.maj_bd_3 = () -> chart_pie_jeux.dataProvider = AmCharts.loadJSON ajx_fl, $$.but, $$.rdio_dv, date_to_string($$.date_0), date_to_string($$.date_2)

    #$$.maj_bd_3() # go

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # go chart_pie_jeux                                    *
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #event  fired 3 times (one for each) when the first  pie rensered  is done
    handleRender=(e)->
        wait_1=()->  $$.pgs_bar2.hide('pie'); $$.$apply() #$$.show 'in timeout';
        $timeout(wait_1,2000)

    def_pie = (bd, max_label_width = 200) ->
        return {
        type              : "pie"
        listeners         : [{"event": "rendered", "method": handleRender }]
        angle             : 20,
        depth3D           : 12
        innerRadius       : "20%"
        radius            : 135 #, "pieX" : "20%"  ,"pieY":190
        balloonText       : "[[title]]<br> <span style='font-size:12px'><b>[[value]]</b> ([[percents]]%)</span>"
        titleField        : "Name",
        valueField        : "Marge"
        outlineAlpha      : 1
        outlineColor      : "#ffffff"
        outlineThickness  : 1
        allLabels         : []
        labelsEnabled     : true,
        maxLabelWidth     : max_label_width,
        labelText         : "[[title]]"
        labelRadius       : 35
        fontFamily        : "tahoma"
        fontSize          : 9
        thousandsSeparator: " "
        sequencedAnimation: false
        startDuration     : 0,
        #legend:            {"align": "left", "markerSize": 12, "markerType": "square",  "bottom": 5,"valueWidth" :45 }
        colors            : pie_colors # définies plus haut
        marginBottom      : 0,
        marginTop         : 0

        balloon     : {"adjustBorderColor": true},
        titles      : []
        dataProvider: bd

        export:
            enabled : true
            fileName: "Dash-Board"
            position: "top-right"
            legend  : {position: "bottom"}
            libs    :
                path: "amc/plugins/export/libs/"
            menu    : [
                class: "export-main"
                menu : [
                    {label: "Télécharger une image", menu: ["PNG", "JPG", "PDF"]}
                    {label: "Télécharger les données", menu: ["CSV", "XLSX", "JSON"]}
                    {label: "Imprimer", format: "PRINT"}
                ]
            ]
        }

    chart_pie_jeux = AmCharts.makeChart 'chart_pie_jeux', def_pie $$.bd_graph_jeux
    chart_pie_regies = AmCharts.makeChart 'chart_pie_regies', def_pie $$.bd_graph_regies
    chart_pie_campagnes = AmCharts.makeChart 'chart_pie_campagnes', def_pie $$.bd_graph_campagnes, 500

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #  events ou actions ou 'listen events'
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    emit_higher = () -> #synchro des scopes pie -->> mrc
        val_to_emit = {
            date_0    : $$.date_0
            date_2    : $$.date_2
            dte_select: $$.dte_select
            rdio_dv   : $$.rdio_dv
        }
        $$.$emit 'emit_from_pie_to_parent', val_to_emit


    $$.$on 'broadcast_from_parent_to_pie', (event, args) -> # envoi d'info : les changements du scope parent
        $$.date_0 = args.date_0
        $$.date_2 = args.date_2
        $$.dddr = args.dddr # date du dernoer rapport
        $$.dte_select = args.dte_select
        $$.rdio_dv = args.rdio_dv
        $$.show_bse_m   = args.show_bse_m

        #$$.titre1 = '[dp]';
        if      args.rdio_dv == 'v'     then $$.titre1 = '[dv]'
        else if args.rdio_dv == 'w'     then $$.titre1 = '[w]'
        else if args.rdio_dv == 'o'     then $$.titre1 = '[o]'
        else if args.rdio_dv == 'at'    then $$.titre1 = '[at]'
        else if args.rdio_dv == 'm'
            $$.titre1 = '[m]'
            $$.rdio_dv = 'm'
        else if args.rdio_dv == 'p'     then $$.titre1 = '[dp]'

        redraw_graphs()

    gestion_err_camp = ->

    redraw_graphs = () ->
        try
            $$.maj_bd_3()
            chart_pie_jeux.dataProvider = $$.bd_graph_jeux
            chart_pie_jeux.validateData()
            chart_pie_regies.dataProvider = $$.bd_graph_regies
            chart_pie_regies.validateData()
            chart_pie_campagnes.dataProvider = $$.bd_graph_campagnes
            chart_pie_campagnes.validateData()
        catch e

            $$.niveau_petites_camp =5
            $$.change_PC($$.niveau_petites_camp)
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Tous les changements entrainant des actions
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_PC = (small_level = 2) -> # évolution du taux des petites marges
        try
            $$.bd_graph_campagnes = []
            $$.bd_graph_campagnes = handle_bd_camp($$.bd_graph_campaign_saved, 'camp', small_level)
            #$$.ttt = $$.bd_graph_campaign_saved

            # maj du graphe campagne
            chart_pie_campagnes.dataProvider = $$.bd_graph_campagnes
            chart_pie_campagnes.validateData()
            #redraw_graphs()
        catch e
            console.log "dans change_pc  (03.coffee) : #{e.message}"


    $$.change_2_dates =->
        $$.dte_select = ''
        emit_higher()
        redraw_graphs()
        $$.change_scope($$.chk_aff_graph_jeux_regies, 'id_aff_graph_jeux_regies',180) # positionnement

    $$.change_D0 = () -> # pas utilisé
        $$.dte_select = ''
        emit_higher()
        redraw_graphs()

    $$.change_D2 = () -> # not used
        $$.dte_select = ''
        emit_higher()
        redraw_graphs()

    $$.change_dv = ()->
        if      $$.rdio_dv == 'v'  then  $$.titre1 = '[dv]'
        else if $$.rdio_dv == 'p'  then  $$.titre1 = '[dp]'
        else if $$.rdio_dv == 'w'  then  $$.titre1 = '[w]'
        else if $$.rdio_dv == 'm'  then  $$.titre1 = '[m]'
        else if $$.rdio_dv == 'o'  then  $$.titre1 = '[o]'
        else if $$.rdio_dv == 'at' then  $$.titre1 = '[at]'
        #console.log '03. coffee change d0'

        emit_higher()
        redraw_graphs()

    # changement de date au sélecteur  ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_dte_select = (dt) ->
        switch dt
            when "j"
                today = new Date $$.dddr
                $$.date_0 = $$.date_2 = today

            when "j-1"
                hier = new Date new Date($$.dddr).getTime() - 24 * 3600000
                $$.date_0 = $$.date_2 = hier

            when "j7"
                j7 = new Date new Date($$.dddr).getTime() - 6 * 24 * 3600000
                $$.date_0 = new Date $$.dddr
                $$.date_2 = j7

            when "j30"
                j30 = new Date new Date($$.dddr).getTime() - 29 * 24 * 3600000
                $$.date_0 = new Date $$.dddr
                $$.date_2 = j30

            when "mois"
                $$.date_0 = d = new Date $$.dddr
                $$.date_2 = new Date(d.getFullYear(), d.getMonth(), 1, 0, 0, 1, 1)


            when "mois-1"
                d = new Date $$.dddr
                $$.date_0 = new Date(d.getFullYear(), d.getMonth(), 0, 1, 0, 1, 1)
                $$.date_2 = new Date(d.getFullYear(), d.getMonth() - 1, 1, 1, 0, 1, 1)
                #$$.date_2 = new Date(d1.getFullYear(), d1.getMonth(),1,1, 1,0,0)

            when "tout"
                $$.date_0 = new Date $$.dddr
                d = new Date(new Date('2010-01-01').getTime())
                $$.date_2 = d

        emit_higher()
        redraw_graphs()

    #$rootScope.date_0 = window.top.scopeToShare.date_0

    # affichage du petit menu pie ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.disp_pie_menu = () -> $$.chk_aff_graph_campagnes or $$.chk_aff_graph_jeux_regies

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    return # lancement du controleur

# fin du ctl pie graph
