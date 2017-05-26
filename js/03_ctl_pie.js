// Generated by CoffeeScript 1.12.6

/* maj 2017-05-26 by fc */

(function() {
  window.angular.module('app_mrc').controller("ctl_graph_pie", function($scope, $http, $rootScope, $timeout) {
    var $$, ajx_fl, chart_pie_campagnes, chart_pie_jeux, chart_pie_regies, copy_by_val, def_pie, dte_last_report, emit_higher, fill_bds, gestion_err_camp, handleRender, handle_bd_camp, handle_bd_graph, pie_colors, redraw_graphs, smart_name_campaigns, sort_by_marge, tri;
    $$ = $scope;
    ajx_fl = "php/11_bd_graph.php";
    $$.bd_graph_jeux = [];
    $$.bd_graph_regies = [];
    $$.bd_graph_campaign_saved = $$.bd_graph_campagnes = [];
    $$.bd_camp_neg = [];
    $$.bd_camp_small = [];
    $$.niveau_petites_camp = 5;
    chart_pie_jeux = chart_pie_regies = chart_pie_campagnes = false;
    $$.rdio_dv = 'v';
    $$.titre1 = '[dv]';
    $$.but = 'jeux_regies_et_camp';
    $$.show_bse_m = false;
    $$.TimeOffset = new Date().getTimezoneOffset() * 60 * 1000;
    pie_colors = $$.pie_colors;
    $$.date_0 = $$.date_2 = window.top.date_0;
    dte_last_report = function() {
      return new Date(new Date($$.dddr).getTime() + 1 * $$.TimeOffset);
    };
    AmCharts.loadJSON = function(url, but, v_ou_p, date1, date2) {
      var error, regies_jeux_et_camp_bd, request;
      if (but == null) {
        but = 'jeux';
      }
      if (v_ou_p == null) {
        v_ou_p = 'v';
      }
      if (window.XMLHttpRequest) {
        request = new XMLHttpRequest();
      } else {
        request = new ActiveXObject("Microsoft.XMLHTTP");
      }
      request.open("POST", url, false);
      request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      request.send("but=" + but + '&v_ou_p=' + v_ou_p + "&date_1=" + date1 + "&date_2=" + date2);
      regies_jeux_et_camp_bd = JSON.parse(request.responseText);
      try {
        smart_name_campaigns(regies_jeux_et_camp_bd);
        sort_by_marge(regies_jeux_et_camp_bd);
        fill_bds(regies_jeux_et_camp_bd);
        $$.bd_graph_jeux = handle_bd_graph($$.bd_graph_jeux, 'jeux');
        $$.bd_graph_regies = handle_bd_graph($$.bd_graph_regies, 'regies');
        return $$.bd_graph_campagnes = handle_bd_camp($$.bd_graph_campagnes, 'camp', $$.niveau_petites_camp);
      } catch (error1) {
        error = error1;
        return console.log(error + '. in ctl pies : db empty --> (fc)');
      }
    };
    copy_by_val = function(bd) {
      var i, len, t, y;
      t = [];
      for (i = 0, len = bd.length; i < len; i++) {
        y = bd[i];
        t.push({
          Date: y.Date,
          Name: y.Name,
          Category: y.Category,
          Marge: y.Marge
        });
      }
      return t;
    };
    tri = function(a, b) {
      return parseFloat(a.Marge) - parseFloat(b.Marge);
    };
    sort_by_marge = function(array) {
      return array.sort = function(a, b) {
        if (a.Marge < b.Marge) {
          return -1;
        } else if (a.Marge > b.Marge) {
          return 1;
        } else {
          return 0;
        }
      };
    };
    fill_bds = function(bd) {
      var cat, i, len, results, y;
      $$.bd_graph_campagnes = [];
      $$.bd_graph_regies = [];
      $$.bd_graph_jeux = [];
      $$.bd_graph_campaign_saved = [];
      results = [];
      for (i = 0, len = bd.length; i < len; i++) {
        y = bd[i];
        cat = y.Category;
        switch (cat) {
          case "jeux":
            results.push($$.bd_graph_jeux.push({
              Date: y.Date,
              Name: y.Name,
              Category: y.Category,
              Marge: y.Marge
            }));
            break;
          case "regies":
            results.push($$.bd_graph_regies.push({
              Date: y.Date,
              Name: y.Name,
              Category: y.Category,
              Marge: y.Marge
            }));
            break;
          case "camp":
            $$.bd_graph_campagnes.push({
              Date: y.Date,
              Name: y.Name,
              Category: y.Category,
              Marge: y.Marge,
              Cout: y.Cout
            });
            results.push($$.bd_graph_campaign_saved.push({
              Date: y.Date,
              Name: y.Name,
              Category: y.Category,
              Marge: y.Marge,
              Cout: y.Cout
            }));
            break;
          default:
            results.push(void 0);
        }
      }
      return results;
    };
    smart_name_campaigns = function(bdc) {
      var cp, i, j, jx, len, len1, narr, ref, results, rg, y, z;
      results = [];
      for (i = 0, len = bdc.length; i < len; i++) {
        y = bdc[i];
        if (!(y.Category === 'camp')) {
          continue;
        }
        narr = y.Name.split('~');
        if (narr[1] != null) {
          rg = narr[1];
        } else {
          rg = 'regie name error';
        }
        if (narr[2] != null) {
          cp = narr[2];
        } else {
          cp = 'campaign name error';
        }
        if (narr[3] != null) {
          jx = narr[3];
        } else {
          jx = 'game name error';
        }
        ref = ['WW, excluding live countries', 'Global', 'www'];
        for (j = 0, len1 = ref.length; j < len1; j++) {
          z = ref[j];
          if (cp.lastIndexOf(z) > 0) {
            cp = 'www';
          }
        }
        if (cp.lastIndexOf('(') >= 0) {
          cp = cp.slice(cp.lastIndexOf("(") + 1, cp.lastIndexOf(")"));
        } else if (cp.lastIndexOf('premium') >= 0) {
          cp = 'Premium';
        } else if (cp.lastIndexOf('KITTY - ') >= 0) {
          cp = 'www';
        }
        cp = " [" + cp + "] ";
        results.push(y.Name = rg + cp + jx);
      }
      return results;
    };
    handle_bd_camp = function(bd, fld, small_level) {
      var arr, i, j, k, len, len1, len2, min, name_neg, ref, tot, val_neg, val_small, x;
      if (bd == null) {
        bd = $$.bd_graph_campagnes;
      }
      if (fld == null) {
        fld = 'camp';
      }
      if (small_level == null) {
        small_level = 2;
      }
      val_neg = 0;
      name_neg = 'Marge < 0 ';
      val_small = 0;
      $$.small_name = "0<= Marge < " + small_level + "% ";
      tot = 0;
      $$.bd_camp_neg = [];
      $$.bd_camp_small = [];
      arr = [];
      for (i = 0, len = bd.length; i < len; i++) {
        x = bd[i];
        x.Marge = parseFloat(x.Marge);
        x.Cout = parseFloat(x.Cout);
        if (x.Marge < 0) {
          val_neg += x.Marge;
          $$.bd_camp_neg.push({
            Name: x.Name,
            Marge: x.Marge,
            pourCent: x.Marge / tot * 100,
            Renta: x.Marge / x.Cout * 1.2
          });
        }
        tot += x.Marge;
        min = small_level * tot / 100;
      }
      for (j = 0, len1 = bd.length; j < len1; j++) {
        x = bd[j];
        if ((0 < (ref = x.Marge) && ref < min)) {
          val_small += x.Marge;
          $$.bd_camp_small.push({
            Name: x.Name,
            Marge: x.Marge,
            pourCent: x.Marge / tot * 100,
            Renta: -x.Marge / x.Cout * 1.2
          });
        }
      }
      if (val_neg !== 0) {
        val_neg *= -1;
      }
      arr.push({
        'Date': '2015-07-28',
        'Category': fld,
        'Name': name_neg,
        'Marge': val_neg.toFixed(2)
      });
      arr.push({
        'Date': '2015-07-28',
        'Category': fld,
        'Name': $$.small_name,
        'Marge': val_small.toFixed(2)
      });
      for (k = 0, len2 = bd.length; k < len2; k++) {
        x = bd[k];
        if (x.Marge > min) {
          arr.push(x);
        }
      }
      return arr;
    };
    handle_bd_graph = function(bd, fld) {
      var arr, i, j, len, len1, val_Name, val_neg, x;
      if (fld == null) {
        fld = 'jeux';
      }
      val_neg = 0;
      val_Name = 'Negatif ';
      arr = [];
      for (i = 0, len = bd.length; i < len; i++) {
        x = bd[i];
        x.Marge = parseFloat(x.Marge);
        if (parseFloat(x.Marge) < 0) {
          val_neg += x.Marge;
          val_Name += ", " + x.Name;
        }
      }
      if (val_neg !== 0) {
        val_neg *= -1;
      }
      val_neg = val_neg.toFixed(2);
      arr.push({
        'Date': '2015-07-28',
        'Category': fld,
        'Name': val_Name,
        'Marge': val_neg
      });
      for (j = 0, len1 = bd.length; j < len1; j++) {
        x = bd[j];
        if (x.Marge > 0) {
          arr.push(x);
        }
      }
      return arr;
    };
    $$.maj_bd_3 = function() {
      return chart_pie_jeux.dataProvider = AmCharts.loadJSON(ajx_fl, $$.but, $$.rdio_dv, date_to_string($$.date_0), date_to_string($$.date_2));
    };
    handleRender = function(e) {
      var wait_1;
      wait_1 = function() {
        $$.pgs_bar2.hide('pie');
        return $$.$apply();
      };
      return $timeout(wait_1, 2000);
    };
    def_pie = function(bd, max_label_width) {
      if (max_label_width == null) {
        max_label_width = 200;
      }
      return {
        type: "pie",
        listeners: [
          {
            "event": "rendered",
            "method": handleRender
          }
        ],
        angle: 20,
        depth3D: 12,
        innerRadius: "20%",
        radius: 135,
        balloonText: "[[title]]<br> <span style='font-size:12px'><b>[[value]]</b> ([[percents]]%)</span>",
        titleField: "Name",
        valueField: "Marge",
        outlineAlpha: 1,
        outlineColor: "#ffffff",
        outlineThickness: 1,
        allLabels: [],
        labelsEnabled: true,
        maxLabelWidth: max_label_width,
        labelText: "[[title]]",
        labelRadius: 35,
        fontFamily: "tahoma",
        fontSize: 9,
        thousandsSeparator: " ",
        sequencedAnimation: false,
        startDuration: 0,
        colors: pie_colors,
        marginBottom: 0,
        marginTop: 0,
        balloon: {
          "adjustBorderColor": true
        },
        titles: [],
        dataProvider: bd,
        "export": {
          enabled: true,
          fileName: "Dash-Board",
          position: "top-right",
          legend: {
            position: "bottom"
          },
          libs: {
            path: "amc/plugins/export/libs/"
          },
          menu: [
            {
              "class": "export-main",
              menu: [
                {
                  label: "Télécharger une image",
                  menu: ["PNG", "JPG", "PDF"]
                }, {
                  label: "Télécharger les données",
                  menu: ["CSV", "XLSX", "JSON"]
                }, {
                  label: "Imprimer",
                  format: "PRINT"
                }
              ]
            }
          ]
        }
      };
    };
    chart_pie_jeux = AmCharts.makeChart('chart_pie_jeux', def_pie($$.bd_graph_jeux));
    chart_pie_regies = AmCharts.makeChart('chart_pie_regies', def_pie($$.bd_graph_regies));
    chart_pie_campagnes = AmCharts.makeChart('chart_pie_campagnes', def_pie($$.bd_graph_campagnes, 500));
    emit_higher = function() {
      var val_to_emit;
      val_to_emit = {
        date_0: $$.date_0,
        date_2: $$.date_2,
        dte_select: $$.dte_select,
        rdio_dv: $$.rdio_dv
      };
      return $$.$emit('emit_from_pie_to_parent', val_to_emit);
    };
    $$.$on('broadcast_from_parent_to_pie', function(event, args) {
      $$.date_0 = args.date_0;
      $$.date_2 = args.date_2;
      $$.dddr = args.dddr;
      $$.dte_select = args.dte_select;
      $$.rdio_dv = args.rdio_dv;
      $$.show_bse_m = args.show_bse_m;
      if (args.rdio_dv === 'v') {
        $$.titre1 = '[dv]';
      } else if (args.rdio_dv === 'w') {
        $$.titre1 = '[w]';
      } else if (args.rdio_dv === 'o') {
        $$.titre1 = '[o]';
      } else if (args.rdio_dv === 'at') {
        $$.titre1 = '[at]';
      } else if (args.rdio_dv === 'm') {
        $$.titre1 = '[m]';
        $$.rdio_dv = 'm';
      } else if (args.rdio_dv === 'p') {
        $$.titre1 = '[dp]';
      }
      return redraw_graphs();
    });
    gestion_err_camp = function() {};
    redraw_graphs = function() {
      var e;
      try {
        $$.maj_bd_3();
        chart_pie_jeux.dataProvider = $$.bd_graph_jeux;
        chart_pie_jeux.validateData();
        chart_pie_regies.dataProvider = $$.bd_graph_regies;
        chart_pie_regies.validateData();
        chart_pie_campagnes.dataProvider = $$.bd_graph_campagnes;
        return chart_pie_campagnes.validateData();
      } catch (error1) {
        e = error1;
        $$.niveau_petites_camp = 5;
        return $$.change_PC($$.niveau_petites_camp);
      }
    };
    $$.change_PC = function(small_level) {
      var e;
      if (small_level == null) {
        small_level = 2;
      }
      try {
        $$.bd_graph_campagnes = [];
        $$.bd_graph_campagnes = handle_bd_camp($$.bd_graph_campaign_saved, 'camp', small_level);
        chart_pie_campagnes.dataProvider = $$.bd_graph_campagnes;
        return chart_pie_campagnes.validateData();
      } catch (error1) {
        e = error1;
        return console.log("dans change_pc  (03.coffee) : " + e.message);
      }
    };
    $$.change_2_dates = function() {
      $$.dte_select = '';
      emit_higher();
      redraw_graphs();
      return $$.change_scope($$.chk_aff_graph_jeux_regies, 'id_aff_graph_jeux_regies', 180);
    };
    $$.change_D0 = function() {
      $$.dte_select = '';
      emit_higher();
      return redraw_graphs();
    };
    $$.change_D2 = function() {
      $$.dte_select = '';
      emit_higher();
      return redraw_graphs();
    };
    $$.change_dv = function() {
      if ($$.rdio_dv === 'v') {
        $$.titre1 = '[dv]';
      } else if ($$.rdio_dv === 'p') {
        $$.titre1 = '[dp]';
      } else if ($$.rdio_dv === 'w') {
        $$.titre1 = '[w]';
      } else if ($$.rdio_dv === 'm') {
        $$.titre1 = '[m]';
      } else if ($$.rdio_dv === 'o') {
        $$.titre1 = '[o]';
      } else if ($$.rdio_dv === 'at') {
        $$.titre1 = '[at]';
      }
      emit_higher();
      return redraw_graphs();
    };
    $$.change_dte_select = function(dt) {
      var d, hier, j30, j7, today;
      switch (dt) {
        case "j":
          today = new Date($$.dddr);
          $$.date_0 = $$.date_2 = today;
          break;
        case "j-1":
          hier = new Date(new Date($$.dddr).getTime() - 24 * 3600000);
          $$.date_0 = $$.date_2 = hier;
          break;
        case "j7":
          j7 = new Date(new Date($$.dddr).getTime() - 6 * 24 * 3600000);
          $$.date_0 = new Date($$.dddr);
          $$.date_2 = j7;
          break;
        case "j30":
          j30 = new Date(new Date($$.dddr).getTime() - 29 * 24 * 3600000);
          $$.date_0 = new Date($$.dddr);
          $$.date_2 = j30;
          break;
        case "mois":
          $$.date_0 = d = new Date($$.dddr);
          $$.date_2 = new Date(d.getFullYear(), d.getMonth(), 1, 0, 0, 1, 1);
          break;
        case "mois-1":
          d = new Date($$.dddr);
          $$.date_0 = new Date(d.getFullYear(), d.getMonth(), 0, 1, 0, 1, 1);
          $$.date_2 = new Date(d.getFullYear(), d.getMonth() - 1, 1, 1, 0, 1, 1);
          break;
        case "tout":
          $$.date_0 = new Date($$.dddr);
          d = new Date(new Date('2010-01-01').getTime());
          $$.date_2 = d;
      }
      emit_higher();
      return redraw_graphs();
    };
    $$.disp_pie_menu = function() {
      return $$.chk_aff_graph_campagnes || $$.chk_aff_graph_jeux_regies;
    };
  });

}).call(this);

//# sourceMappingURL=03_ctl_pie.js.map