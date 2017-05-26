#  progress bar  en service
#  mise en factory le 18-03-2016

MA = window.angular.module('app_mrc')

#                                                   _
#                                                  | |
#   ____   ____ ___   ____  ____ _____  ___  ___   | |__  _____  ____
#  |  _ \ / ___) _ \ / _  |/ ___) ___ |/___)/___)  |  _ \(____ |/ ___)
#  | |_| | |  | |_| ( (_| | |   | ____|___ |___ |  | |_) ) ___ | |
#  |  __/|_|   \___/ \___ |_|   |_____|___/(___/   |____/\_____|_|
#  |_|              (_____|
#

# body...

class Progress_bar_2

    #delay est le temps à attendre
    #order est une éventuelle schaine d'arrêt
    constructor : (delay, order='' ) -> # progression statut
        #interface
          @show     = false
          @top_init = 0
          @delay    = delay
          @order    = order # a string order to shut off the pgs bar
          @remain   = 0
          @interval = 1000

    # re-init grogress_bar
    reset: (delay,order) =>
        @delay   = delay
        @order   = order
        clearInterval @timer
        @start()

    stop :()    =>
        #console.log "delay: #{@delay} -- order: #{@order}"
        @show =false
        @remain = @top_init = 0
        @order  ='no order at all'
        clearInterval @timer
        #@info 'IN stop'

    start :()     =>
        @show     = true
        @top_init = new Date().getTime()
        @timer    = setInterval @on_off, @interval
        #@info 'IN start'

    # stop if string order's given
    hide :(ord)=>
        if (ord is @order) and @show then  @stop()
        #@info 'IN hide'

    # determine if time's over
    on_off: ()  =>
        dte= new Date().getTime()
        dt=(dte- @top_init)
        @remain = Math.round(dt/@delay*100)
        @show   =   (dt < @delay) # msec

        if not @show then  @stop() # else console.log 'go on'

    info : (x)-> console.log  "progress_bar2 - #{x} - remain:#{@remain} - order: #{@order} - show: #{@show} - delay:#{@delay}- interval : #{@interval}"

MA.pgs_bar2 = new Progress_bar_2(45000,'pie')

#-------------------
#  INUTILE
#-------------------
#class MA.Cursor_handling
#
#    constructor : (cls) -> # progression statut
#        @crs_cls=cls #'cursor_auto'
#        @top_init = 0
#        @laps = 0
#        @order    = 'no order' # a string order to shut off the pgs bar
#        @interval = 1000
#
#    wt : (order, laps = 5000) -> # wait and order back 'll return to pointer stop anywhere at demay ms
#        @top_init = new Date().getTime() #init
#        @order = order
#        @laps  = laps
#        @timer = setInterval @on_off, @interval
#        return 'cursor_wait'
#
#    info : (x)=> console.log "cursor : #{x} : class: #{@crs_cls} - laps:#{@laps} - order: #{@order} - interval : #{@interval}"
#
#    on_off : =>
#        attend = (new Date().getTime() - @top_init)< @laps
#        @info ('on_off')
#        console.log (new Date().getTime() - @top_init)
#
#        if attend then @crs_cls='cursor_wait' else @crs_cls='cursor_auto'
#
#


#                                _
#   ___  __ ___   _____ _ __ ___| |___
#  / __|/ _` \ \ / / _ \ '__/ __| / __|
#  \__ \ (_| |\ V /  __/ | | (__| \__ \
#  |___/\__,_| \_/ \___|_|(_)___|_|___/


class Db_saver

  constructor:()->
      @map =[]
      @main_base = []

# store base bs of map mp in @main_base
# angular cpy is used
  push: (mp,bs) =>
      @confirm_date mp
      i = @exists mp
      if i>-1 then console.log 'no saving' ; return  #db is saved yet
      if mp.dt1>mp.dt2 then [mp.dt1,mp.dt2] = [mp.dt2,mp.dt1]
      @map.push angular.copy mp
      @main_base.push angular.copy bs
      return

# répond true l'index de l'élément la base de map mp existe
# sinon répond -1
# les dates doivent-être au format string du type "2016-01-03T00:00:00.000Z"
  exists:(mp) =>
      @confirm_date mp
      i=-1
      for m in @map
        i++ #; console.log mp.name, m.name
        existing = (mp.name is m.name)  and (mp.famille is m.famille)  and (mp.dt1 is m.dt1)  and (mp.dt2 is m.dt2)
        if  existing then  return i
      return -1

  existe:(mp) -> @exists(mp)>-1

# renvoi l'élémént de la base @main_base ayant la map mp
  get:(mp) =>
      @confirm_date mp
      i = @exists(mp)
      if i>=0 then return @main_base[i]
      #if  (mp.name is m.name) and (mp.famille is m.famille) then return @main_base[i]
      return  undefined # la bd n'existe pas

# retire l'élément de la base @main_base ayant la map mp
# retourne -1 si erreur sinon l'index initial de l'élément retiré
  delete: (mp)->
      @confirm_date mp
      i = @exists mp
      if i>=0
          @main_base.splice i, 1
          @map.splice i, 1
          return i
      else -1 # la bd n'existe pas

  confirm_date: (m)=>
        m.dt1=''+m.dt1 # only for casting
        m.dt2=''+m.dt2
        if m.dt1>m.dt2 then [m.dt1,m.dt2] = [m.dt2,m.dt1] # ascending always


MA.dbs=new Db_saver()


