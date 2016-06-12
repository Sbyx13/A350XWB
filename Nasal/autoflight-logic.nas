# IT AUTOFLIGHT Logic by Joshua Davidson (it0uchpods/411).
# V2.8

var ap_logic_init = func {
	setprop("/controls/it2/ap_master", 0);
	setprop("/controls/it2/at_master", 0);
	setprop("/controls/it2/hdg", 1);
	setprop("/controls/it2/nav", 0);
	setprop("/controls/it2/loc", 0);
	setprop("/controls/it2/loc1", 0);
	setprop("/controls/it2/alt", 0);
	setprop("/controls/it2/vs", 0);
	setprop("/controls/it2/app", 0);
	setprop("/controls/it2/app1", 0);
	setprop("/controls/it2/aplatmode", 0);
	setprop("/controls/it2/aphldtrk", 0);
	setprop("/controls/it2/apvertmode", 3);
	setprop("/controls/it2/aphldtrk2", 0);
	setprop("/controls/it2/apoffsound", 1);
	setprop("/controls/it2/ias", 1);
	setprop("/controls/it2/mach", 0);
	setprop("/controls/it2/apthrmode", 0);
	print("AUTOFLIGHT LOGIC ... FINE!");
}

# AP Master System
setlistener("/controls/it2/ap_mastersw", func {
  var apmas = getprop("/controls/it2/ap_mastersw");
  if (apmas == 0) {
	setprop("/controls/it2/ap_master", 0);
    ap_off();
  } else if (apmas == 1) {
	setprop("/controls/it2/ap_master", 1);
	setprop("/controls/it2/apoffsound", 0);
    ap_refresh();
  }
});

# AT Master System
setlistener("/controls/it2/at_mastersw", func {
  var atmas = getprop("/controls/it2/at_mastersw");
  if (atmas == 0) {
	setprop("/controls/it2/at_master", 0);
    at_off();
  } else if (atmas == 1) {
	setprop("/controls/it2/at_master", 1);
    at_refresh();
  }
});

# Master Lateral
setlistener("/controls/it2/aplatset", func {
  var latset = getprop("/controls/it2/aplatset");
  if (latset == 0) {
	setprop("/controls/it2/hdg", 1);
	setprop("/controls/it2/nav", 0);
	setprop("/controls/it2/loc", 0);
	setprop("/controls/it2/loc1", 0);
	setprop("/controls/it2/app", 0);
	setprop("/controls/it2/app1", 0);
	setprop("/controls/it2/aplatmode", 0);
	setprop("/controls/it2/aphldtrk", 0);
    hdg_master();
  } else if (latset == 1) {
	setprop("/controls/it2/hdg", 0);
	setprop("/controls/it2/nav", 1);
	setprop("/controls/it2/loc", 0);
	setprop("/controls/it2/loc1", 0);
	setprop("/controls/it2/app", 0);
	setprop("/controls/it2/app1", 0);
	setprop("/controls/it2/aplatmode", 1);
	setprop("/controls/it2/aphldtrk", 1);
    nav_master();
  } else if (latset == 2) {
	setprop("/instrumentation/nav/signal-quality-norm", 0);
	setprop("/controls/it2/hdg", 0);
	setprop("/controls/it2/nav", 0);
	setprop("/controls/it2/loc", 1);
	setprop("/controls/it2/loc1", 1);
	setprop("/controls/it2/apilsmode", 0);
  }
});

# Master Vertical
setlistener("/controls/it2/apvertset", func {
  var vertset = getprop("/controls/it2/apvertset");
  if (vertset == 0) {
	setprop("/controls/it2/alt", 1);
	setprop("/controls/it2/vs", 0);
	setprop("/controls/it2/app", 0);
	setprop("/controls/it2/app1", 0);
	setprop("/controls/it2/altc", 0);
	setprop("/controls/it2/flch", 0);
	setprop("/controls/it2/apvertmode", 0);
	setprop("/controls/it2/aphldtrk2", 0);
	setprop("/controls/it2/apilsmode", 0);
    var altnow = int((getprop("/instrumentation/altimeter/indicated-altitude-ft")+50)/100)*100;
	setprop("/autopilot/settings/target-altitude-ft", altnow);
    alt_master();
  } else if (vertset == 1) {
	setprop("/controls/it2/alt", 0);
	setprop("/controls/it2/vs", 1);
	setprop("/controls/it2/app", 0);
	setprop("/controls/it2/app1", 0);
	setprop("/controls/it2/altc", 0);
	setprop("/controls/it2/flch", 0);
	setprop("/controls/it2/apvertmode", 1);
	setprop("/controls/it2/aphldtrk2", 0);
	setprop("/controls/it2/apilsmode", 0);
    vs_master();
  } else if (vertset == 2) {
	setprop("/instrumentation/nav/signal-quality-norm", 0);
	setprop("/controls/it2/hdg", 0);
	setprop("/controls/it2/nav", 0);
	setprop("/controls/it2/loc", 1);
	setprop("/controls/it2/loc1", 1);
	setprop("/instrumentation/nav/gs-rate-of-climb", 0);
	setprop("/controls/it2/alt", 0);
	setprop("/controls/it2/vs", 0);
	setprop("/controls/it2/app", 1);
	setprop("/controls/it2/app1", 1);
	setprop("/controls/it2/altc", 0);
	setprop("/controls/it2/flch", 0);
	setprop("/controls/it2/apilsmode", 1);
  } else if (vertset == 3) {
	setprop("/controls/it2/alt", 0);
	setprop("/controls/it2/vs", 0);
	setprop("/controls/it2/altc", 1);
	setprop("/controls/it2/flch", 0);
	setprop("/controls/it2/apvertmode", 0);
	setprop("/controls/it2/aphldtrk2", 0);
    altcap_master();
  }
});

# Master Thrust
setlistener("/controls/it2/apthrset", func {
  var thrset = getprop("/controls/it2/apthrset");
  if (thrset == 0) {
	setprop("/controls/it2/ias", 1);
	setprop("/controls/it2/mach", 0);
	setprop("/controls/it2/apthrmode", 0);
    ias_master();
  } else if (thrset == 1) {
	setprop("/controls/it2/ias", 0);
	setprop("/controls/it2/mach", 1);
	setprop("/controls/it2/apthrmode", 1);
    mach_master();
  }
});

# Capture Logic
setlistener("/controls/it2/apvertmode", func {
  var vertm = getprop("/controls/it2/apvertmode");
	if (vertm == 1) {
      altcaptt.start();
    } else {
	  altcaptt.stop();
    }
});

var altcapt = func {
  var calt = getprop("/instrumentation/altimeter/indicated-altitude-ft");
  var alt = getprop("/autopilot/settings/target-altitude-ft");
  var dif = calt - alt;
  if (dif < 500 and dif > -500) {
  setprop("/controls/it2/apvertset", 3);
  }
}

# Timers
var altcaptt = maketimer(0.5, altcapt);