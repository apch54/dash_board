###
  ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
  couleurs des courbes
  le 02-04-2016
  ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
###
#                             ___                         ___
#                            /\_ \                      /'___\
#         ___    ___   __  __\//\ \         ___    ___ /\ \__/
#        /'___\ / __`\/\ \/\ \ \ \ \       /'___\ / __`\ \ ,__\
#       /\ \__//\ \L\ \ \ \_\ \ \_\ \_  __/\ \__//\ \L\ \ \ \_/
#       \ \____\ \____/\ \____/ /\____\/\_\ \____\ \____/\ \_\
#        \/____/\/___/  \/___/  \/____/\/_/\/____/\/___/  \/_/
#

#$wg = window.angular.module('app_graph')
MA= window.angular.module('app_mrc')

MA.pie_colors = [
    '#ff0333'   # rouge         0     sous la droite des dates
    '#03ff33'   # vert              clics
    '#0333ff'   # bleu
    '#fffc03'   # jaune
    '#ff0033'   # fushia
    '#888888'   # gris          5

    # foncé

    '#bf0000'   # rouge         6
    '#00bf00'   # vert
    '#0000bf'   # bleu
    '#fffc03'   # jaune d'or    9
    '#9900bf'   # violet
    '#ff6600'   # orange
    '#333333'   # noir          12

  # clair

    '#ff9999'   # rose          13
    '#99ff99'   # vert
    '#99ccff'   # bleu
    '#ffff99'   # jaune
    '#cc66ff'   # violet
    '#cccccc'   # gris          18

    # divers :aires

    '#ffcc99'   # orange pâle   19
    '#ffbfbf'   # rouge päle
    '#ccffff'   # tuquoise pâle
    '#ffff99'   # jaune pâle
    '#bfbfff'   # bleu pale
    '#bfff99'   # vert pale
    '#e6ccff'   # violet pale    25

]

# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨¨~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Couleurs des tableaux
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

MA.coul = (min, max, val, rouge = 'red', orange = 'darkorchid', vert = 'seagreen')->
    if val <= min
        rslt = "color : #{rouge}; font-weight: bold;" # ce sont des référence au css
    else if val >= max
        rslt = "color : #{vert};font-weight: bold;" # idem
    else
        rslt = "color : #{orange};font-weight: bold;" # idem

    rslt

MA.coul_2 = (min, max, val, rouge = 'red', orange = 'darkorchid', vert = 'seagreen')->

    if val      <= min   then    rslt = "nb_rouge"  # ce sont des référence au css
    else if val >= max   then    rslt = "nb_vert"   # idem
    else                         rslt = "nb_orange" # idem

    rslt
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨¨~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

