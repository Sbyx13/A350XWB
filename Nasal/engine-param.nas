# A350XWB Engine Parameter System by Joshua Davidson (it0uchpods/411), parts from Omega's A380-omega.

setlistener("/sim/signals/fdm-initialized", func {
	setprop("/engines/engine[0]/thr", 0);
	setprop("/engines/engine[1]/thr", 0);
});

setlistener("/engines/engine[0]/n2", func {
	var n2 = getprop("/engines/engine[0]/n2");
	var thr = (n2-58)*(100/42);
	if(thr < 0) {
		thr = 0;
	}
	setprop("/engines/engine[0]/thr", thr);
});

setlistener("/engines/engine[1]/n2", func {
	var n2 = getprop("/engines/engine[1]/n2");
	var thr = (n2-58)*(100/42);
	if(thr < 0) {
		thr = 0;
	}
	setprop("/engines/engine[1]/thr", thr);
});

setlistener("/engines/engine[0]/egt-degf", func {
	setprop("engines/engine[0]/egt-degc", (getprop("engines/engine[0]/egt-degf") - 32) / 1.8);
});

setlistener("/engines/engine[1]/egt-degf", func {
	setprop("engines/engine[1]/egt-degc", (getprop("engines/engine[1]/egt-degf") - 32) / 1.8);
});

setlistener("/fdm/jsbsim/propulsion/engine[0]/reverser-angle-rad", func {
	var rev = getprop("/fdm/jsbsim/propulsion/engine[0]/reverser-angle-rad");
	if (rev >= 5) {
		setprop("/surface-positions/reverser-norm", 1);
	} else {
		setprop("/surface-positions/reverser-norm", 0);		
	}
});

setlistener("/fdm/jsbsim/propulsion/engine[1]/reverser-angle-rad", func {
	var rev = getprop("/fdm/jsbsim/propulsion/engine[1]/reverser-angle-rad");
	if (rev >= 5) {
		setprop("/surface-positions/reverser-norm", 1);
	} else {
		setprop("/surface-positions/reverser-norm", 0);		
	}
});