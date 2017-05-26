# 2015-08-02
#   ___ ____                    __
#  / _ \___ \         ___ ___  / _|
# | | | |__) |       / __/ _ \| |_
# | |_| / __/   _   | (_| (_) |  _|
#  \___/_____| (_)   \___\___/|_|

### maj on 2017-05-26 by fc ###
app = angular.module("app_graph", []) # xy

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# diverses fonctions globales
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
top_init =new Date()
present_file = '02_graph ; '

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
app.controller "ctl_graph", ($scope, $http, $timeout) ->

#    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
# Init:  attente du top du parent
#    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    wait_for_value_ms = (val) ->
        if not val? then wait_ms 1000
        val

    wait_for_array_ms = (arr,ms=1000) ->
        if arr.length <1 then wait_ms ms;
        arr

    #    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #une attente de 1 secondes est en place au débuet du code 02_graph.php
    #wait_ms 4000
    #ps1 = wait_for_value_ms(parent.angular)
    $scope.psc = parentScope = parent.angular.element('body').scope()

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
# c'est parti...
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
    $$                  = $scope
    show                = $$.psc.show
    ajx_fl = "php/11_bd_graph.php" # ajax file to call
    $$.bd_3_max_var     = []
    chart_lgn           = false
    $$.chk_area         = on
    $$.chk_top_var      = off
    $$.top_3            = []
    active_graphs       = []
    # modifs.check_aff_xy est valable pour modifs crv et bid
    $$.modifs           = {chk_aff_xy: off, aff_xy: [], bd:[], bd_reduits: []}
    $$.bid              = {                 aff_xy: [], bd:[], bd_reduits: []}
    $$.logs             = { show: off, chk: {xy: off} }

    $$.class_cursor     = 'cursor_auto'
    cursor_waiting_for  = ''
    $$.dddp             = '2015-01-01' #date de début de période d'étude.
    coulxy              = parentScope.pie_colors # chargé par oi_mrc.coffee

    $$.bd_graph2        = false
    $$.bd_graph_map     = []
    chart_lgn.graphs    = []
    active_graphs       = []
    backup_db          = parentScope.backUp_db

    # $$.class_cursor= $$.cursor.wt('essai',15000)

    #  ¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #  donne le vecteur d'une bd éventuellement sauvegardée
    #  ¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    mBackUp = (n)-> # comme map backup
       switch n
          when 'xy_regies' then return {name: n,famille: $$.rdio_dv, dt1: $$.day_prd, dt2: 0}
          when 'xy_jeux'   then return {name: n,famille: $$.rdio_dv, dt1: $$.day_prd, dt2: 0}


    base_name = (bse) -> # only for w name base
        switch bse
            when 'v'  then return '_dv'
            when 'p'  then return '_dp'
            when 'm'  then return '_m'
            when 'w'  then return '_w'
            when 'o'  then return '_o'
            when 'at' then return '_at'

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
    #écoute les changements du scope parent
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
    parentScope.$on 'broadcast_to_xy', (event, args) ->

        try
            if args is 'start_xy'  # only init_graph at the end of function
                $$.rdio_dv = parentScope.rdio_dv
                if $$.rdio_dv in ['w','m','o','at'] then $$.titre1 = '[' + $$.rdio_dv + ']' else $$.titre1 = "[d#{$$.rdio_dv}]"
                $$.day_prd          = parentScope.day_prd #1 #temps de représentation du graph xy
                $$.show_bse_m       = parentScope.show_bse_m
                # ici il ne faut pas afficher le graph
                # car cela cause une perte de temps

            else if args is 'bd var ok'
                #pas de calcul si pas d'aff de xy

                $$.top_3 = [] # ajax impose cette raz
                $$.rdio_lgn = 'aires'
                $$.logs.show = parentScope.logs.show
                init_graph() if $$.psc.chk_aff_xy   and  $$.psc.chk_aff_bilan
                $$.psc.change_scope(true, 'graph_lgn',-75) if $$.psc.chk_aff_xy
                $$.$apply()

            # ce fragment concerne tant modifs que bid
            else if (args.nature?) and (args.nature is 'modifs to display')
                #console.log args.info
                show_modifs_bid_xy(args.info)

                init_graph() # affichage du graph dans las deux cas
                $$.$apply()

            else if (args.nature?) and (args.nature is 'get autre modifs')
                if args.base is 'mdf'
                    $$.bid.bd = get_bid()
                    parentScope.bid.bd =$$.bid.bd
                    $$.bid.bd_reduits = get_bid_reduits($$.bid.bd)
                    parentScope.bid.bd_reduits= $$.bid.bd_reduits
                    #console.log 'fst is mdf ; oth is bid '+'------------'
                else
                    $$.modifs.bd = get_modifs()
                    parentScope.mdf.bd =$$.modifs.bd
                    $$.modifs.bd_reduits = get_modifs_reduits($$.modifs.bd)
                    parentScope.mdf.bd_reduits= $$.modifs.bd_reduits

            else if args.rdio_dv in ['v','p','w','m','o','at']
                #pas de calcul si pas d'aff de xy

                a = args.rdio_dv
                $$.rdio_dv = a
                $$.titre1 = '[dp]'
                $$.modifs           = {chk_aff_xy: off, aff_xy: [], bd:[], bd_reduits: []}
                $$.bid              = {                 aff_xy: [], bd:[], bd_reduits: []}
                if      a == 'v'    then $$.titre1 = '[dv]'
                else if a == 'w'    then $$.titre1 = '[w]'
                else if a == 'o'    then $$.titre1 = '[o]'
                else if a == 'at'   then $$.titre1 = '[at]'
                else if a == 'm'
                    $$.titre1 = '[m]'
                    $$.rdio_dv = 'm'

                #show typeof args.dddp, args.dddp  + '  (02)' # généralement la date de début de période
                $$.dddp = parentScope.dddp  #fin de période de recherche

                if $$.psc.bd_regies? then show '1'  else show '2'

                $$.bd_regies = get_all_regies_or_games('Regies') # rechargement des régies
                $$.bd_jeux   = get_all_regies_or_games('Jeux') # rechargement des jeux
                $$.regies_select = 'marge'

                #vidage de la bse $$.bd modifs
                $$.bid.bd       = $$.bid.aff_xy    = $$.bid.bd_reduits     = []
                $$.modifs.bd    = $$.modifs.aff_xy = $$.modifs.bd_reduits  = []
                $$.show_bid     = $$.mdf_show   = off

                $$.chk_top_var          = $$.chk_area                     = on
                $$.chk_mrg_glob         = off
                show '3'

                init_graph()
                $$.$apply()

        catch error
           #show "(02) : parentScope.$on : #{error.message}" ,' une erreur traitée '
           console.log error.message + ' on :parentScope.$on : ' + error.name + ' ; traitée...'

    $$.but          = 'marge'
    $$.titreh3      = 'Marges globales quotidiennes'
    $$.regies_select ='marge'

    # Couleurs des variations = couleur us fed road agency
    col_var     = ['#ff0333','#009900','#808080','#6600ff','#000333','#ffff00','#0333ff','#ff5500','#99ff99','#66ffff','#ff33cc', '#cc0033' ]
    #               red       green       grey     purple    black     yellow    blue     orange    l tgreen  l blue    pink       coral

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # mise au point du curseur
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    #$$.$watch "regies_select",   (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'regie'

    $$.set_cursor = (cr, time = 4000) ->
        #show cursor_waiting_for,$$.class_cursor time is max time

        set_end_filtre = () -> $$.set_cursor 'raz_cursor'

        # mise en route du curseur
        if  cr in  ['wait','regie','dte'] and cursor_waiting_for is '' # un seul curseur à la fois
            $$.class_cursor ='cursor_wait'
            cursor_waiting_for = cr
            $timeout  set_end_filtre(), time

        # cursor stop when waiting for is arriving
        else if cr is cursor_waiting_for
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

        # stop cursor : radical
        else if cr is 'raz_cursor'
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

        else if cr is 'auto' and cursor_waiting_for is 'wait'
            #show cursor_waiting_for,$$.class_cursor
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

        else if cr is 'end_regie' and cursor_waiting_for is 'regie'
            #show cursor_waiting_for,$$.class_cursor
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # calcule  la date de début de période pour le graph xy :
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.xy_change_begining_prd = (n_days) ->
        $$.dddp = parentScope.dte_n_jours_avant(new Date(parentScope.dddr), n_days)
        parentScope.dddp =$$.dddp
        #show $$.dddp, '(02)-->'
        parentScope.get_bilan() # get bilan then get_bd_variation
        #parentScope.$apply()

        $$.regies_select = 'marge' # marge gglobale par défaut
        $$.bd_regies = get_all_regies_or_games('Regies') # rechargement des régies
        $$.bd_jeux = get_all_regies_or_games('Jeux') # rechargement des jeux

        parentScope.mdf.show= off
        $$.modifs.bd = parentScope.mdf.bd= []
        $$.psc.bazinga_scroll "id_section_xy", 100

        init_graph()

    #    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # ajax function
    #    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.maj_bd = ($$, $http, fle, v1, v2 = '2015-07-28') ->
        $http.post(fle, #fichier 04,
            but   : v1
            date_1: v2
        ).success (response, status, headers, config, v1) ->   $$.bd = response

    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # Amchart  mise a jour de la bd
    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    AmCharts.loadJSON = (url, but = 'marge', date_1 = '2016-07-28', v_ou_p = 'v') ->
        #console.log 'v_ou_p = '+v_ou_p

        #parentScope.pgs_bar.progresse 'xy', 'xy'  # on appelle la progress_bar

        # create the request
        if window.XMLHttpRequest # IE7+, Firefox, Chrome, Opera, Safari
            request = new XMLHttpRequest()

        else # code for IE6, IE5
            request = new ActiveXObject("Microsoft.XMLHTTP")

        # load it
        request.open "POST", url, false
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.send "but=" + but + '&v_ou_p=' + v_ou_p + "&date_1=" + date_1 # variables

        #$$.t=request.responseText
        t = JSON.parse request.responseText
        #show 'sortie requete'
        t # renvoie la bd

    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # go chart_lgn
    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # cadrer la courbe ds le comment 30 est le nb de jours à afficher
    zoomChart = ->
        #chart_lgn.zoomToIndexes chart_lgn.dataProvider.length - 30, chart_lgn.dataProvider.length - 1
        chart_lgn.zoomToIndexes 0, chart_lgn.dataProvider.length - 1


    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  amchart ligne build in
    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    handleRender=(e)->
