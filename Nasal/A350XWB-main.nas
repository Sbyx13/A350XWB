#======
# INIT
#======

A350XWBMain = {};

A350XWBMain.new = func {
  var obj = { parents : [A350XWBMain]
  };
  
  obj.init();
  
  return obj;
}

#======
# CRON
#======

A350XWBMain.fastcron = func {
  #fast code runs in here (EICAS)
  EICAS.schedule();
  # schedule the next call
  settimer(func { me.fastcron(); },0.1);
}

A350XWBMain.slowcron = func {
  #1 second code runs in here

  # schedule the next call
  settimer(func { me.slowcron(); },1);
}

#=============
# START NASAL
#=============

A350XWBMain.init = func {
  #Draw the eicas
  EICAS.startcanvas();
  
  #Start the cron timers
  settimer(func { me.fastcron(); },0);
  settimer(func { me.slowcron(); },0);
  
  print('A350XWB Systems started');
}

A350XWBMain.reinit = func {
  #Add reinit functions in here
  
  print('A350XWB Systems restarted');  
}

A350XWBListener1 = setlistener("/sim/signals/fdm-initialized", func { globals.A350XWB.main = A350XWBMain.new(); removelistener(A350XWBListener1); });
A350XWBListener2 = setlistener("/sim/signals/reinit", func { globals.A350XWB.main.reinit(); });