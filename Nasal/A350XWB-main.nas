#======
# INIT
#======

A350XWBMain = {};

A350XWBMain.new = func {
  var obj = {
    parents : [A350XWBMain],
  };
  
  obj.init();
  
  return obj;
}

#======
# CRON
#======

A350XWBMain.fastcron = func {
  #fast code runs in here (EICAS)
  eicassystem.schedule();
  # schedule the next call
  settimer(func { me.fastcron(); },0.1);
}

A350XWBMain.slowcron = func {
  #1 second code runs in here
  enginesystem.schedule();
  # schedule the next call
  settimer(func { me.slowcron(); },1);
}

#=============
# START NASAL
#=============
A350XWBMain.loadscripts = func {
  globals.A350XWB.enginesystem = A350XWB.Engines.new();
  globals.A350XWB.eicassystem = A350XWB.EICAS.new();
}

A350XWBMain.init = func {
  #This is here so the reinit only runs once instead of twice
  me.loadscripts();
  
  #Start the cron timers
  settimer(func { me.fastcron(); },0);
  settimer(func { me.slowcron(); },0);
  
  print('A350XWB Systems started');
}

A350XWBMain.reinit = func {
  #This is here so the reinit only runs once instead of twice
  if ( getprop("/sim/signals/reinit") ) {
    #Add reinit functions in here
    print('A350XWB Systems restarted');
  }
}

A350XWBListener1 = setlistener("/sim/signals/fdm-initialized", func { globals.A350XWB.main = A350XWBMain.new(); removelistener(A350XWBListener1); });
A350XWBListener2 = setlistener("/sim/signals/reinit", func { globals.A350XWB.main.reinit(); });

setlistener("controls/lighting/landing-light",
  func {
    if(getprop("controls/lighting/landing-light")) setprop("controls/lighting/landing-lights-norm",1); else setprop("controls/lighting/landing-lights-norm",0);
  }
);