#        TODO en attente d'utilisation
#        #wait_1=()->  parentScope.pgs_bar2.hide('xy'); $$.$apply() #$$.show 'in timeout';
#        #$timeout wait_1,2000
#        $$.psc.show 'fermeture #######################'
#
    handleDataUpdated=(e)->
#        $$.psc.show 'handleDataUpdated'
#        parentScope.pgs_bar2.hide('xy')#; $$.$apply()
#        $$.psc.change_scope(true, 'graph_lgn',90) #{" }focus sur le module xy

    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  amchart ligne build in
    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    def_chart = (dom) -> # définition du graph dom is id div in html : the core
        xy = AmCharts.makeChart dom, # la vigule est obligatoire
            type              : "serial"
            listeners         : [{"event": "rendered", "method": handleRender },{"event": "dataUpdated", "method": handleDataUpdated }]
            theme             : "light"
            autoMargins       : true
            autoMarginOffset  : 0
            startDuration     : 0.4
            startEffect       : "easeOutSine"
            thousandsSeparator: " "
            dataDateFormat    : "YYYY-MM-DD"
            fontSize          : 10

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
            valueAxes: [{
                id       : "Marge"
                axisAlpha: 1
                position : "left"
                title    : "Marges"
            },
            {
                "id"       : "Nb_clics"
                "gridAlpha": 0
                "axisAlpha": 1
                "position" : 'right'
                "title"    : "Nb clics / 1000"
            }]
            categoryAxes: {gridPosition: "start", title: "Periode"}
            balloon     :
                borderThickness: 1
                shadowAlpha    : 0
                cornerRadius   : 4
                fillColor      : "#333333"
                fillAlpha      : .02

            legend      :
                fontSize        : 5
                verticalGap     : 5
                horizontalGap   : 0
                useGraphSettings    : true
                #divId:"id_xy_legend"

            graphs      : [] # rempli par la fonction def_graph

            chartScrollbar:
                graph                  : "Marge"
                resizeEnabled          : true
                oppositeAxis           : false
                offset                 : 30
                scrollbarHeight        : 40
                backgroundAlpha        : 0
                selectedBackgroundAlpha: 0.1
                selectedBackgroundColor: '#0333ff'
                graphFillAlpha         : .4
                graphLineAlpha         : 0.5
                selectedGraphFillAlpha : 0
                selectedGraphLineAlpha : 1
                autoGridCount          : true
                color                  : '#000000'

            chartCursor:
                pan                      : true
                valueLineEnabled         : true
                valueLineBalloonEnabled  : true
                cursorAlpha              : 0.2
                valueLineAlpha           : 0.3
                bulletSize               : 6
                categoryBalloonDateFormat: "DD-MM"
                color                    : '#000000'
                categoryBalloonColor     : '#0333ff'
                categoryBalloonAlpha     : 0.25

            categoryField: "Date"
            categoryAxis :
                parseDates      : true
                dashLength      : 1
                minorGridEnabled: true

        xy # return graph and end of def

    #   ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  attente de l'autorisation du parent
    #    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.change_dv = ()->

        # console.log 'dv parent :'+ parentScope.rdio_dv
        parentScope.rdio_dv = $$.rdio_dv
        val_to_broadcast =
            date_0    : parentScope.date_0,
            date_2    : parentScope.date_2,
            dte_select: parentScope.dte_select,
            rdio_dv   : parentScope.rdio_dv

        $$.chk_top_var          = $$.chk_area             = on
        $$.chk_mrg_glob         = off

        parentScope.$broadcast 'broadcast_from_parent_to_pie', val_to_broadcast
        parentScope.change_2_dates()
        parentScope.get_bilan()
        #parentScope.get_bd_variation()



        $$.regies_select = 'marge' # marge gglobale par défaut
        $$.bd_regies = get_all_regies_or_games('Regies') # rechargement des régies
        $$.bd_jeux = get_all_regies_or_games('Jeux') # rechargement des jeux

        init_graph()
        parentScope.mdf.show    = parentScope.show_bid  = off
        parentScope.mdf.bd_aff  = parentScope.mdf.bd_reduits
        parentScope.mdf.show_one_cmp = false
        parentScope.bid.bd_aff  = parentScope.bid.bd_reduits
        parentScope.mdf.bd      = []
        parentScope.bid.bd      = []

        $$.modifs               = {chk_aff_xy: off, aff_xy: [], bd:[], bd_reduits: []}
        $$.bid                  = {                 aff_xy: [], bd:[], bd_reduits: []}
        $$.chk_top_var          = $$.chk_area                   = on
        $$.chk_mrg_glob         = off

        parentScope.$apply() # on force le parent à se mettre à jour

        if $$.rdio_dv == 'v'        then $$.titre1 = '[dv]'
        else if $$.rdio_dv == 'p'   then $$.titre1 = '[dp]'
        else if $$.rdio_dv == 'w'   then $$.titre1 = '[w]'
        else if $$.rdio_dv == 'm'   then $$.titre1 = '[m]'
        else if $$.rdio_dv == 'o'   then $$.titre1 = '[o]'
        else if $$.rdio_dv == 'at'  then $$.titre1 = '[m]'

        $$.top_3 = [] # ajax impose cette raz
        $$.rdio_lgn = 'aires'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # bring up regies and games for combo list
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    get_all_regies_or_games = (what = 'Regies') -> # remplissage de la combo

        u = []
        t = []
        if what is 'Regies' # all regies for combo list
            if backup_db.existe mBackUp 'xy_regies'
                u = backup_bd.get mBackUp 'xy_regies'
            else
                t = AmCharts.loadJSON ajx_fl, 'toutes_les_regies', $$.dddp, $$.rdio_dv
                u.push {value: "regie~" + x.Regies, aire: 'A~'+x.Regies, name:  x.Regies} for x in t
                backup_db.push( mBackUp('xy_regies'), u)

        else if what == 'Jeux' # all game for combo list
            if backup_db.existe mBackUp 'xy_jeux'
                u = backup_bd.get mBackUp 'xy_jeux'
            else
                t = AmCharts.loadJSON ajx_fl, 'tous_les_jeux', $$.dddp, $$.rdio_dv
                u.push {value: 'jeu' + '~' + x.Jeux, name: x.Jeux} for x in t
                backup_db.push( mBackUp('xy_jeux'), u)
        u

    #$$.bd_regies = get_all_regies_or_games('Regies') # remplissage de la combo
    #$$.bd_jeux = get_all_regies_or_games('Jeux')

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # fill and return graph
    # db isnt loaded if loaded before
    # 2 methods 1) lign  or area
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    def_graph = (g_id, bd_name, color, type ={}, id_axes = 'Marge') -> # graph def of simple or  mutiple graphs

        if type.title? then title = type.title else title = bd_name
        #title = 'na! et na ! et encore na ...'
        #show title, 'title'
        if type.dashLength? then dashLength = type.dashLength   else dashLength = 0
        if type.coul?       then color = type.coul

        g = new AmCharts.AmGraph()
        g.id = g_id
        g.bullet = "diamond"
        g.lineColor = color
        g.title = title
        g.negativeLineColor = coulxy[0]
        g.bulletBorderAlpha = 0
        g.bulletSize = 1
        g.bulletBorderColor = "#FFFFFF"
        g.bulletBorderThickness = 0
        g.hideBulletsCount = 1
        g.lineThickness = 3
        g.type = "smoothedLine"
        g.valueField = bd_name
        g.valueAxis = id_axes
        g.balloonText = "<div style='margin:2px; font-size:11px;'>[[title]] : [[value]]</div>"
        g.markerType = "diamond"
        g.dashLength=dashLength

        g # retour du graph

    # ne traite que les bubble de la courbe modifs
    def_graph_modifs = (g_id, bd_name, color, type ={}, id_axes = 'Marge') -> # graph def of simple or  mutiple graphs

        #if type.title? then title = type.title else title = bd_name
        #title = 'na! et na ! et encore na ...'
        #show title, 'title'
        #if type.dashLength? then dashLength = type.dashLength   else dashLength = 0
        if type.coul?       then color = type.coul

        g = new AmCharts.AmGraph()
        g.id                = g_id
        g.type              ='line'
        g.lineAlpha         = 0
        g.bullet            = type.forme
        g.valueField        = bd_name
        g.bulletSizeField   = type.bullet_size_field
        g.bulletBorderAlpha = 0.8
        g.bulletAlpha       = 0.2
        g.bulletColor       = type.coul_bbl
        g.descriptionField  = type.description_field

        g.valueAxis         = id_axes
        g.dashLength        = type.dashLength
        g.title             = type.title
        g.balloonText = "<div style='margin:2px; font-size:11px;'>[[description]] </div>"
        #g.balloonFunction  = (info) -> if info.values.value then return info.values.value else return ''

        g # retour du graph

    def_graph_area = (g_id, bd_name, type, id_axes = 'Marge') -> # graph def of simple or  mutiple graphs
        g = new AmCharts.AmGraph()
        g.id = g_id
        g.bullet = "round"
        g.lineColor = type.coul
        g.title = bd_name
        g.bulletBorderAlpha = 0
        #g.bulletSize = 1
        #g.bulletBorderColor = "#FFFFFF"
        g.bulletBorderThickness =1
        g.hideBulletsCount = 1
        g.lineThickness = 1
        g.type = "smoothedLine"
        g.valueField = bd_name
        g.valueAxis = id_axes
        g.showBalloon = false
        g.markerType = "circle"
        g.fillAlphas = 1
        g.fillToAxis = "x"

        g # retour du graph

    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  saisie de la bd
    #  ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    hier = (dte) -> parentScope.hier(new Date dte).toLocaleString()[0..9]

    get_bd_graph = (nm = 'marge', type={},dv_dp) -> # return the series demanded and load it if necessary

        # _for_parent_bd_variation() # la bd variation a-elle été remplie
        if not $$.bd_graph2  #initialisation
            $$.bd_graph2 = AmCharts.loadJSON(ajx_fl, nm, $$.dddp, dv_dp)
            # while $$.bd_graph2.length<1
            #    wait_ms 10

            $$.bd_graph_map.push Name: nm, Dv: dv_dp
            $$.bd_graph_map.push Name: "Nb_clics", Dv: dv_dp
            #console.log z for z in $$.bd_graph2
            return $$.bd_graph2 # seulement pour l'init

        # la base est déja chargée
        for y in $$.bd_graph_map
             if  y.Name == nm and y.Dv == dv_dp
                #$$.set_cursor('end_regie')
                return $$.bd_graph2

        #sinon on la charge
        $$.serr = []
        $$.serr = AmCharts.loadJSON(ajx_fl, nm, $$.dddp, dv_dp) # la date est un leure
        $$.bd_graph_map.push Name: nm, Dv: dv_dp
        #console.log $$.bd_graph_map

        # combler les trous
        i = 0 # copy bd in bd_graph2

        s=$$.serr
        if s.length is 0
            s = []
            s.push {Date:$$.bd_graph2.Date, Marge:0, Nb_clics:0, IdCamp:nm}

        l=$$.bd_graph2.length

        j = 0 #index de s
        for i in [0..l-1]
            bi = $$.bd_graph2[i]

            # gestion des erreurs de la base
            if s[j]?  and s[j].Marge? and s[j].Date?
                if bi.Date is  s[j].Date
                    bi[nm] = s[j].Marge
                    j++ if s[j]?

                else if bi.Date > s[j].Date
                    bi[nm]= s[j].Marge
                    j++ if s[j]?

                else if bi.Date < s[j].Date
                    bi[nm] = 0

            else bi[nm] = 0

        # appel des graphs

        switch type.type
            when 'ligne'
                l = chart_lgn.graphs.length # nb of graphs in chart
                c = coulxy[l % coulxy.length]
                chart_lgn.addGraph(def_graph(l, nm, c, type)) # add a graph in a chart

            when 'variation'
                type.coul = col_var[type.index % col_var.length]
                chart_lgn.addGraph(def_graph('', nm, '#0333ff', type)) # add a graph in a chart

            when 'modifs'
                type.coul = col_var[type.index % col_var.length]
                chart_lgn.addGraph(def_graph_modifs('', nm, '#0333ff', type)) # add a graph in a chart
                #console.log type
            when 'area'  then return chart_lgn.addGraph(def_graph_area(l, nm, type)) # add a graph in a chart

        return $$.bd_graph2

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # visualisation des aires
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.area_or_var = () ->
        #parentScope.pgs_bar.start 'area', 'area'
        init_graph()
        #parentScope.pgs_bar.progresse 50, 'area'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  on change une regie ou un jeux en mode ligne
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    validate_data = () ->
        chart_lgn.validateData()
        #chart_lgn.addListener "rendered", zoomChart
        #console.log  '05 ----- zoomchart data parti'
        zoomChart()

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # regarde un couplage éventuel mdf et bid
    $$.add_xy = (rg, type,in_xy=false)-> ## display other games
        #in_xy is used for bazinga ; bazinga if in xy
        $timeout($$.psc.show_pgs2).then ->
            $$.psc.show_menu = on;
            $$.set_cursor('wait',20000)
            if typeof rg is 'object' then rg2 = rg[0]
            else rg2 = rg

            # si actif on passe
            if  rg2  in active_graphs
                $$.psc.change_scope(true, 'graph_lgn',125)
                $$.set_cursor 'raz_cursor'
                $$.psc.hide_pgs2()
                return

            #$$.psc.show_pgs2()

            chart_lgn.dataProvider = get_bd_graph(rg, type, $$.rdio_dv) #   AmCharts.loadJSON(ajx_fl, $$.but,'2017-07-28',$$.rdio_dv)
            validate_data()

            active_graphs.push rg2 if type.type in ['ligne','variation','marge']
            if rg == 'marge' or type is 'area' then $$.titreh3 = 'Marges globales quotidiennes'
            else
                rg=type.title  if type.title?
                $$.titreh3 = " Dernières Marges affichées :  #{rg}" #.split('~')[1]}" # aff regie ou jeu

            #------------------'
            cb=->
                $$.psc.show_menu =off       # hide main menu
                $$.psc.hide_pgs2()          # hide progress bar
                $$.set_cursor 'raz_cursor'  # curseur arrow
                if in_xy then $$.psc.change_scope(true, 'graph_lgn',-180) # go to xy
                return
            $timeout cb,4000
            return

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # existe -il des éléménts croisés mdf et bid ?
    get_autre_modif_id = (id, type) ->
        if type is 'bid'
            #console.log type;console.log id; console.log $$.bid.bd_reduits[3]
            for bb in $$.bid.bd_reduits
                #console.log bb.IdCamp; console.log id
                if parseFloat(bb.IdCamp)is parseFloat(id)
                    return bb
            return false

        if type is 'mdf'
                #console.log type;console.log id; console.log $$.bid.bd_reduits[3]
            for bb in $$.modifs.bd_reduits
                #console.log bb.IdCamp; console.log id
                if parseFloat(bb.IdCamp)is parseFloat(id)
                    return bb
        return false

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # add modif est demandée par init_graph
    # regroupemenrnt éventuellement de mdf et bid
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.add_xy_modifs = (nom, type)-> ## display other games
        #def des couleurs
        cV=coulxy[7]; cB=coulxy[8] # vert et bleu
        # nom est le nom du type 'camp~82'

        #possibilité de croisement
        if type.mdf_or_bid is 'mdf' then fst='mdf'; oth='bid'
        else fst='bid'; oth='mdf'
        t2=Object.create(type) #t2 est le nouvel envuronnement de chart; hrad copy

        #-----
        #remplissage de la base avec les bulles et les nouvelles
        disp_bubbles =(bbl) ->
            br  = get_autre_modif_id(nom.split('~')[1],oth ) # vrai si une autre basemdf ou bid
            #if br then console.log br else  console.log( 'plus rien ')

            #travail sur le nouvel environnement

            if type.forme is 'circle' then t2.forme= 'square' else t2.forme = 'circle'
            if type.coul is cB then t2.coul_bbl=t2.coul= cV else t2.coul_bbl=t2.coul=cB

            #on remet les datre sous forme d'une array
            if br then br_Date =br.Date.split('\n')
            # 0 : bulle non représentée , 25 sinon
            # on place bbl ds bd graph2
            t2.type='ligne'
            t2.dashLength=0

            itemp = 0 # index de description du bbl
            for mm in $$.bd_graph2
                mm[nom+"~#{bbl}~val"] = mm[nom]
                mm["sqr~val"] = mm[nom]  if br  # on recopie la courbe
                if  mm.Date in type.date_mdf
                    mm[nom+"~#{bbl}~size"]         = 25
                    mm[nom+"~#{bbl}~description"]  =type.Modif[itemp++] # fichier de description
                else
                    mm[nom + "~#{bbl}~size"]       = 0

                #parentScope.test3=br_Date ; idem pour la nouvelle
                #console.log type.date_mdf
                if br
                    if  mm.Date in br_Date
                        mm['sqr~size']             = 25
                        mm['sqr~description']      =t2.Modif[itemp++] # fichier de description
                    else
                         mm['sqr~size']            = 0

            # création des nouvelle et ancienne bd bubbles
            type.bullet_size_field = nom + "~#{bbl}~size"
            type.description_field = nom + "~#{bbl}~description"
            if br
                t2.bullet_size_field ='sqr~size'
                t2.description_field ='sqr~description'
            chart_lgn.addGraph(def_graph_modifs(nom+"~#{bbl}",nom+"~#{bbl}~val", cB, type))
            if br then  chart_lgn.addGraph(def_graph_modifs('sqr~val','sqr~val', cV, t2))


            chart_lgn.addGraph(def_graph_modifs('sqr~val','sqr~val', '#0333ff', t2))
            #console.log t2
        #-----

        active_graphs.push nom if not (nom  in active_graphs)
        $$.set_cursor 'end_regie' # arret du curseur
        chart_lgn.dataProvider = get_bd_graph(nom, type, $$.rdio_dv) # AmCharts.loadJSON(ajx_fl, $$.but,'2017-07-28',$$.rdio_dv)

        # on traite ici la représentation des modifs
        # bd non sauvegardée
        disp_bubbles('type.mdf_or_bid')

        # on affiche les courbes
        chart_lgn.dataProvider = $$.bd_graph2
        nom = type.title  if type.title?
        $$.titreh3 = " MODIFICATION de :  #{nom}" #.split('~')[1]}" # aff regie ou jeu

        validate_data() # affichage
        # bloque le curseur déclenché par le bouton Mdf CRV
        $$.set_cursor('raz_cursor')


    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #  on change une  regie  en mode aire
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # on calcule la valeur des aires cumulées
    # les moms seront du type A~V_TJ

    $$.add_aire = ()-> # display an other regie in area mode

        #foo= wait_for_array_ms($$.bd_regies)

        #pour ttes les régies trouvées

        for i in [0..$$.bd_regies.length-1]
            #on va chercher la valeur de la marge
            # value contient le nom de la régie et aire le nom de l'aire

            #parentScope.pgs_bar.continue 20 , 'area'
            #parentScope.$apply()

            for x2 in $$.bd_graph2
                #la 1ère régie est particulière car val = val cumulée
                if i is 0 then  x2[$$.bd_regies[i].aire] = (parseFloat(x2[$$.bd_regies[i].value])).toFixed(0)
                else
                    x2[$$.bd_regies[i].aire] = (parseFloat(x2[$$.bd_regies[i].value]) + parseFloat(x2[$$.bd_regies[i-1].aire])).toFixed(0)

            #console.log $$.bd_regies[0].aire + ' ds add_aire'
        $$.titreh3 = 'Marges globales quotidiennes'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # choisx des couleurs des aires
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~


    coul = (rg, ind)-> # donne la couleur des aires
        #show rg, 'rg--------------'
        if rg.lastIndexOf('TJ') >-1 then return coulxy[20]
        #show rg.lastIndexOf 'TJ' ,' '+col_tj+ ' : TJ'
        else if rg.indexOf('FY')      >-1 then return coulxy[23]
        else if rg.indexOf('TP')      >-1 then return coulxy[22]
        else if rg.indexOf('TRIAL')   >-1 then return coulxy[22]
        else if rg.indexOf('promo')   >-1 then return coulxy[24]
        l= coulxy.length
        return coulxy[l - 1 - (ind % 8)]

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # Camp top 3 des variations de marge
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.top_var = (nb, n_drop = 10) -> # on travaille la marge
    # nb est le nb de top var à aff
    # n_drop est le nd de dcampagnes à mettre dans la drop var

        foo = wait_for_array_ms(parentScope.bd_var_abs)

        bd = parentScope.bd_var_abs
        #console.log bd[3].Regie + ' : dans top_var'

        if n_drop > bd.length then n_drop = bd.length-1
        $$.top_3 = []
        for i in [0..n_drop-1]
            if bd[i]?
                $$.top_3.push name: 'camp~'+bd[i].idCamp, value:'camp~'+bd[i].idCamp, idCamp: bd[i].idCamp, Jeu: bd[i].Jeu, Regie: bd[i].Regie, Camp: bd[i].Camp

        type ={}
        type.type ='variation'
        type.dashLength = 2

        try
            for i  in [0..nb-1]
                nme_tmp = bd[i].Regie+'['+bd[i].Camp+']'+bd[i].Jeu  if bd[i]? # nom de la base var temporaire
                #show nme_tmp
                t3 = $$.top_3[i]
                type.coul = col_var[i]
                type.index = i
                type.title = nme_tmp
                if t3? then $$.add_xy t3.name, type
        catch e
            console.log e.message + ' on : top_var :  '+ e.name + ' ; traitée...'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # Camp top 3 des variations de marge
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    $$.top_var_clic = (nb, n_drop = 10) -> # on travaille la marge
    # nb est le nb de top var à aff
    # n_drop est le nb de dcampagnes à mettre dans la drop box

        try
            bd = parentScope.bd_var_abs_clic

            if n_drop > bd.length then n_drop = bd.length-1
            $$.top_3 = []
            for i in [0..n_drop-1] then $$.top_3.push name: 'camp~'+bd[i].idCamp, value:'camp~'+bd[i].idCamp, idCamp: bd[i].idCamp, Jeu: bd[i].Jeu, Regie: bd[i].Regie, Camp: bd[i].Camp
            #show $$.top_3[1]

            type ={}
            type.type ='variation'
            type.dashLength = 2

            for i  in [0..nb-1]
                t3 = $$.top_3[i]
                type.coul = col_var[i]
                type.index = i
                $$.add_xy t3.name, type
        catch e
            #show_err e.message + ' initial2',e.name
            console.log e.message + '  initial2 : top_var_click  ' :  '+ e.name + ' ; ' ; traitée...'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # on détermine si le graph existe ou a déjà été affiché.
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    graph_exists = (name) ->
        return  name in active_graphs

    $$.xy_bg_color = (name) ->
        if graph_exists name then return '#e5e5ff'
        else return '#00333'

    $$.xy_bg_color_2 = (name) ->
        if graph_exists name
            #show 'xy_graph_exists'
            return 'xy_graph_exists'
        else
            #show 'xy_graph_not_exists'
            return 'xy_graph_not_exists'

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # aff des marges globales
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    mrg_glob_dv = (dv_dp) ->

        switch dv_dp
            when 'v'  then cl = col_var[3]
            when 'p'  then cl = col_var[10]
            when 'w'  then cl = col_var[7]
            when 'm'  then cl = col_var[1]
            when 'o'  then cl = col_var[6]
            when 'at' then cl = col_var[2]
            else cl= col_var[0]

        chart_lgn.dataProvider = get_bd_graph( 'marge',{},dv_dp)
        if $$.chk_mrg_glob
            chart_lgn.addGraph def_graph('Mrg'+base_name(dv_dp), 'Mrg'+base_name(dv_dp), cl)

        validate_data() # affichage

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    $$.change_mrg_glob = () ->

        if $$.chk_mrg_glob
            #mrg_glob_dv 'm' à mettre sur marche qd m sera remplie
            mrg_glob_dv 'w'  #if $$.rdio_dv isnt 'w'
            mrg_glob_dv 'p'  #if $$.rdio_dv isnt 'p'
            mrg_glob_dv 'v'  #if $$.rdio_dv isnt 'v'
            mrg_glob_dv 'o'  #if $$.rdio_dv isnt '0'
            mrg_glob_dv 'at' #if $$.rdio_dv isnt 'at'

            $$.set_cursor 'auto' # stop spinner
        else
            init_graph()

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #lancement initial des graphiques
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    init_graph = () ->
        #parentScope.test=$$.bd_graph2
        #$$.bd_graph2 = false
        show '4'
        $$.bd_graph_map = []
        chart_lgn.graphs = []
        active_graphs = []
        $$.dddp =parentScope.dddp

        mrg_glob_dv($$.rdio_dv)

        for i in [0..$$.bd_regies.length-1]
             get_bd_graph $$.bd_regies[i].value, {type:'aires', coul: '#ff0333',alpha:'nothing'}, $$.rdio_dv

        # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨
        #show  $$.chk_area, '14 ----- chk area'
        if $$.chk_area
            $$.add_aire()# calcul des marges cumulées
            #console.log '02 ----- fin chk area '

            for i in [$$.bd_regies.length-1..0] by -1
                bd = $$.bd_regies[i].aire
                chart_lgn.addGraph(def_graph_area(bd, bd, {type : 'aires',alpha:0, coul: coul(bd,i)}))

            if  $$.chk_top_var
                $$.top_var(3) # une seule courbe top var à afficher si area est sur on
            if  $$.chk_top_var_clic
                $$.top_var_clic(3) # une seule courbe top var à afficher si area est sur on

        if  $$.chk_top_var and not $$.chk_area # 3 courbes top var ds cette config
            $$.top_var(3)

        # affichage de la courbe de la modif clickée
        if $$.modifs.chk_aff_xy then $$.add_xy_modifs $$.modifs.aff_xy[0].name, $$.modifs.aff_xy[0]
        #$$.parentScope.test=$$.modifs.aff_xy

        if $$.chk_mrg_glob then $$.change_mrg_glob()

        # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~
          #mrg de la base en cours

        chart_lgn.addGraph(def_graph(chart_lgn.graphs.length, 'Nb_clics', '#0bde33',{}, 'Nb_clics')) if $$.chk_area
        validate_data()
        $$.set_cursor('auto')
        parentScope.test=$$.bd_graph2

    chart_lgn = def_chart "chart_lgn"

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # affichage des modifs
    # on travaille avec le scope d'angular ( : $$ ) du parent
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    get_modifs = ->
        $$.modifs.bd = []
        bdm = AmCharts.loadJSON ajx_fl, 'modifs',$$.dddp, $$.rdio_dv

        # handle campagnes voir commentaires en 01.mrc.coffee
        for y in bdm
            if y.Camp? and y.Camp.lastIndexOf('(') > 0
                y.Camp = y.Camp.slice(y.Camp.lastIndexOf("(") + 1, y.Camp.lastIndexOf(")"))
            else y.Camp = z for z in ['premium', 'www', 'excluding','KITTY - FYBER'] when y.Camp? and y.Camp.lastIndexOf(z) > 0

        for t in bdm
            t.Camp = 'www' for z in ['WW, excluding live countries', 'Global', 'KITTY - FYBER'] when t.Camp is z
            t.IdCamp =parseFloat(t.IdCamp)

            t.Moy_mrg_clc_avt = t.avg_mrg_avant/t.avg_clc_avant
            t.Moy_mrg_clc_aps = t.avg_mrg_apres/t.avg_clc_apres

            t.Date = t.Date[0..9]
            # calcul du bilan mrg ; sera mis en pourcentage ds le html
            if t.avg_mrg_avant < 0 then v_abs = -t.avg_mrg_avant else v_abs = t.avg_mrg_avant
            t.bilan_mrg = (t.avg_mrg_apres - t.avg_mrg_avant) / v_abs

            # calcul du bilan mrg/clc ; sera mis en pourcentage ds le html
            if t.Moy_mrg_clc_avt < 0 then v_abs = -t.Moy_mrg_clc_avt else v_abs = t.Moy_mrg_clc_avt
            t.bilan_mrg_clc = (t.Moy_mrg_clc_aps - t.Moy_mrg_clc_avt) / v_abs

            # NAN, null et autres perturbent le tri il est préférable de le définir comme Infinity
            if isNaN(t.bilan_mrg ) or (parseFloat(t.avg_mrg_avant) is 0) or (!t.bilan_mrg)  or (!t.bilan_mrg_clc)
                t.bilan_mrg = -1e9 # -infini

            t.ng_model = off # calculate ng model of checkbox, off : not checked
            t.shw_id='no'
            $$.set_cursor('raz_cursor')

        bdm # return bdm

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # calcule la bd réduite des modifs
    # une seule ligne par campagne modifiée
    # on utilise du deep Copy à cause le la persistance JS
    get_modifs_reduits  = (bd) ->

        $$.modifs.bd_reduits = bdr =[]  # bdm est la base réduite
        for t in bd # bd est la base complète
            if bdr.length is 0
                bdr.push {foo:0}
                angular.copy(t, bdr[0])
            else
                l = bdr.length
                i=0
                trouve= off
                while i < l
                    #show bdr[i].IdCamp is t.IdCamp
                    if bdr[i].IdCamp is t.IdCamp

                        bdr[i].aff = bdr[i].Modif = bdr[i].Modif + "\n ----- * ----- \n"+ t.Modif
                        bdr[i].Date = bdr[i].Date + "\n"+ t.Date

                        trouve = on
                        break
                    i++
                if not trouve
                    bdr.push {foo:0}
                    angular.copy(t, bdr[l])
        bdr

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # affichage sous forme de tableau
    # appel du parent
    $$.aff_modifs = ->
        parentScope.mdf.show= !parentScope.mdf.show
        #autorise l'affichage complet de la table mais seulent
        #  sur appui du bouton voir
        if not (parentScope.mdf.show or parentScope.bid.show) then parentScope.mdf.show_one_cmp = false

        if parentScope.mdf.show
            if !$$.modifs.bd?
                $$.modifs.bd =  get_modifs()
                $$.modifs.bd_reduits =  get_modifs_reduits $$.modifs.bd

            else if $$.modifs.bd.length is 0
                $$.modifs.bd =  get_modifs()
                $$.modifs.bd_reduits =  get_modifs_reduits $$.modifs.bd

            # le nob de 1100 est curieux mais bazinga_scroll, ne
            #tient pas compte du franchissement de l'iFrame "id_chart qui
            # a une hauteur de 635px
            $$.psc.show_menu =off
            $$.psc.bazinga_scroll "id_section_xy", $$.psc.bzg.mdf_xy

        # hide modifs automaticly due check_aff_xy = off
        else
            $$.modifs.chk_aff_xy = off
            #En sortant on efface les pts btns voir encore apparents
            md.shw_id = 'no' for md in $$.modifs.bd         when md.shw_id isnt 'no'
            md.shw_id = 'no' for md in $$.modifs.bd_reduits when md.shw_id isnt 'no'

            # on place le tableau en configuration standard
            if  (not parentScope.mdf.show and not parentScope.bid.show)
               # show 'tableau à corriger mdf'
                parentScope.rdio_action = "70"

        if !$$.bid.bd?
            $$.bid.bd =  get_bid()
            $$.bid.bd_reduits =  get_bid_reduits $$.bid.bd
        parentScope.bid.bd = $$.bid.bd
        parentScope.bid.bd_reduits = $$.bid.bd_reduits

        parentScope.mdf.bd = $$.modifs.bd
        parentScope.mdf.bd_reduits = $$.modifs.bd_reduits
        parentScope.chk_mdf_click(on) #apply

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    #affichage sous forme de courbe  XY ; modis ou bid
    # il peut s'agir d'une modif ou d'une modif bid
    show_modifs_bid_xy = (mdf) ->
        nme = 'camp~' + mdf.IdCamp

        if   mdf.mdf_or_bid is 'mdf'then    c2 = coulxy[13] ; c1 = coulxy[7] ; frm = 'circle' # vert
        else                                c2 = coulxy[14] ; c1 = coulxy[8] ; frm = 'square' # bleu

        description  =
            mdf_or_bid          : mdf.mdf_or_bid
            name                : nme
            type                :'ligne'
            dashLength          : 0
            coul                : c1
            coul_bbl            : c1
            forme               : frm
            index               : 3
            title               : "#{mdf.IdCamp} - #{mdf.Regie}[#{mdf.Camp}]#{mdf.Jeu}"
            date_mdf            : mdf.Date.split '\n'
            Modif               : mdf.Modif.split '\n ----- * ----- \n'

        $$.modifs.chk_aff_xy    = on
        $$.chk_top_var          = off
        $$.chk_area             = off
        $$.chk_mrg_glob         = off

        $$.titreh3 = "Modification en date du #{mdf.Date[0..9]} pour #{description.title}"
        $$.$apply() # = init graph

        $$.modifs.aff_xy[0] = description

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # affichage des  des BID ( modifs)
    # attention : on travaille avec le scope d'angular ( : $$ ) du parent
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    get_bid = ->
        $$.bid.bd = []
        bdm = AmCharts.loadJSON ajx_fl, 'modifs_bid',$$.dddp, $$.rdio_dv

        for y in bdm
              if y.Camp? and y.Camp.lastIndexOf('(') > 0
                  y.Camp = y.Camp.slice(y.Camp.lastIndexOf("(") + 1, y.Camp.lastIndexOf(")"))
              else y.Camp = z for z in ['premium', 'www', 'excluding','KITTY - FYBER'] when y.Camp? and y.Camp.lastIndexOf(z) > 0

        for t in bdm
            t.Camp = 'www' for z in ['WW, excluding live countries', 'Global', 'KITTY - FYBER'] when t.Camp is z
            t.IdCamp =parseFloat(t.IdCamp)

            t.Moy_mrg_clc_avt = t.avg_mrg_avant/t.avg_clc_avant
            t.Moy_mrg_clc_aps = t.avg_mrg_apres/t.avg_clc_apres

            t.Date = t.Date[0..9]

            # calcul du bilan mrg ; sera mis en pourcentage ds le html
            if t.avg_mrg_avant < 0 then v_abs = -t.avg_mrg_avant else v_abs = t.avg_mrg_avant
            t.bilan_mrg = (t.avg_mrg_apres - t.avg_mrg_avant) / v_abs
            #show t.bilan_mrg, 'bbbb'

            # calcul du bilan mrg/clc ; sera mis en pourcentage ds le html
            if t.Moy_mrg_clc_avt < 0 then v_abs = -t.Moy_mrg_clc_avt else v_abs = t.Moy_mrg_clc_avt
            t.bilan_mrg_clc = (t.Moy_mrg_clc_aps - t.Moy_mrg_clc_avt) / v_abs

            # Calcul du bilan BID
            t.bilan_bid = (t.New_bid - t.Old_bid) /  t.Old_bid

            # NAN, null et autres perturbent le tri il est préférable de le définir comme -Infinity
            if isNaN(t.bilan_mrg ) or (parseFloat(t.avg_mrg_avant) is 0) or (!t.bilan_mrg)  or (!t.bilan_mrg_clc)
                t.bilan_mrg = -1e9 #-Infinity

            # mise en forme des informatons : comment + bid sur la bdd
            tmp =''
            if t.Old_bid isnt ""  then tmp =  "Old BID:" + t.Old_bid
            if t.New_bid isnt "" then  tmp += " - new BID:" + t.New_bid
            if t.Modif   isnt ""
                if tmp isnt '' then tmp += '\n'
                tmp += " Commentaire : " + t.Modif
            t.Modif = tmp
        bdm

    get_bid_reduits  = (bd) ->
        $$.bid.bd_reduits = bdr =[]  # bdm est la base réduite
        for t in bd # bd est la base complète
            if bdr.length is 0
                bdr.push {foo:0}
                angular.copy(t, bdr[0])
            else
                l = bdr.length
                i=0
                trouve= off
                while i < l
                #show bdr[i].IdCamp is t.IdCamp
                    if bdr[i].IdCamp is t.IdCamp

                        bdr[i].Modif = (bdr[i].Modif + "\n ----- * ----- \n"+ t.Modif).trim()
                        bdr[i].Date = (bdr[i].Date + "\n"+ t.Date).trim()

                        trouve = on
                        break
                    i++
                if not trouve
                    bdr.push {foo:0}
                    angular.copy(t, bdr[l])
        bdr

    # il ne s'agit ici que du tableau bid
    $$.aff_bid = ->
        parentScope.bid.show = !parentScope.bid.show
        #autorise l'affichage complet de la table
        if not (parentScope.mdf.show or parentScope.bid.show) then parentScope.mdf.show_one_cmp = false

        if $$.psc.bid.show
            if !$$.bid.bd?
                $$.bid.bd =  get_bid()
                $$.bid.bd_reduits =  get_bid_reduits $$.bid.bd
            else if $$.bid.bd.length is 0
                $$.bid.bd =  get_bid()
                $$.bid.bd_reduits =  get_bid_reduits $$.bid.bd

            # le nob de 1000 est curieux mais bazinga_scroll, ne
            #tient pas compte du franchissement de l'iFrame "id_chart qui
            # a une hauteur de 635px
            $$.psc.show_menu =off
            $$.psc.bazinga_scroll "id_section_xy", $$.psc.bzg.bid_xy

        else # hide modifs bid
                $$.bid.chk_aff_xy = off
                $$.modifs.chk_aff_xy = off
                #En sortant on efface les pts btns voir encore apparents
                md.shw_id = 'no' for md in $$.bid.bd         when md.shw_id isnt 'no'
                md.shw_id = 'no' for md in $$.bid.bd_reduits when md.shw_id isnt 'no'
                # on place le tableau en configuration standard
                if  (not parentScope.mdf.show and not parentScope.bid.show)
                    #show 'tableau à corriger bid'
                    parentScope.rdio_action = "70"

        if !$$.modifs.bd?
            $$.modifs.bd =  get_modifs()
            $$.modifs.bd_reduits =  get_modifs_reduits $$.modifs.bd
        parentScope.mdf.bd = $$.modifs.bd
        parentScope.mdf.bd_reduits = $$.modifs.bd_reduits

        parentScope.bid.bd = $$.bid.bd
        parentScope.bid.bd_reduits = $$.bid.bd_reduits
        parentScope.chk_bid_click(on) #apply

    #   ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # changement d'aff logs oui/non
    $$.clc_change_lgs = (shw_lgs) ->
        $$.logs.chk.xy = shw_lgs
        parentScope.logs.chk.xy = shw_lgs
        parentScope.bd_graph2 = $$.bd_graph2
        #show shw_lgs
        parentScope.$apply()

##    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
return # lancement du contrôleur
##    ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

