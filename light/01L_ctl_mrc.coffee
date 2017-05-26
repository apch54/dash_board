# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# |    written on                                                          |
# |    2015-08-01                                                          |
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
#
#
#      ___                __      __
#     /\_ \    __        /\ \    /\ \__
#    \//\ \  /\_\     __\ \ \___\ \ ,_\
#     \ \ \ \/\ \  /'_ `\ \  _ `\ \ \/
#      \_\ \_\ \ \/\ \L\ \ \ \ \ \ \ \_
#     /\____\\ \_\ \____ \ \_\ \_\ \__\
#     \/____/ \/_/\/___L\ \/_/\/_/\/__/
#                    /\____/
#                    \_/__/

#
app = angular.module "app_mrc", ['ngAnimate','ui.bootstrap','ngMdIcons','ngTouch','ngClipboard','duScroll' ]
###
fc 2015-08-01
###
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Controlleur     ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Controleur principal : père
app.controller "ctl_mrc", ($scope, $document, $location, $anchorScroll, $http, $uibModal, $window, $log, $timeout,ngClipboard,$sce) ->
    app.value('duScrollDuration',2000)
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Initialisation  @formatter:off
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$                   = $scope # domaine d'AngularJS
    present_file         = '01'
    $$.animationsEnabled = true
    ajx_fl               = "php/04_bd_mrc.php" # ajax file to call
    $$.date_to_string    = date_to_string      # po1inteur de fonction
    $$.tri_levier        = {col: 'Marge', desc: true}
    $$.tri_levier_regie  = {col: 'Marge', desc: true}
    $$.tri_modifs        = {col: 'bilan_mrg', desc: true}
    $$.tri_bid           = {col: 'bilan_mrg', desc: true}
    $$.pourcentage       = pourcentage # pointeur de  la fonction pourcentatage du domaine window
    $$.sign              = sign  # defined in window fonction générale personnelle
    $$.chk_aff_graph_lgn = off
    $$.chk_aff_var_rel   = off
    $$.chk_aff_tableau   = on
    $$.chk_aff_gain_0    = off
    $$.chk_aff_levier    = off
    $$.chk_aff_graph_jeux_regies = on
    $$.chk_aff_graph_campagnes   = on
    $$.chk_aff_bilan     = on
    $$.gbd_filtree       = [] # stockage de la base du tableau en filtrage
    $$.bd_glob           = ['t0'] # on est au demarrage
    bd_glob_dddr         = []
    bd_tous_les_bilans   = [{v_ou_p: '0', bd: [],dddp :'1954-07-28' }] # rien au bilan
    $$.gbd_bilan         = [] # variables de stockage des bd
    $$.bd_levier         = []
    $$.bd_regie_jeu      = []
    $$.bd_variation      = []
    $$.bd_var_abs        = []
    $$.bd_var_rel        = []
    $$.nb_var            = 4
    $$.bd_gain_0         = [] #  anomalies de la base et en particulier les gains nuls
    $$.limit_var         = 7  # 8 ( et bien 8 de 0 à 7) lignes  à afficher pour les variations du bilan
    $$.var_nbj           = 7  # variation : nb de jours initial pour le calcul de la moyenne de la marge
    $$.title_variation   = '7 derniers j' # titre initial du tableau variation
    $$.fRenta            =  Infinity # pour le calcul d'une bd : marge >1000 et renta <2
    $$.rdio_dv           = 'v'
    $$.show_bse_m        = false # on ne montre pas à priori la base m
    $$.stg_erreur        = '' # non encore usité
    $$.TimeOffset        = new Date().getTimezoneOffset() * 60 * 1000
    $$.dte_select        = "j"
    $$.TJ_exists         = false # tj #regie not exists by default
    $$.dddr              = '1954-07-28' # date de la dernière maj ou extraction
    $$.day_prd           = 15 # nb de mois initialisant la periode d'affichage des XY
    $$.dddp              = '1954-07-28' # date de début de période; calculée pourl'affichage des courbes XY; par défaut 2 mois avant aujourdhui
    ancienBut            = 'date _0' # mémorisation de la dernière action
    $_debut              = true # début dechargement de la bd ou changement de bd
    $$.bd_empty          = true # état des variables au lancement de l'applicatif
    $$.show_menu         = on # par défaut on montre le menu
    vu_marge_10          = true # vrai si le tableau Marge<-10 a été vu
    $$.marge_inf_10      = off
    $$.height_blank_menu = '11em' # taille de la font du menu
    $$.class_cursor      = 'cursor_auto' # affichage du curseur pointeur au début de l'application
    cursor_waiting_for   = '' # rien en attente  pour le retour au curseur pointeur
    ngClipboard          = ngClipboard.ngClipboard
    $$.show_hidden_table = false
    $$.graph_lgn_height  = '700px'
    $$.mdf               = {bd: [],bd_aff: [],bd_reduits: [], flt_IdCamp:'',flt:{IdCamp: ''}, show: off,show_one_cmp: false }
    $$.bid               = {bd: [],bd_aff: [],bd_reduits: [], flt_IdCamp:'',flt:{IdCamp: ''}, show: off}
    $$.logs              = {show: off,chk:{bilan:off, var_abs: off, var_rel: off,table: off, table_flt: off, pie: off,xy: off, levier: off,gain0: off, cvr: off,crv_cmp:off,cvr_red: off, bid: off, bid_cmp: off, bid_red: off}}
    $$.board             ={xy: off,bilan: off}
    $$.test              = ''
    ess                  = {username:'fc'}

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # modules de base : Injections # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    MA                    = window.angular.module('app_mrc')
    $$.M_help             = MA.help

    shws                  = MA.shws
    $$.show = show      = (x...) ->shws(x... ,present_file)
    show_err              = MA.show_err
    $$.wait_ms = wait_ms  #= M_tools.wait_ms

    $$.pgs_bar2            = MA.pgs_bar2

    $$.pie_colors         = MA.pie_colors
    $$.coul               = MA.coul
    $$.coul_2             = MA.coul_2 # 09 js

    #  ¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # init progress bar
    #  ¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # pgs bar2 INITED for a stopping with pie at 40''
    $$.pgs_bar2.start()
    $$.pgs_bar2.reset(5000,'light')

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # boot S popover
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $('[data-toggle="popover"]').popover()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Lecture de l'URL et définition de la base
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # La base figure-elle dans l'Url ?
    url_param = get_url_param('parametre') # get param named parametre from url

    if  url_param in ['dv','v','dp','p', 'w', 'm','o','at']
        switch url_param
            when 'dv','v'   then t = 'v'
            when 'dp','p'   then t = 'p'
            when 'w'        then t = 'w'
            when 'm'        then t = 'm'
            when 'o'        then t = 'o'
            when 'at'       then t = 'at'

        $$.rdio_dv = t
    else if not url_param?  then $$.rdio_dv = 'v'
    else
        $$.open_modal {title:  "La base  - #{url_param} -  est inexistante.", body: 'La base par défaut est dv', job: 'Dv'}
        $$.rdio_dv = 'v'

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Précise-on la période de représentation du grapch xy ds l'addresse?
    # le nombre de jours est un entier
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    url_time = get_url_param('time') # get parm named parametre from url

    if  url_time?
        u =  Math.round  parseInt(url_time)
        msg="Pour tracer une courbe je préfère disposer d'au moins deux points; merci."

        if u > 1 then $$.day_prd = $$.dddp = u
        else $$.open_modal {title:  "Delai graphique xy", body: msg, job: "15j"}

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Lecture de l'url pour l'affichage les logs
    # ou lecture des bases 'brutes'
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    url_logs = get_url_param('logs')
    if  url_logs?
        #show  url_logs, 'exists'
        if url_logs is 'on' then $$.logs.show = on
    #show 'logs is', $$.logs.show

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Si le bilan n'existe paa le graphique xy non plus
    # Lecture de l'url  pour l'affichage du bilan et des variations
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    ### LIGHT TODO effacer le 23-07
    get_url_bilan = ->
        url_bln = get_url_param 'bilan'
        if (url_bln?) and (url_bln is 'on') then  return on
        else return off

    # mémorisation de la donnée URL
    $$.chk_aff_bilan = $$.board.bilan = get_url_bilan()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Affichage du bilan
    # yon : yes or no : $$.ckk_aff_bilan
    $$.aff_bilan = (yon) ->
        ds_l_ordre = ->
            show 'ici'
            yield $$.get_bilan()
            show 1
            yield $$.board.bilan = on
            show 2
            yield 'terminé'
        if yon
            #foo = ds_l_ordre()
            #aa= foo.next()
            #ab= foo.next()
            #abc=foo.next(); show abc
            $$.get_bilan()
            $$.bazinga_scroll("id_bilan", 105)
        else
            $$.board.bilan  = off
            $$.board.xy = $$.chk_aff_xy  = off

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # lecture du param xy de l'URL
    # pour activer la l'aff de xy elle doit être sur on
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    get_url_xy = ->
        if not $$.board.bilan then return off
        url_xy= get_url_param('xy')
        if  (url_xy?) and (url_xy is 'on')
            $$.chk_aff_graph_lgn = on
            url_xy= on
            $$.board.xy = on
            return on
        else
            $$.chk_aff_graph_lgn = off
            $$.board.xy = off
            return off

    #on prend la valeur xy de l'URL
    $$.chk_aff_xy =  $$.board.xy = get_url_xy()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.aff_graph_lgn = (yon)-># yon : aff xy or not

    # dans ce cas  on mémorise la volontée de montrer le xy
        if yon and $$.board.bilan
            $$.board.xy = on
            #console.log $$.board.xy,'chk'
            #$$.change_dv()
            $$.$broadcast 'broadcast_to_xy', 'bd var ok'

            val_to_broadcast =
                date_0    : $$.date_0
                date_2    : $$.date_2
                dddr      : $$.dddr #date du dernier rapport
                dte_select: $$.dte_select
                rdio_dv   : $$.rdio_dv
                show_bse_m: $$.show_bse_m
                dddp      : $$.dddp # valeur du début de période

            $$.$broadcast 'broadcast_to_xy', val_to_broadcast
            $$.menu_on_off('no-visible')

        # on mémorise le souhaît de montrer xy ds ts les cas
        #else if (yon is yes) and ($$.board.xy is no) then $$.board.xy = yes
        # ici on revient au cas de départ xy =off
        else
            $$.chk_aff_xy = $$.board.xy = off
            $$.$apply()
    ###
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨  ¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # titres principaux
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.titre_menu_base = () ->
        if $$.rdio_dv in ['v','p'] then  return "d#{$$.rdio_dv}"
        else if $$.rdio_dv in ['w','m','o','at']  then return $$.rdio_dv


    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # set iframe xy height depends of bd.modifs.lenght
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.set_ifm_height =(h, h_modif='') ->
        #show $('#graph_lgn').css('height')
        $('#graph_lgn').css({height:h+h_modif})
    $$.set_ifm_height $$.graph_lgn_height    # init

    ### LIGHT TODO effacer le 25-07

    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~
    # affichage des modifs (conçu pour une hauteur de graph de 670)
    # ~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨~¨¨¨¨¨¨¨¨¨¨¨¨¨¨~

    # réagit au bouton pour l'affichage du tableau des modifs
    $$.aff_modifs = () ->
        $$.mdf.flt.IdCamp = ''
        $$.mdf.show= !$$.mdf.show

    $$.aff_bid = () ->
        $$.mdf.flt.IdCamp = ''
        $$.bid.show=  not $$.bid.show

    ###

    is_cmp_in_bd_glob = (id) ->
        id.toString
        for b in $$.bd_glob
            if id.toString() is b.idCamp then return true; break
        false

    $$.is_cmp_in_bd_modifs_bid = (id, bd) ->
        id.toString
        for b in bd
            #show id.toString(),'id'; show b.IdCamp.toString(),'IdCamp'
            if id.toString() is b.IdCamp.toString() then return true; break
        false


    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #  rempli la table cachée
    $$.fill_hidden_table = (x) -> $$.h = x
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # permet de connaître la largeur de l'écran
    # déclenché par body.click
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.w_win = () -> # return window width
        ww = window;  dd = document

        if ww.innerWidth  then w = ww.innerWidth # ts navigateurs sauf Explorer

        # Internet Explorer mode Strict
        else if dd.documentElement && dd.documentElement.clientWidth  w = dd.documentElement.clientWidth

        # Autres Internet Explorer
        else if dd.body && dd.body.clientWidth
            w = dd.body.clientWidth
        #
        #show "Cette fenêtre fait #{w}px de large.  "
        w # return width

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # redirection de la fonction resize de JS et pour l'initialisation

    $$.cal_width = () ->
        w = $$.w_win()
        # on fixe la taille de la table
        $$.tbl_w2 = ((w-20)/200*97).toFixed(0)+'px'
        $$.tbl_w = ((w-20)/100*98).toFixed(0)+'px'
        $$.$apply() # ne pas oublier de rafraichir le scope

    window.onresize = $$.cal_width
    $$.tbl_w = (($$.w_win()-20)/100*97).toFixed(0)+'px' # seulement pour la première passe

    # @formatter:on

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Modal error permet si necessaire d'envoyer des messages d'erreurs modaux
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.open_modal = (dialog, size = 'sm') -> # uiModal est définie ds le ctlr modal
        modalInstance = $uibModal.open
            animation  : $scope.animationsEnabled
            templateUrl: './php/05_modal_err.php' # le fichier est chargé dynamiquement
            size       : size
            controller : 'ModalInstanceCtrl'
            resolve    : {to_modal: () -> dialog}

        modalInstance.result.then (from_modal='') ->
            $$.pgs_bar.raz() #show form_modal

            $$.set_cursor 'raz_cursor'
            # on arrete la progress_bar si erreur

    ### LIGHT
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # lancement de xy
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.$broadcast 'broadcast_to_xy', 'start_xy'
    ###

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # ajax function : scrute la bd  @formatter:off
    #cb = callback
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.maj_bd = ($$, $http, fle, v1, v2, v3, v4, $_then='') ->

        if bilan_exists(v4, v1, v3) and $$.board.bilan # v4:dvdp , v1'bilan
            #show 'le bilan existe         01 ------------------------ ' ,$$.dddp+ '   '+ v3
            $$.get_bd_variation($$.var_nbj) # on envoie la requete variation php
            return # la base bilan existe ; inutile de rechercher le bilan

        response = ['', '', {Date: ''}]
        $http.post(fle, #fichier 04,
            but   : v1
            date_1: v2
            date_2: v3
            v_ou_p: v4

#        switch v1 #pour la barre de progression light TODO effacer le 26-07
#              when 'dddr'    then $$.pgs_bar.start  v1, 'variation'
#              when 'date'    then $$.pgs_bar.start  v1, 'gain_0'
#              when'periode'  then $$.pgs_bar.start  v1, 'periode'
#              else  $$.pgs_bar.continue 7, v1 # on attend simplement le retour du but précédent

        # retour de la requête ajax  asynchone si succès
        ).success (response, status, headers, config, v1) ->    # retour de la réponse

            but_r = response.records[2].Date # le but donné en retour : ce qui a été fait
            #how but_r, '04-02 retour but_r'

            if but_r == 'dddr'               # date du dernier rapport = dddr
                $$.dddr = response.records[0].date              # on obtient la date du dernier bilan
                init_date($$.dddr)                              #mise en place de la base à l'aide de dddr

            else if but_r  not in ['bilan','variation'] # bt_r : but retourné de la recherche sur base

                if but_r is 'gain_0'
                    $$.bd_gain_0 = response.records
                    handle_bd_gain_0()
                    $$.$broadcast('broadcast_to_xy', 'start_xy') if not $$.board.bilan


                else # on traite ici bd_glob
                    $$.bd_glob = response.records #$$.test = $$.bd_glob[1]
                    if $$.bd_glob.length < 2                       # mauvais critères de date
                        # la base est donc vide à cause des dates, on lance une raz
                        raz_bd_empty('Les critères de dates sont incorrects')   # envoi de la page modale d'erreur
                        $$.change_2_dates()                         # maj de la bd
                    else
                        # --> ca marche' la base est bien remplie
                        $$.clic_tri_col 'Marge'
                        $$.tri = {col: 'Marge', desc: true}
                        show '2 -'

                        #show response.records[3].Date, 'initial1'
                        if but_r is 'initial_dp'  then  bd_glob_dddr.push {dv_dp: 'p',  bd :$$.bd_glob}
                        if but_r is 'initial_w'   then  bd_glob_dddr.push {dv_dp: 'w', bd :$$.bd_glob}
                        if but_r is 'initial_m'   then  bd_glob_dddr.push {dv_dp: 'm',  bd :$$.bd_glob}
                        if but_r is 'Initial'     then  bd_glob_dddr.push {dv_dp: 'v',  bd :$$.bd_glob}
                        if but_r is 'initial_o'   then  bd_glob_dddr.push {dv_dp: 'o',  bd :$$.bd_glob}
                        if but_r is 'initial_at'  then  bd_glob_dddr.push {dv_dp: 'at', bd :$$.bd_glob}

                        # il faut absolument recharger la bonne bd_glob car w arrive en dernier
                        try
                            if $$.rdio_dv in ['v','p'] then $$.cmpr = 'd'+$$.rdio_dv else $$.cmpr = $$.rdio_dv

                            if but_r in ['initial_dp', 'initial_w', 'initial_m', 'Initial']
                                #show but_r, '""'
                                $$.bd_glob = get_bd_global_dvdp($$.rdio_dv)
                                #$$.marge_inf_10 = marge_inf_10_exists()

                        catch e
                            show_err "(01) :  maj_bd #{e.message}" ,' une erreur traitée '
                        finally

                            $_then_x=() ->$$.pgs_bar2.hide 'light' ;  show 'maj_bd' # call back : shut progress_bar
                            $timeout $_then_x,2000
                            show '4 -'

                        get_bd_jeux_regies_campagnes()
                        #get_bd_levier()

                        #sto_bd_glob_dddr() # on sauve la bd_globale  à  la dddr sur les 3 régies

            else      # les bilans et variations sont traités ici ¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
                #show response.records[2].Date
                if but_r is 'bilan'

                    $$.gbd_bilan = response.records # global db recuperee
                    x.Marge = parseFloat(x.Marge)for x in $$.gbd_bilan
                    # on stocke les bilans et variations afin d'éviter de les rechercher à nouveau
                    bd_tous_les_bilans.push {v_ou_p: $$.rdio_dv, bd: $$.gbd_bilan, dddp : $$.dddp}

                    $_then()
                    # on envoie la requete variation php

                    $$.get_bd_variation($$.var_nbj)

                else if but_r is 'variation'    # variations des variations

                    $$.bd_variation = response.records
                    handle_bd_variation()
                    #$$.$broadcast 'broadcast_to_xy', 'start_xy'
                    #show but_r

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # on retrouve simplement la base globale à la dddr
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    get_bd_global_dvdp = (bse) -> # bse is stg dv or dp or w or m
        #show bse,'bse'
        return t.bd  for t in bd_glob_dddr when t.dv_dp is bse

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # travail sur la base bd_gain_0
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *


    $$.bd_gain_0_length = () -> # calcule le nb de lignes renvoyées ds bd_gain_0
        i = 0
        for b in $$.bd_gain_0
            if b.idCamp?  then i++
            else break


    handle_bd_gain_0 = () -> # travail de mise en forme qd la base est vide

        if $$.bd_gain_0_length() is 0
            #show "passera par là"
            $$.bd_gain_0[0].TjClic = $$.bd_gain_0[0].Marge = $$.bd_gain_0[0].idCamp = '-'
            $$.bd_gain_0[0].TjCout = $$.bd_gain_0[0].Gain  =  $$.bd_gain_0[0].Jeu   = $$.bd_gain_0[0].Regie  ='-'
            $$.bd_gain_0[0].Camp   = ' Aucune ligne à gain nul '

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # ATTENTION au délai de l'asynchrone ajax
    # Handle bd_variations
    # 1) traitement du nom des campagnes
    # 2) we synchronize with db_global
    # 3) tri par variation des marges absolues puis relatives
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #
    handle_bd_variation = () ->

        n_var = 9 # on trie exactement 10 camp pour les variations

        try
            # traitement du nom des campagnes comme ds le pie camp
            for y in $$.bd_variation
                if  y.Camp? and y.Camp.lastIndexOf('(') > 0
                    y.Camp = y.Camp.slice(y.Camp.lastIndexOf("(") + 1, y.Camp.lastIndexOf(")"))
                else y.Camp = z for z in ['premium', 'www', 'excluding','KITTY - FYBER'] when y.Camp? and y.Camp.lastIndexOf(z) > 0

            for t in $$.bd_variation
                t.Camp = 'www' for z in ['WW, excluding live countries', 'Global', 'KITTY - FYBER'] when t.Camp == z

            #  we synchronize with db_global_dddr
            #  wait(100) while not bd_glob_dddr_exists()
            for x in $$.bd_variation # transform to Number
                xid = x.idCamp
                x.Marge = parseFloat(x.Marge)
                x.TjClic = parseFloat(x.TjClic)

                $$.bd_glob_dvdp = get_bd_global_dvdp($$.rdio_dv)  # on recharge la base mais seulement le pointeur

                for y in $$.bd_glob_dvdp
                    if y.idCamp? and y.idCamp  is xid
                        x.Dddr_marge = parseFloat(y.Marge )                       # marge du dernier rapport
                        x.Dddr_TjClic = parseFloat(y.TjClic)
                        x.Var_marge = x.Dddr_marge - x.Marge                      # variation abs de la marge
                        x.Var_clic = x.Dddr_TjClic - x.TjClic

                        # variation relative
                        xx = (x.Dddr_marge / x.Marge - 1) * 100 # Variation relative de la marge
                        if x.Dddr_marge >= x.Marge then xx = sign(xx) * xx # attention aux signes
                        else xx = sign(xx) * (-1) * xx # on prend la val absolue math
                        x.Var_marge_relative = xx

                        xx2 = (x.Dddr_TjClic / x.TjClic - 1) * 100 # Variation relative du nb de clics
                        if x.Dddr_TjClic >= x.TjClic then xx = sign(xx2) * xx2 # attention aux signes
                        else xx2 = sign(xx2) * (-1) * xx2 # on prend la val absolue math
                        x.Var_clic_relative = xx2

                        break
                if !x.Dddr_marge?  then x.Dddr_marge = 'undef' # error idx not finded
                if !x.Dddr_TjClic? then x.Dddr_marge = 'undef' # error idx not finded

            # tri par variation des marges absolues
            $$.bd_var_abs = [] # base des variations absolues
            $$.bd_variation.sort marge_var_abs # trié par variation absolue : en euro
            $$.bd_var_abs.push $$.bd_variation[i] for i in[0..9] # n_var = nb de campagne recueillies

            $$.bd_var_abs_clic = [] # base des variations absolues pour les clic ( on recommence)
            $$.bd_variation.sort clic_var_abs # trié par variation absolue : en clic
            $$.bd_var_abs_clic.push $$.bd_variation[i] for i in[0..9] # n_var = nb de campagne recueillies

            # tri par variation des marges relatives
            $$.bd_var_rel = []
            $$.bd_variation.sort marge_var_rel
            $$.bd_var_rel.push $$.bd_variation[i] for i in[0..9]

            # tri par variation des marges relatives
            $$.bd_var_rel_clic = []
            $$.bd_variation.sort clic_var_rel
            $$.bd_var_rel_clic.push $$.bd_variation[i] for i in[0..9]

            # On informe le fils que la bd var abs est constituée
            cb1 = () -> $$.$broadcast 'broadcast_to_xy', 'bd var ok'
            setTimeout cb1,100

        catch error
            show ' :  (01)  : handle_bd_variation ', 'fc, Erreur traitée : '+ error.message
        finally
            #show 'fin curseur'
            $$.set_cursor('auto') # auto juste pour le début

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # le bilan existe-il déjà ? Pour accélérer la recherche on ne le rechargera pas
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    bilan_exists = (vpw, but, dddp) ->              # v or p or w et met à jour la bd
        return false if but != 'bilan'        # on ne traite que les bilans ici
        for d in bd_tous_les_bilans
            if (d.v_ou_p is vpw)  and (d.dddp is $$.dddp)               # bilan(vpw) exists
                $$.gbd_bilan = d.bd
                return true
        false                                 # le bilan n'a pas encore été chargé il faut le faire

    # @formatter:on

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # appel de la base et retour en bd sur 1 seule date
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.maj_bd_2 = (dte) ->
        $$.dates = date_to_string(dte)
        #$$.bd_glob = ''
        $$.maj_bd $$, $http, ajx_fl, "date", date_to_string(dte), date_to_string(dte), $$.rdio_dv
        $$.maj_bd $$, $http, ajx_fl, "gain_0", date_to_string(dte), date_to_string(dte), $$.rdio_dv

        #get_bd_levier()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # change gbd sur action du titre : sur 2 dates
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_2_dates = () ->
        $$.dates = " du  #{date_to_string($$.date_0)}  au  #{date_to_string($$.date_2)}"
        #$$.bd_glob = ''
        ancienBut = 'date_0_et_2'

        #$_debut = true # évite un affichage de l'alerte lors du chargement

        $$.maj_bd $$, $http, ajx_fl, 'periode', date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv
        $$.maj_bd $$, $http, ajx_fl, 'gain_0' , date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv
        #get_bd_levier()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # aller à la page sur une id ; module bazinga
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.bazinga_scroll = (id,off_set=0) -> # smooth scroll
        toggle  = document.querySelector('#toggle')
        options = { speed: 1954-954, easing: 'easeInCubic',offset:off_set }
        smoothScroll.animateScroll( '#'+id,toggle, options )
        #$$.menu_on_off('no_visible')

    #$$.dpl_doux= (id) ->('html, body').animate( { scrollTop: $('#'+id).offset().top }, 750 )

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # calcule  la date de début de période pour le graph xy
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.dte_n_jours_avant = (dte, n=15) -> # calcul de la date n mois avant
        d2 = new Date(dte.getFullYear(), dte.getMonth(), dte.getDate()-n, 1, 0, 1, 1)
        date_to_string d2

    $$.hier = (dte) ->
        $$.dte_n_jours_avant(dte,1)


    $$.change_begining_prd = (n_days)-> # calcul du début de la période pour le graphe XY
        $$.dddp = $$.dte_n_jours_avant(new Date($$.dddr), n_days)
        #$$.set_cursor('mois')
        #show $$.dddp, '(01)'
        #broadcast_lower() # give info to lower ctlr for updating

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # les dates dans le rootScope puis cargement de ttes les bses
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    # init_date est utilisée pour le remplissage INITIAL DES BD ( le maximum possible)
    init_date = (d) -> # d est une date sous forme de chaine
        #
        # when dddr is finded all dbs are loaded.
        window.top.date_0 = $$.date_0 = $$.date_2 = new Date(d)

        # on calcule la date de présentation de de la courbe xy
        $$.dddp = $$.dte_n_jours_avant(new Date($$.dddr),$$.day_prd) # date de début de période à l'initialisation

        switch $$.rdio_dv
            when 'v'  then $$.maj_bd $$, $http, ajx_fl, 'Initial',     d, d, $$.rdio_dv   # premier chargement
            when 'p'  then $$.maj_bd $$, $http, ajx_fl, 'initial_dp',  d, d, $$.rdio_dv
            when 'w'  then $$.maj_bd $$, $http, ajx_fl, 'initial_w',   d, d, $$.rdio_dv
            when 'm'  then $$.maj_bd $$, $http, ajx_fl, 'initial_m',   d, d, $$.rdio_dv
            when 'o'  then $$.maj_bd $$, $http, ajx_fl, 'initial_o',   d, d, $$.rdio_dv
            when 'at' then $$.maj_bd $$, $http, ajx_fl, 'initial_at',  d, d, $$.rdio_dv

        #if $$.board.bilan then  show 'ds init dte'
        $$.get_bilan()
