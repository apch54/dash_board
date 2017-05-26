# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~
# Module outils
# créé le2016-01-29
# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~
MA= window.angular.module('app_mrc')
#$tls = $wa.tools = []

top_init =new Date()

MA.wait_ms = (ms) -># waiting for ms in milli sec
    #show ' in wait',"ctl du 02 js graph"
    top  = new Date()
    laps = new Date()
    while laps - top  < ms
      laps = new Date()
      #show laps-top , 'wait'

temps= () ->
  elt =   new Date()- top_init
  s = Math.floor elt / 1000
  ms = elt - 1000*s
  return ms.toString()+' ms' if s is 0
  s.toString() + 's '+ms + ' ms'

MA.shw =  (x, in_fle) ->
    if present_file? then in_fle= present_file
    blue  = "color : #0333ff;"
    black = "color : #000000;"
    bgg   = "background-color: #e6ffe6;"
    t= temps()
    top = typeof x

    if top is 'object'
        if not in_fle?
                console.log "%c #{t}"          ,blue  ; console.log x
        else    console.log "%c #{t} - in [#{in_fle}] -", blue ; console.log x, blue
    else
        if not in_fle?
                console.log "%c #{t} -[#{top}] - %c #{x}" ,blue, bgg
         else   console.log "%c #{t} - in [#{in_fle}] -[#{top}]-  %c #{x} ", blue,bgg

MA.shws= (first... ,in_file)->
    for f in first then MA.shw(f,in_file)

MA.show_err =  (mess, e) ->   console.warn  mess, present_file + 'erreur : '+e + ': traitée'

MA.wait_ms = (ms) -># waiting for ms in milli sec
    #show ' in wait',"ctl du 02 js graph"
    top  = new Date()
    laps = new Date()
    while laps - top  < ms
        laps = new Date()

# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~
# Module Global
# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~

#window.maf = ()->  console.log 'tt2'

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~
# Modifie la classe Number
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~


window.is_infinite = (n)->
    n is Number.NEGATIVE_INFINITY  or n is Number.POSITIVE_INFINITY

    # classical toFixed + don't display infinity or NaN
    # Plus_on_off display '+' if on


window.Number::format = (t = 0,plus_on_off= on) ->
    val = @valueOf()
    rtn = val.toFixed(t)
    return '' if (val>1e300) or (val<-1e300) or isNaN(val)
    rtn.toLocaleString()
    rtn ='+' + rtn if val >0 and plus_on_off
    rtn

window.Number::hide_infinity = () -># pas utilisée encore
    if is_infinite @valueof()  then return '' else return @valueof()


# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# retrouve les param url de la ligne de commande
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
window.date_to_string = (d) ->
    new Date(new Date(d).getTime() - ( new Date().getTimezoneOffset() * 60 * 1000)).toISOString().slice 0, 10 #

window.get_url_param = (param = 'parametre') ->     # http://mon.ur.l?x=2&parametre=p&y=3
    url = window.location.href                      # on retrouve l'url
    param = param.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")

    #recherche par regex de param
    regexS = "[\\?&]" + param + "=([^&#]*)"         # recherche par reg-ex
    regex = new RegExp(regexS)
    results = regex.exec(url)                       # s'il existe , il est ici
    #show url

    if results?                                     # on enlève les caractères parasites
        results[1] = results[1].replace c, ""   for c in  ["\\", "/"]
        return results[1]
    else return null                                # si pas de param

window.wait_ms = (ms) -># waiting for ms in milli sec
    #show ' in wait',"ctl du 02 js graph"
    top  = new Date()
    laps = new Date()
    while laps - top  < ms
        laps = new Date()
        #show laps-top , 'wait'

