// Generated by CoffeeScript 1.10.0
(function() {
  var Db_saver, MA, Progress_bar_2,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  MA = window.angular.module('app_mrc');

  Progress_bar_2 = (function() {
    function Progress_bar_2(delay, order) {
      if (order == null) {
        order = '';
      }
      this.on_off = bind(this.on_off, this);
      this.hide = bind(this.hide, this);
      this.start = bind(this.start, this);
      this.stop = bind(this.stop, this);
      this.reset = bind(this.reset, this);
      this.show = false;
      this.top_init = 0;
      this.delay = delay;
      this.order = order;
      this.remain = 0;
      this.interval = 1000;
    }

    Progress_bar_2.prototype.reset = function(delay, order) {
      this.delay = delay;
      this.order = order;
      clearInterval(this.timer);
      return this.start();
    };

    Progress_bar_2.prototype.stop = function() {
      this.show = false;
      this.remain = this.top_init = 0;
      this.order = 'no order at all';
      return clearInterval(this.timer);
    };

    Progress_bar_2.prototype.start = function() {
      this.show = true;
      this.top_init = new Date().getTime();
      return this.timer = setInterval(this.on_off, this.interval);
    };

    Progress_bar_2.prototype.hide = function(ord) {
      if ((ord === this.order) && this.show) {
        return this.stop();
      }
    };

    Progress_bar_2.prototype.on_off = function() {
      var dt, dte;
      dte = new Date().getTime();
      dt = dte - this.top_init;
      this.remain = Math.round(dt / this.delay * 100);
      this.show = dt < this.delay;
      if (!this.show) {
        return this.stop();
      }
    };

    Progress_bar_2.prototype.info = function(x) {
      return console.log("progress_bar2 - " + x + " - remain:" + this.remain + " - order: " + this.order + " - show: " + this.show + " - delay:" + this.delay + "- interval : " + this.interval);
    };

    return Progress_bar_2;

  })();

  MA.pgs_bar2 = new Progress_bar_2(45000, 'pie');

  Db_saver = (function() {
    function Db_saver() {
      this.confirm_date = bind(this.confirm_date, this);
      this.get = bind(this.get, this);
      this.exists = bind(this.exists, this);
      this.push = bind(this.push, this);
      this.map = [];
      this.main_base = [];
    }

    Db_saver.prototype.push = function(mp, bs) {
      var i, ref;
      this.confirm_date(mp);
      i = this.exists(mp);
      if (i > -1) {
        console.log('no saving');
        return;
      }
      if (mp.dt1 > mp.dt2) {
        ref = [mp.dt2, mp.dt1], mp.dt1 = ref[0], mp.dt2 = ref[1];
      }
      this.map.push(angular.copy(mp));
      this.main_base.push(angular.copy(bs));
    };

    Db_saver.prototype.exists = function(mp) {
      var existing, i, j, len, m, ref;
      this.confirm_date(mp);
      i = -1;
      ref = this.map;
      for (j = 0, len = ref.length; j < len; j++) {
        m = ref[j];
        i++;
        existing = (mp.name === m.name) && (mp.famille === m.famille) && (mp.dt1 === m.dt1) && (mp.dt2 === m.dt2);
        if (existing) {
          return i;
        }
      }
      return -1;
    };

    Db_saver.prototype.existe = function(mp) {
      return this.exists(mp) > -1;
    };

    Db_saver.prototype.get = function(mp) {
      var i;
      this.confirm_date(mp);
      i = this.exists(mp);
      if (i >= 0) {
        return this.main_base[i];
      }
      return void 0;
    };

    Db_saver.prototype["delete"] = function(mp) {
      var i;
      this.confirm_date(mp);
      i = this.exists(mp);
      if (i >= 0) {
        this.main_base.splice(i, 1);
        this.map.splice(i, 1);
        return i;
      } else {
        return -1;
      }
    };

    Db_saver.prototype.confirm_date = function(m) {
      var ref;
      m.dt1 = '' + m.dt1;
      m.dt2 = '' + m.dt2;
      if (m.dt1 > m.dt2) {
        return ref = [m.dt2, m.dt1], m.dt1 = ref[0], m.dt2 = ref[1], ref;
      }
    };

    return Db_saver;

  })();

  MA.dbs = new Db_saver();

}).call(this);

//# sourceMappingURL=08_progress_bar.js.map