#           TODO effacer le 22-07
#
#         $$.get_bd_variation($$.var_nbj)
#
#         on informe les enfants
#        broadcast_lower() # emit graph pies & xy
        $$.dates = d # affichage de la date

    # deuxième méthode on lance les requêtes après attente
    # du retour de la précédente

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Handle dates
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    dte_last_report = () -> new Date(new Date().getTime() - 31 * 3600000 + 1 * $$.TimeOffset)

    window.top.date_0 = $$.date_2 = $$.date_0 = dte_last_report()

    stg = new Date(new Date().getTime() - 31 * 3600 * 1000 + 0 * $$.TimeOffset).toISOString().slice 0, 10

    $$.dates = stg #date_to_string() # affichage de la date

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # dialogue parents - enfants
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
#
#    $$.$on 'emit_from_pie_to_parent', (event, args) -> #écoute les changements du scope parent
#        ok = date_is_ok( args.date_0) and date_is_ok (args.date_2)
#        if ok
#            $$.date_0 = args.date_0
#            $$.date_2 = args.date_2
#            $$.rdio_dv = args.rdio_dv
#            $$.dte_select = args.dte_select
#            $$.$broadcast 'broadcast_to_xy', $$.rdio_dv
#            #show $$.rdio_dv, '  01 -->'
#            $$.change_2_dates()
#            $$.get_bilan() #$$.maj_bd $$, $http, ajx_fl, 'bilan', date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv
#            #$$.get_bd_variation($$.var_nbj)
#        else
#            raz_bd_empty('Erreur de date', 'Une des  dates requise pour le graphique des pies est postérieure à celle de la dernière extraction.' )
#
#    broadcast_lower = () -> #synchro des scopes parent --> enfants
#        val_to_broadcast =
#            date_0    : $$.date_0,
#            date_2    : $$.date_2
#            dddr      : $$.dddr #date du dernier rapport
#            dte_select: $$.dte_select,
#            rdio_dv   : $$.rdio_dv
#            show_bse_m: $$.show_bse_m
#            dddp      : $$.dddp # valeur du début de période
#        #$$.$broadcast 'broadcast_from_parent_to_pie', val_to_broadcast
#        #$$.$broadcast 'broadcast_to_xy',val_to_broadcast
#        #show '01 ici'; if $$.board.bilan then show 'et là'
#
#

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # changement date ou visu
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    date_is_ok = (dte) -> # date is an date obj
        dtemp = date_to_string( new  Date dte)
        #show dtemp,'temp -->'
        return dtemp <= $$.dddr

    $$.change_D0 = () -> # update data when changing date
         if date_is_ok( $$.date_0 )
            $$.dte_select = ''
            # broadcast_lower()
            ancienBut = 'date_0'
            $$.maj_bd_2(date_to_string($$.date_0))
            #$$.maj_bd $$, $http, ajx_fl, 'gain_0' , date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv
         else
             raz_bd_empty('Erreur de date', 'La date requise est postérieure à celle de la dernière extraction.' )   # envoi de la page modale d'erreur

    $$.change_D2 = () ->
        if date_is_ok( $$.date_2 )
            $$.dte_select = ''
            # broadcast_lower()
            ancienBut = 'date_2'
            $$.maj_bd_2(date_to_string($$.date_2))
            #$$.maj_bd $$, $http, ajx_fl, 'gain_0' , date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv
        else
            raz_bd_empty('Erreur de date', 'La date requise est postérieure à celle de la dernière extraction.' )   # envoi de la page modale d'erreur

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Event scroll
    # test the wheel to réduce the menu
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.menu_on_off = (visible) -> #div blank update when menu switch on-off
        $$.show_menu = visible is 'visible'
        if visible is 'visible' then $$.height_blank_menu = 'height_blank_menu_1' #12em'
        else                         $$.height_blank_menu = 'height_blank_menu_2'
        #$$.$apply() #no apply for it's till running
