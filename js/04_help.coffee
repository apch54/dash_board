# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~
# créé le 2016-01-27
# Aide en ligne
# M_help dans le controlleur mrc
# _~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~_~~~~~~~~~

window.angular.module('app_mrc').help =

    var_abs:
        content : "Ce tabeau classe par ordre décroissant  les campagnes selon la variation de
            leur marge entre la dernière mise à jour et la période considérée (sélecteur de période: haut droite).\n
            Celle-ci est calculée de la manière suivante : [var €]=[Ce jour]-[moy Mrg].\n On remarquera, à juste titre,
            que le classement est effectué selon la valeur absolue de ces variations."

        title : "Tableau des variations absolues des marges."

    var_abs_clic:
        content : "Ce tabeau pocède de la même logique que le précédent.\n Il classe par ordre décroissant
                les campagnes selon la variation du nombre de clics entre la dernière mise à jour et la
                période considérée (sélecteur de période: haut droite). Celle-ci est calculée de la manière
                suivante : [var nb clics]=[Nb clics ce jour]-[moyNb de clics]. \n On remarquera, à juste titre,
                que le classement est effectué selon la valeur absolue mathématique de ces variations."

        title : "Tableau des variations absolues du nombre de clics."

    var_rel:
          content : "Comme les variations absolues, le tableau des variations relatives compare la variation
            (exprimée en %) des marges des campagnes entre la dernière mise à jour et la période considérée
            (sélecteur de période: haut droite).\n Celle-ci est calculée de la manière suivante :\n
            [var %]=([Ce jour]-[moy Mrg])/[Ce jour].\n On remarquera, à juste titre,
            que le classement est effectué selon la valeur absolue de ces variations."

          title :"Tableau des variations relatives des marges."

    var_rel_clic:
        content : "Ce tableau procède de la même logique que so alter-ego relatif aux marges. \nCelui-ci compare
            la variation (exprimée en %) du nombre de clics des campagnes, entre la dernière mise à jour
            et la période considérée (sélecteur de période: haut droite). Celle-ci est calculée de la
            manière suivante :\n   [var %]=([Nb clics ce jour]-[moy nb clics])/[Nb clics ce jour].\n On remarquera,
            à juste titre,  que le classement est effectué selon la valeur absolue mathématique de ces variations."

        title :"Tableau des variations relatives du nombre de clics."

    bilan:
        content : "Ce tableau permet de comparer la marge globale quotidienne de la base activée (dv, dp...)
            avec la moyenne des marges globales quodidiennes calculées pour les pédiodes définies dans ce tableau.\n
            De manière identique, les nombres de clics totaux sont étudiés. Ces derniers sont exprimés en milliers.  "

        title : "Bilan de la base."

    tableau :
        content :"Ce tableau est une copie fidèle de la base étudiée.\n Seules les erreurs flagrantes
            sont sorties de ce contexte : NaN, infini, etc. Il se veut, par ailleurs, cumulatif et donne une image instatanée
            de la base sur une  période donnée. Il comporte trois filtres et un grand nombres de colonnes peuvent
            faire l'objet de tris.\n  Il est néanmoins recommandé de manipuler ces outils avec clairvoyance au risque
            d'engendrer une opération inconséquente, objet d'erreurs radicales nécessitant un assainissement de ces derniers."

        title : "Table principale."

    levier :
        content :"Ce tableau permet de classer les jeux par marge décroissante.\n Un clic sur un titre permet de modifier
            ce classement.\n  Un clic sur le nom du jeu appelle les campagnes liées à ce jeu : tableau de droite.  "

        title : "Classement des jeux par marge."

    modifs :
        content :"Ce tableau classe les modifications effectuées sur les jeux. \n La période de recherche des modifications
            est la même que celle de la représentation du graph XY ( cases de saisie 'jours' à doite du graph XY).\n
            Les 4 colonnes colorées donnent respectivement la moyenne de la marge en €, le rapport de la moyenne des
            marges  sur la moyenne du nombre de clics ; ces moyennes sont élaborées sur une période de sept jours(7),
            avant et après la date de modification.\n L'évolution des marges consécutives à ces modifications peut
            être visualisée en cliquant sur l'Id de la campagne ; cette action active le graphe XY et le tableau
            principal filtré sur cette campagne."

        title : "Affichage des modificatifs des jeux (CRV)."

    bid :
        content :"Ce tableau présente globalement  les mêmes caractéristiques que celui concernant les modifications
            des jeux  à l'exception près quil concerne, bien entendu, la variation des marges consécutive à celle des BID.\n
            On peut cependant ajouter que lorqu'une visualisation sous forme de courbe XY est demandée, les deux
            tableaux peuvent simultanément être affichés"

        title : "Affichage des modificatifs des BID des jeux."

    menu :
        content :"
            1/  <a href='http://gamisio.com/xyz/?xy=on' target='_blank'> http://gamisio.com/xyz/?xy=on</a> :
                affiche le module xy au lancement du dash-board.\n\n
            2/  <a href='http://gamisio.com/xyz/?parametre=w' target='_blank'> http://gamisio.com/xyz/?parametre=w</a> :
                prend en charge au démarrage la base w.\n\n
            3/  <a href='http://gamisio.com/xyz/?logs=on' target='_blank'> http://gamisio.com/xyz/?logs=on</a> :
                affiche les bases \"brutes\" de chaque module.\n\n
            4/  <a href='http://gamisio.com/xyz/?time=10' target='_blank' > http://gamisio.com/xyz/?time=10</a> :
                affiche le module xy sur 10 jours.\n\n
            5/  <a href='http://gamisio.com/xyz/?bilan=on' target='_blank' > http://gamisio.com/xyz/?bilan=on</a> :
                affiche le la tabledes bilans.\n\n
            Il est possible de combiner plusieurs oprtions :\n
            <a href='http://gamisio.com/xyz/?bilan=on&xy=on' target='_blank' > http://gamisio.com/xyz/?bilan=on&xy=on</a> ;
            peu importe l'ordre.
            "
        title : "Options dépendantes de l'URL."


