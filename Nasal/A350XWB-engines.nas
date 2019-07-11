#======
# INIT
#======

Engines = {};

Engines.new = func {
  var obj = {
    parents : [Engines],
  };
  
  obj.init();
  
  return obj;
}

Engines.init = func {
  me.startengine = {0:0, 1:0};
}

Engines.autostart = func {
  if ( ! getprop('/engines/engine[0]/running') ) {
    me.startengine[0] = 1;
  }
  if ( ! getprop('/engines/engine[1]/running') ) {
    me.startengine[1] = 1;
  }
}

Engines.schedule = func {
  if ( me.startengine[0] ) {
    if ( ! getprop('/engines/engine[0]/starter') ) {
      setprop('/controls/engines/engine[0]/starter', 1);
    }
    if ( getprop('/engines/engine[0]/n2') > 5 ) {
      if ( getprop('/controls/engines/engine[0]/cutoff' ) ) {
        setprop('/controls/engines/engine[0]/cutoff', 0);
      }
    } else {
      if ( ! getprop('/controls/engines/engine[0]/cutoff' ) ) {
        setprop('/controls/engines/engine[0]/cutoff', 1);
      }
    }
    if ( getprop('/engines/engine[0]/n2') >= 60 )  {
      me.startengine[0] = 0;
      setprop('/controls/engines/engine[0]/starter', 0);
    }
  }
  if ( me.startengine[1] ) {
    if ( ! getprop('/engines/engine[1]/starter') ) {
      setprop('/controls/engines/engine[1]/starter', 1);
    }
    if ( getprop('/engines/engine[1]/n2') > 5 ) {
      if ( getprop('/controls/engines/engine[1]/cutoff' ) ) {
        setprop('/controls/engines/engine[1]/cutoff', 0);
      }
    } else {
      if ( ! getprop('/controls/engines/engine[1]/cutoff' ) ) {
        setprop('/controls/engines/engine[1]/cutoff', 1);
      }
    }
    if ( getprop('/engines/engine[1]/n2') >= 60 ) {
      me.startengine[1] = 0;
      setprop('/controls/engine[1]/starter', 0);
    }
  }
}