#    TODO supprimer le 23-07
#    wheelHandler= (e) ->
#        #cross-browser wheel delta
#        e = window.event or e #old IE support
#        delta = Math.max -1, Math.min(1, (e.wheelDelta or -e.detail))
#        #show delta, 'delta'
#
#        if $$.dddr isnt '1954-07-28'        # we're not at the begining
#            $$.show_menu = off    # now the menu is cut
#            $$.height_blank_menu = '4em'
#            $$.$apply()
#
#    # all the page is concerning with scrolling
#    my_id = document.getElementById "id_body"
#
#    if  my_id.addEventListener # IE9, Chrome, Safari, Opera
#        my_id.addEventListener "mousewheel", wheelHandler, false #Firefox
#        my_id.addEventListener "DOMMouseScroll", wheelHandler, false #iE 6/7/8
#    else my_id.attachEvent "onmousewheel", wheelHandler

#    $$.well_mouse_enter = () ->
#        if $$.dddr isnt '1954-07-28'        # we're not at the begining
#            $$.show_menu = on    # now the menu is cut
#            $$.height_blank_menu = '11em'
#            #$$.$apply()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # lancement initial et GENERAL e la mise a jour de la bd
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    #on retrouve la date du dernier rapport : dddr
    $$.maj_bd $$, $http, ajx_fl, 'dddr', '', '', ''
    $$.bd_glob = get_bd_global_dvdp($$.rdio_dv)

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # tri des colonnes
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.clic_tri_col = (col)-> # tri de la base globale
        if col not in ['Regie', 'Jeu', 'Camp']
            z[col] = parseFloat(z[col]) for z in $$.bd_glob
        if $$.tri.col isnt col then  $$.tri.col = col #on détermine la colonne de tri
        else $$.tri.desc = not $$.tri.desc

    $$.clic_tri_col_simple = (col, sens='up') ->
        if col not in ['Regie', 'Jeu', 'Camp']
            z[col] = parseFloat (z[col])  for z in $$.bd_glob
        if $$.tri.col isnt col then  $$.tri.col = col #on détermine la colonne de tri
        if sens is'up' then $$.tri.desc = true
        else  $$.tri.desc = false

#    TODO retirer le 24-07
#    tri simplement les modifs selon un clic sur l'entête de colone
#    $$.clic_tri_modifs = (col, sens='up') ->
#        if  col not in ['Date','Regie','Jeu', 'Camp']
#            z[col] = parseFloat z[col]  for z in $$.mdf.bd
#        if $$.tri_modifs.col isnt col then   $$.tri_modifs.col = col #on détermine la colonne de tri
#        if sens is 'up' then  $$.tri_modifs.desc = true
#        else   $$.tri_modifs.desc = false
#
#    #idem que pour modifs
#    $$.clic_tri_bid = (col, sens='up') -> # tri simplement les bid
#        if  col not in ['Date','Regie','Jeu', 'Camp']
#            for z in $$.bid.bd
#                z[col] = parseFloat z[col]
#        if $$.tri_bid.col isnt col then   $$.tri_bid.col = col #on détermine la colonne de tri
#        if sens is 'up' then  $$.tri_bid.desc = true
#        else   $$.tri_bid.desc = false
#
#    $$.clic_tri_levier = (col) -> # col  in ['Marge', 'Renta'] only
#    #show  col
#        if $$.tri_levier.col isnt col then $$.tri_levier.col = col
#        else $$.tri_levier.desc = not $$.tri_levier.desc
#
#        $$.get_bd_regie_jeu $$.bd_levier[0].Jeu
#
#    $$.clic_tri_levier_regie = (col) ->
#        if $$.tri_levier_regie.col isnt col then $$.tri_levier_regie.col = col
#        else $$.tri_levier_regie.desc = not $$.tri_levier_regie.desc
#    #$$.goto_page_anchor('id_levier')


    #  sur jeu dans la proc le levier
    $$.get_bd_regie_jeu = (j) -> # On trie les elements de la bd_glob contenant le jeu j seulement
        b0 = $$.bd_glob.where Jeu: j
        b1 = []
        for bb in b0
            c = parseFloat(bb.TjCout);
            m = parseFloat(bb.Marge);
            p = bb.Camp
            r = bb.Regie;
            b1.push Jeu: j, Regie: r, Marge: m, Cout: c, Renta: -m / c * 1.2, Camp: p
        $$.bd_regie_jeu = b1

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # empêche un envoi d'erreur dans le cas d'une sélection  marge <-10
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.change_select_tab = (type, value) ->
        # type is 'Regie', 'Jeu' ...
        # value is the value of type
        #$window.alert '$$.rdio_action='+$$.rdio_action + '   ' + value
        if $$.rdio_action is '-10'
            $$.set_cursor('wait')
            partial_raz()
            $$.filtre[type] = value
            $$.rdio_action = ''
            $$.$apply()
        # les reux $$.rdio_action (s) sont nessessaires
        # car apply a besoin du sien
        $$.rdio_action = ''

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # somme de colonnes
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.sum_col = (col)->
        try
            s = 0
            for y in $$.gbd_filtree
                s += parseFloat(y[col])
            return s
        #show "dans sum_col (01.coffee) : #{e.message}" ,' (fc) une erreur traitée '

    $$.sum_global = (col)->
        #$$.set_cursor('end_filtre')
        s = 0
        try
            s += parseFloat(y[col]) for y in $$.bd_glob
            return s.toFixed(0)

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # raz filters  & change
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    partial_raz = () ->
        $$.fJeu = ''
        $$.filtre = {Jeu: '', Regie: '', Camp: ''}
        $$.fGain = $$.fMarge = -1e9   # Infinity
        $$.fRenta = $$.fTjCPM = 1e9   # Infinity
        $$.clic_tri_col 'Marge'

    $$.raz_filtre = () ->
        partial_raz()

        #$$.chk_aff_bilan = true
        #$$.rdio_dv = 'v'
        $$.dte_select = "j"
        $$.date_0 = $$.date_2 = new Date $$.dddr # date du dernier rapport
        #aff_a(1, $$.dddr)
        #$$.menu_on_off('visible')

        #broadcast_lower() # info sended to childs
        $$.mdf.show_one_cmp = false
        #$_debut = true
        #$$.change_2_dates()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.cvr_cpm = $$.cvr_inf_1 = $$.change_700 = $$.change_70 = $$.change_raz = $$.change_0 = -> $$.raz_filtre()
    $$.change_T = $$.change_M = $$.change_G = -> $$.rdio_action = ''

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Filtrage du tjcpm : automatique
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_tjcpm5 = (max_tjcpm = 5) -> # affiche les item montrant : TjCPM < 5

        #Calcul des dates
        j7 = new Date new Date($$.dddr).getTime() - 6 * 24 * 3600000
        $$.date_0 = new Date $$.dddr
        $$.date_2 = j7

        # maj du titre
        $$.dates = " du  #{date_to_string($$.date_0)}  au  #{date_to_string($$.date_2)}"

        ancienBut = 'date_0_et_2'
        # go & search
        $$.maj_bd $$, $http, ajx_fl, 'periode', date_to_string($$.date_0), date_to_string($$.date_2), $$.rdio_dv

        $$.fTjCPM = max_tjcpm # maj du filtre
        $$.filtre = {Regie: 'TJ', Jeu: '', Camp: ''} # filtrage de tj uniquement

        $$.fGain = $$.fMarge = -1e9   # Infinity
        $$.fRenta = 1e9   #  Infinity
        $$.clic_tri_col 'Marge' # ordonner par marge
        $$.dte_select = "j7"

        $$.chk_aff_tableau = on # aff du tableau
        $$.bazinga_scroll 'id_tableau' # va sur le tableau
        #broadcast_lower() # info aux enfants pour maj


    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # mise au point du curseur
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #$$.$watch "dte_select",   (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'dte'
    $$.$watch "filtre.Regie", (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'regie'
    $$.$watch "filtre.Jeu",   (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'regie'
    $$.$watch "filtre.Camp",  (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'regie'
    #$$.$watch "date_0",  (nw, old)-> if nw isnt old then $$.class_cursor ='cursor_wait';cursor_waiting_for = 'dte'

    idx_lst = 0 # index last index: compter de passage de la table ds le renderes angular

    $$.when_last = (lst) ->
        idx_lst++ if cursor_waiting_for in ['filtre','regie']
        if idx_lst >6 and cursor_waiting_for is 'filtre' then $$.set_cursor 'raz_cursor' ; idx_lst = 0
        if idx_lst >2 and cursor_waiting_for is 'regie'  then $$.set_cursor 'raz_cursor' ; idx_lst = 0

        #show " last = "+cursor_waiting_for+" idx = "+idx_lst, ' de when last' if idx_lst >0

    $$.set_cursor = (cr, call_back) ->

        set_end_filtre = () -> $$.set_cursor 'raz_cursor'

        if  cr in  ['wait','dte','mois'] #and cursor_waiting_for is '' # un seul curseur à la fois
            $$.class_cursor ='cursor_wait'
            #show 'set_cursor (1) ; cursor_waiting_for = '+cursor_waiting_for, ' cr = '+cr
            cursor_waiting_for = cr
            $timeout  set_end_filtre, 6500 # sécurité de coupure

        else if cr is 'filtre' and  cursor_waiting_for is ''
            $$.class_cursor ='cursor_wait'
            cursor_waiting_for = cr
            $timeout  set_end_filtre, 4000

        else if cr is 'raz_cursor'
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

        else if cr is 'auto' and cursor_waiting_for is 'wait'# for the beginning
            $$.class_cursor ='cursor_auto'
            cursor_waiting_for = ''

        else if cr is 'fin_mois' and cursor_waiting_for is 'mois'# for the beginning
          $$.class_cursor ='cursor_auto'
          cursor_waiting_for = ''

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # bilan à mettre à jour
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    $$.get_bilan = () ->
            ## call back to react  after loading
            $_then = ()->
                $$.board.bilan = on # to show bilan
                #show 'bilan' ,$$.board.bilan

            # demande d'auutorisation
            if  $$.chk_aff_bilan # board.bilan
                $$.maj_bd $$, $http, ajx_fl, 'bilan', $$.dddr, $$.dddp, $$.rdio_dv, $_then
            else $$.get_bd_variation($$.var_nbj)
            #show 'passage par get_bilan'
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # changement dv dp
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_dv = ()-> # cela permet de retrouver l'environnement précédent

        #document.getElementById("id_body").setAttribute("style", "wait;")
        # changement de base = démarrage
        $$.chk_aff_bilan = $$.chk_aff_xy == off
        $$.chk_aff_tableau = on
        $$.board.xy = $$.board.bilan = off
        $$.chk_aff_bilan = $$.chk_aff_graph_lgn = off
        $$.rdio_action = 'raz' # "700" # à cause de $$.rdio_action = '-10'
        vu_marge_10 = true
        $$.bd_glob = []

        switch $$.rdio_dv
            when 'v'   then $$.maj_bd $$, $http, ajx_fl, 'Initial',     $$.dddr, $$.dddr, $$.rdio_dv  # premier chargement
            when 'p'   then $$.maj_bd $$, $http, ajx_fl, 'initial_dp',  $$.dddr, $$.dddr, $$.rdio_dv
            when 'w'   then $$.maj_bd $$, $http, ajx_fl, 'initial_w',   $$.dddr, $$.dddr, $$.rdio_dv
            when 'm'   then $$.maj_bd $$, $http, ajx_fl, 'initial_m',   $$.dddr, $$.dddr, $$.rdio_dv
            when 'o'   then $$.maj_bd $$, $http, ajx_fl, 'initial_o',   $$.dddr, $$.dddr, $$.rdio_dv
            when 'at'  then $$.maj_bd $$, $http, ajx_fl, 'initial_at',  $$.dddr, $$.dddr, $$.rdio_dv

        #broadcast_lower()
        $_debut = true
        $$.get_bilan() #$$.maj_bd $$, $http, ajx_fl, 'bilan', $$.dddr, '--.--', $$.rdio_dv
        #les variations sont lancées par le success du bilan

        $$.filtre = {Jeu: '', Regie: '', Camp: ''}

#        $$.bid.show      = $$.mdf.show      = off # raz des modifs
#        $$.mdf.bd_aff    = $$.mdf.bd_reduits = $$.mdf.bd        = []
#        $$.bid.bd_aff    = $$.bid.bd_reduits    = $$.bid.bd            = []
#        $$.bid.flt.IdCamp= $$.mdf.flt.IdCamp    = '' # gestion des filtres des deux tableaux
#
#        $$.mdf.bd_aff  = $$.mdf.bd_reduits     # par défaut aff réduit et compact
#        $$.bid.bd_aff     = $$.bid.bd_reduits        # par défaut aff réduit et compact
#        $$.chk_mdf_complet = $$.chk_bid_complet = off
#        $$.mdf.show_one_cmp= false

        switch ancienBut
            when 'date_0' then $$.change_2_dates() #$$.maj_bd_2 ($$.date_0)# une date
            when 'date_2' then $$.change_2_dates() #$$.maj_bd_2 ($$.date_2) # id
            else
                $$.change_2_dates() # maj de bd_glob

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # changement de date au sélecteur
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_dte_select = (dte) -> # we are in parent
        #show  dte,' cursor waiting =  '+cursor_waiting_for
        switch dte
            when "j", ''
                today = new Date $$.dddr
                $$.date_0 = $$.date_2 = today
                $$.change_bd_variation(date_to_string(new Date new Date($$.dddr).getTime() - 6 * 24 * 3600000), 7)

            when "j-1"
                hier = new Date new Date($$.dddr).getTime() - 24 * 3600000
                $$.date_0 = $$.date_2 = hier
                $$.change_bd_variation(2, 2)

            when "j7"
                j7 = new Date new Date($$.dddr).getTime() - 8 * 24 * 3600000
                $$.date_0 = new Date $$.dddr
                $$.date_2 = j7
                $$.change_bd_variation(date_to_string($$.date_2), 7)

            when "j30"
                j30 = new Date new Date($$.dddr).getTime() - 31 * 24 * 3600000
                $$.date_0 = new Date $$.dddr
                $$.date_2 = j30
                $$.change_bd_variation(date_to_string($$.date_2), 30)
                #date_to_string new Date new Date($$.dddr).getTime() - (nbj-1)* 24 * 3600000 #  type string

            when "mois"
                $$.date_0 = d = new Date $$.dddr
                $$.date_2 = new Date(d.getFullYear(), d.getMonth(), 1, 0, 0, 1, 1)
                $$.change_bd_variation(date_to_string($$.date_2), 'mois')


            when "mois-1"
                d = new Date $$.dddr
                $$.date_0 = new Date(d.getFullYear(), d.getMonth(), 0, 1, 0, 1, 1)
                $$.date_2 = new Date(d.getFullYear(), d.getMonth() - 1, 1, 1, 0, 1, 1)
                #$$.date_2 = new Date(d1.getFullYear(), d1.getMonth(),1,1, 1,0,0)
                $$.change_bd_variation(date_to_string($$.date_2), 'mois-1')

            when "tout"
                $$.date_0 = new Date $$.dddr
                d = new Date(new Date('2010-01-01').getTime())
                $$.date_2 = d
                $$.change_bd_variation(date_to_string($$.date_2),'tout')

        $$.change_2_dates()
        #broadcast_lower() # give info to lower ctlr for updating

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # filtres
    # avant événtuellement mettre les rdio btn à null
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨
    $$.filtre = {Jeu: '', Regie: '', Camp: ''}
    $$.fGain = '' # init
    $$.fMarge = -1e9   # Infinity par convention
    $$.fRenta = $$.fTjCPM = 1e9 #Infinity
    $$.rdio_action = "700" # au depart top 70 & <0 actives
    $$.tri = {col: 'Marge', desc: true}
    $$.tri_levier = {col: 'Marge', desc: true}
    $$.titre =''

    $$.Gain_sup     = (x)  -> x.Gain > $$.fGain
    $$.Renta_inf    = (x)  -> -x.Marge/x.TjCout*1.2 <= $$.fRenta
    $$.TjCPM_inf    = (x)  -> x.TjCPM < $$.fTjCPM

    $$.is_id        = (x)  ->
        # for show modifs
        if not $$.mdf.show_one_cmp   then return true
        parseFloat(x.idCamp) is parseFloat($$.mdf.flt_IdCamp)

    # marges ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    # Allume le tableau s'il y a des marges <-10 ; AU LANCEMENT DE L4APPLI
    marge_inf_10_exists = (bd) ->
        for y in bd
            if  parseFloat(y.Marge) < -10
                return  true
        return false

    $$.Marge_sup = (x)  ->
        xmax = m = mt = 0 # sortie de x pour 70%, temp, marge totale
        mt += parseFloat(y['Marge']) for y in $$.bd_glob
#
#
#
#        for y in $$.bd_glob
#            xmax = parseFloat(y['Marge'])
#            break if not ( xmax > 0 and m < 0.7 * mt)
#            m += xmax # xmax the last available
#
#        # traitement des marges < -10
#        m_inf10 = false
#        if $$.chk_aff_tableau is off and not vu_marge_10
#            for y in $$.bd_glob
#                if  parseFloat(y.Marge) < -10
#                    m_inf10 = true
#                    break
#            # Allume le tableau s'il y a des marges <-10
#            if m_inf10
#                #show '1', 'm_inf10 = ' + m_inf10
#                $$.rdio_action =  "-10"
#                $$.chk_aff_tableau = on
#                vu_marge_10 = true
#            else
#                $$.rdio_action = '700'
#                #show '2', 'm_inf10 = ' + m_inf10
#

        # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨¨~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
        # quand les filtres 'complexes' sont résolus
        # on traite les simples
        # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨¨~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

        switch $$.rdio_action

            # filtres cvr < 1
            when "cvr_1"  # permet de filtrer les campagnes dont cvr<1
                parseFloat(x.Transfo)/parseFloat(x.TjClic )* 100 < 1

            when "cvr_1_&_cpm_5" # permet de filtrer les campagnes dont cvr<1 et cpm<5
                (parseFloat(x.Transfo)/parseFloat(x.TjClic )* 100 < 1) and (parseFloat(x.TjCPM) < 5)

            # filtre marge faisant 70% des mrgs glob
            when "70"    then x.Marge > xmax # top 70

            # mrg <-10€
            when "-10"   then x.Marge < -10

            # filtre marge < 0
            when "0"     then x.Marge < 0 # <0

            # filtre composite : marges formant 70% de l'ensemble et les margs < 0
            when "700"   then not (xmax >= parseFloat(x.Marge) > 0) # les 2 precedents

            # filtre marges > fMarge ( dans l'imput de droite )
            else
                x.Marge > $$.fMarge


    # @formatter:off
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # Calcul au retour de l'ajax les bd jeux, regies et campagnes
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_marge_renta = (m_min = 100, r_max=2) ->
        bdl = []

        # interrupteurs de filtre à 0
        $$.fJeu = ''
        #show $$.renta_maxi,1
        $$.filtre = {Jeu: '', Regie: '', Camp: ''}
        $$.fMarge = $$.fGain =  -Infinity
        $$.fTjCPM = Infinity
        $$.clic_tri_col 'Marge'
        $$.fRenta = 2
        $$.fMarge = m_min
        $$.chk_aff_tableau = on # aff du tableau
        $$.bazinga_scroll 'id_tableau' # va sur le tableau

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # bilan à mettre à jour
    # utile car elle est appellée depuis 03_graph ...
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

#    $$.i_var = () -># permet de calculer la deuxième partie du titre des variations
#        switch $$.dte_select
#            when 'j-1'       then return 1
#            when 'j7'        then return 2
#            when 'j30'       then return 3
#            when 'mois'      then return 4
#            when 'mois-1'    then return 5
#            when 'tout'      then return 6
#
#            else            return 2
#
#    set_title_variation = (laps) -> # may be a number or a string ; that's a period for variation
#        switch laps
#            when 2          then ttl = '2 derniers j'
#            when 7          then ttl = '7 derniers j'
#            when 30         then ttl = '30 derniers j'
#            when 'mois'     then ttl = 'mois en cours'
#            when 'mois-1'   then ttl = 'mois précédent'
#            when 'tout'     then ttl = 'prd en jours'
#
#            else            ttl = '7 derniers j'
#        ttl # return title

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    # bring back db from initial db with php
    $$.get_bd_variation = (nbj=7) ->
        if typeof nbj is 'number'# nbj is either a number or a date
            # it's a number of day
            dte = date_to_string new Date new Date($$.dddr).getTime() - (nbj-1)* 24 * 3600000 #  type string
            #show typeof dte
        # it's a date now
        else dte = nbj # assume nbj is a date
        $$.bd_variation =[]
        $$.maj_bd $$, $http, ajx_fl, 'variation', $$.dddr, dte, $$.rdio_dv    # premier chargement

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    $$.change_bd_variation = (nbj=7, periode = 7) -> #~ event scope
        $$.get_bd_variation(nbj)        # on va chercher la bd
        handle_bd_variation()           # on rempli les bd rel et abs
        #show periode
        #$$.title_variation = set_title_variation(periode)

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    #un clic sur la tableau variation affiche la campagne au niveau du tableau global

    $$.var_2_glob = (cmp) ->
        #show (cmp.Regie) + ' ; '+ (cmp.Jeu) + ' ; ' + (cmp.Camp) + ' ; ' + (cmp.IdCamp) ,'cmp'
        $$.filtre = { Regie: cmp.Regie, Jeu: cmp.Jeu, Camp: cmp.Camp } # filtrage hadoc de la base globale

        ### raz des filtres inutiles###
        $$.fGain = $$.fMarge = -1e9   # Infinity
        $$.fRenta = 1e9   # Infinity

        $$.chk_aff_tableau = on # aff du tableau
        $$.rdio_action =''
        $$. bazinga_scroll 'id_tableau',45 # va sur le tableau


    $$.filter_glob_by_id = (id) ->
        #show id, 'filter_glob'
        $$.filtre = { Regie: '', Jeu: '', Camp: '' } # filtrage hadoc de la base globale


        $$.fGain = $$.fMarge = -1e9   # Infinity # raz des filtres inutiles
        $$.fRenta = 1e9   # Infinity
        $$.mdf.flt_IdCamp =id
        $$.chk_aff_tableau = on # aff du tableau
        $$.rdio_action =''
        $$.bazinga_scroll 'id_tableau',45 # va sur le tableau


    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # get levier et camp
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
#    get_bd_levier = (bd = $$.bd_glob) ->
#        $$.bd_levier = bdl = [] #bd  de retour
#        jx = [] #les jeux trouvés
#        if bd?
#            for d in bd
#                if d.Jeu not in jx
#                    bdl.push {
#                        Jeu  : d.Jeu,
#                        Cout : parseFloat(d.TjCout),
#                        Marge: parseFloat(d.Marge),
#                        Renta: -parseFloat(d.Marge) / parseFloat(d.Cout)
#                    }
#                    jx.push d.Jeu
#                else
#                    j = (bdl.where Jeu: d.Jeu)[0]
#                    j.Cout += parseFloat(d.TjCout)
#                    j.Marge += parseFloat(d.Marge)
#                    j.Renta = -j.Marge / j.Cout * 1.2 # rapport du dollardlevier
#            $$.bd_levier.sort((a, b) -> a.Marge < b.Marge) # TODO à vérifier absolument
#            $$.bd_levier = bdl
#
#        # remplissage par défaut du tableau régies associée dans la proc levier
#        try
#            # le try pour éviter des pb au démarrage
#            $$.get_bd_regie_jeu($$.bd_levier[0].Jeu)
#        catch e
#            foo= 0
#        finally
#            $$.set_cursor('end_dte')

    # @formatter:on

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    get_bd_jeux_regies_campagnes = () ->

        try #get jeux
            $$.bd_jeux = []
            tj = [] #scrute tous les jeux du jour ou de la période
            tj.push(y.Jeu) for y in $$.bd_glob when y.Jeu not in tj
            $$.bd_jeux.push {name: z, value: z} for z in tj

            #get Régie
            $$.bd_regies = []
            tr = [] #scrute tous les regies
            #$$.bd_regies.push {name: 'Toutes regies', Value: ''}
            tr.push(y.Regie) for y in $$.bd_glob when y.Regie not in tr
            $$.bd_regies.push {name: z, value: z} for z in tr
            $$.TJ_exists = 'TJ' in tr
            #show $$.TJ_exists, 'tj'

            #get campagnes
            for y in $$.bd_glob
                if y.Camp? and y.Camp.lastIndexOf('(') > 0
                    y.Camp = y.Camp.slice(y.Camp.lastIndexOf("(") + 1, y.Camp.lastIndexOf(")"))
                else y.Camp = z for z in ['premium', 'www', 'excluding','KITTY - FYBER'] when y.Camp? and y.Camp.lastIndexOf(z) > 0

            for t in $$.bd_glob
                t.Camp = 'www' for z in ['WW, excluding live countries', 'Global', 'KITTY - FYBER'] when t.Camp == z

            $$.bd_camp = [];
            tc = [] #scrute tous les campagnes
            #$$.bd_camp.push {name: 'Toutes camp', Value: ''}
            tc.push(y.Camp) for y in $$.bd_glob when y.Camp not in tc
            $$.bd_camp.push {name: z, value: z} for z in tc

        catch e
            if not $$.bd_glob?
                show '(01) : get_bd_jeu, 01, erreur traitée'
                # TODO mettre un compteur pour éviter les boucles infinies
                #get_bd_jeux_regies_campagnes() # !!! dangereux
                wait_ms 1000 # mise en attente
                return
            else show '(01) : get_bd_j' ,'erreur inconnue'

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # outils ( peuvent être placés ds la Factory)
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    # formatage des nb d'espaces tous les 1000
    # existe aussi en prototype nombre
    $$.format_n = (a, t = 0) ->
        u = parseFloat(parseFloat(a).toFixed(t))
        return '' if a in [Infinity, -Infinity] or isNaN(a)
        #log(typeof (u))
        u.toLocaleString()

    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    # clavier
    # ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

#    rac = new Raccourcis
#
#    $$.kb_event = (e) ->
#
#        # allume ou éteint tous les tableaux
#        all_on_off = (on_off)  ->
#            $$.chk_aff_bilan = on_off;              $$.chk_aff_graph_jeux_regies = on_off
#            $$.chk_aff_graph_campagnes = on_off;    $$.chk_aff_graph_campagnes  = on_off
#            $$.chk_aff_tableau = on_off;            $$.chk_aff_graph_lgn = on_off
#            $$.chk_aff_levier = on_off;             $$.chk_aff_gain_0 = on_off
#        rac.get_event(e)
#        if rac.keydown then return
#
#        todo = () ->
#            if rac.short then return 'flip'
#            else
#                all_on_off off
#                return 'on'
#
#        #$window.alert rac.montre()
#        switch  e.keyCode
#            when 66                                                                                                   #b
#                $$.chk_aff_bilan = rac.flip $$.chk_aff_bilan, todo()
#                #show $$.chk_aff_bilanb
#                if $$.chk_aff_bilan  then $$.bazinga_scroll 'id_bilan',55
#            when 82                                                                                                   #r
#                $$.chk_aff_graph_jeux_regies = rac.flip  $$.chk_aff_graph_jeux_regies, todo()
#                if not $$.chk_aff_graph_jeux_regies then $$.bazinga_scroll 'id_aff_graph_jeux_regies',55
#            when 67                                                                                                   #cnaaaa
#                $$.chk_aff_graph_campagnes = rac.flip  $$.chk_aff_graph_campagnes, todo()
#                $$.bazinga_scroll 'id_aff_graph_campagnes',55 if not $$.chk_aff_graph_campagnes
#            when 71                                                                                                   #g
#                $$.chk_aff_gain_0 = rac.flip  $$.chk_aff_gain_0, todo()
#                $$.bazinga_scroll 'id_gain_0',55 if not $$.chk_aff_gain_0
#            when 84                                                                                                   #t
#                $$.chk_aff_tableau = rac.flip  $$.chk_aff_tableau, todo()
#                if  $$.chk_aff_tableau
#                    $$.bazinga_scroll 'id_tableau',55
#                    #$$.menu_on_off('visible') # ouvre le menu
#
#            when 88, 89                                                                                               #x y
#                $$.chk_aff_graph_lgn = rac.flip  $$.chk_aff_graph_lgn, todo()
#                if $$.chk_aff_graph_lgn  then $$.bazinga_scroll 'graph_lgn',55
#            when 76                                                                                                   #l
#                $$.chk_aff_levier = rac.flip  $$.chk_aff_levier, todo()
#                if $$.chk_aff_levier  then $$.bazinga_scroll 'id_fin',55
#            #when 38     then $$.menu_on_off('hidden')                                                                 # flèche haute
#            #when 40     then $$.menu_on_off('visible')                                                                # flèche basse
#
#            when 65  then all_on_off (on)                                                                             #a
#            when 78  then all_on_off (off)                                                                            #n
#            when 33  then $$.rdio_action = 'raz' ; $$.raz_filtre()                                                    # escape
#            when 74  then $$.dte_select = 'j' ; $$.change_dte_select 'j'                                              #j
#            when 83  then $$.dte_select = 'j7' ; $$.change_dte_select 'j7'                                            #s
#            when 77  then $$.dte_select = 'mois' ; $$.change_dte_select 'mois'                                        #m
#            when 69  then $$.dte_select = 'tout' ; $$.change_dte_select 'tout'                                        #e
#            when 86  then $$.rdio_dv = 'v' ; $$.change_dv()                                                           #v
#            when 80  then $$.rdio_dv = 'p' ; $$.change_dv()                                                           #P
#            when 87  then $$.rdio_dv = 'w' ; $$.change_dv()                                                           #w
#            when 79  then $$.rdio_dv = 'm' ; $$.change_dv()                                                           #o
#            when 72  then $("#modal_aide").modal(show)                                                                #h
#        rac.reset

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Modal error
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

    raz_bd_empty = (t_itre = 'Filtre trop restrictif',b_ody = ' Remise à zéro des filtres') ->
            $$.open_modal {title: t_itre , body: b_ody, job: 'Raz'}
            $$.rdio_action = 'raz'
            $$.raz_filtre()
            $$.change_2_dates()
            $_debut = true

    $$.raz_if_bd_empty = () ->
        try
            if  $$.gbd_filtree.length > 0  then $_debut = false # db is now loaded
            #if $$.gbd_filtree? then #show $$.gbd_filtree.length
            if $$.gbd_filtree.length < 1 and not $_debut
                $$.open_modal {title: 'Filtres trop restrictifs', body: ' Remise à zéro des filtres', job: 'Raz'}
                $$.rdio_action = 'raz'
                $$.raz_filtre()
                $_debut = true if not $_debut # db 'll be loaded*
                return true # db empty
        return false # db not empty

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
    return # lancement du controleur
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

# ============ ~ ============ ~ ============ ~ ============ ~ ============ *
# OUTILS GLOBAUX                                                           *
# ============ ~ ============ ~ ============ ~ ============ ~ ============ *

window.date_to_string = (d) ->
    new Date(new Date(d).getTime() - 1 * ( new Date().getTimezoneOffset() * 60 * 1000)).toISOString().slice 0, 10 #

sign = (x) ->  if x < 0 then return -1 else return 1 # calcule du signe d'un nb TODO to Number prototype

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# raccourcis clavier
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

class Raccourcis
    constructor: () ->
        @keydown = false
        @code_down = 0
        @ts_down = @ts_up = 0 # time stamp
        @short = true

    get_event: (e) ->
        if e.type is 'keydown' and @keydown is false
            @keydown = true
            @code_down = e.keyCode
            @ts_down = e.timeStamp #time stamp

        else if e.type is 'keyup'
            @keydown = false
            @ts_up = e.timeStamp
            @short = @is_short() # double clic lettre ?

    montre: () =>
        stg = "code_down: #{@code_down} | ts_down : #{@ts_down} | ts_up : #{@ts_up} |  short: #{@short} | time:" + @get_time()
        #show stg

    get_time: () ->  return  @ts_up - @ts_down  #between 2 hits

    is_short: () -> @get_time() < 1000 # short time 1"

    reset: () -> @code_down = @ts_down = @ts_up = 0; @short = false

    # bascule un panneau aff on/off
    flip: (dom, flip_on_off) ->
        switch flip_on_off
            when 'flip' then return not dom
            when 'on'   then return  on
            when 'off'  then return  off


# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# retourne a/b en pourcentage
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
window.pourcentage = (a, b)-># a est la base du pourcentage
    a = parseFloat(a)
    b = parseFloat(b)
    return NaN if b == 0
    c = (a / b - 1) * 100
    if a >= b then c = sign(c) * c  else c = sign(c) * (-1) * c if b > a
    #show (c+ '  '+a+'  '+b),"N / "
    c

# pourcentage de a  b comme  prototype de Number
# ou calcul l'augmentation de a en % de a par rapport à b
window.Number::pourcentage = (b) ->
    a = @valueOf()
    b = parseFloat(b)
    return NaN if b is 0
    c = (a / b - 1) * 100
    #console.log(c+ '  '+a+'  '+b)
    return sign(c) * c if a >= b
    return sign(c) * (-1) * c  if b > a

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# ARRAY  différentes fonctions
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

# Extending Array's prototype
unless Array::filter
    Array::filter = (callback) ->
        element for element in this when callback(element)


# introduction de la fonction Where pour les  Arrays
# par modification de la class Array
window.Array::where = (query) ->
    return [] if typeof query isnt "object"
    hit = Object.keys(query).length
    @filter (item) ->
        match = 0
        for key, val of query
            match += 1 if item[key] is val
        if match is hit then true else false

# tri d'une Array fonction du champ Var_marge
# !! attention !! ce tri est particulier car il tri en fonction
# de la valeur absolue de la colonne  : '*sign c'

window.marge_var_abs= (a,b)  ->
    c = a.Var_marge * sign a.Var_marge
    d = b.Var_marge * sign b.Var_marge
    if       c > d  then return -1
    else if  c < d  then return 1
    return 0

window.clic_var_abs= (a,b)  ->
    c = a.Var_clic * sign a.Var_clic
    d = b.Var_clic * sign b.Var_clic
    if c > d  then return -1
    else if  c < d  then return 1
    return 0

window.marge_var_rel = (a,b) ->
    c = a.Var_marge_relative * sign a.Var_marge_relative
    d = b.Var_marge_relative * sign b.Var_marge_relative
    if       c > d then return -1
    else if  c < d  then return 1
    return 0

window.clic_var_rel = (a,b) ->
    c = a.Var_clic_relative * sign a.Var_clic_relative
    d = b.Var_clic_relative * sign b.Var_clic_relative
    if       c > d then return -1
    else if  c < d  then return 1
    return 0
