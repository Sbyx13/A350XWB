
## Lights ##

strobe_switch = props.globals.getNode("controls/switches/strobe", 1);
var beacon = aircraft.light.new( "/sim/model/lights/beacon", [0.05, 1.2,], "/controls/lighting/beacon" );
beacon_switch = props.globals.getNode("controls/lighting/beacon", 1);
var strobe = aircraft.light.new( "/sim/model/lights/strobe", [0.01, 3,], "/controls/lighting/strobe" );

## GEAR
#######

# prevent retraction of the landing gear when any of the wheels are compressed
setlistener("controls/gear/gear-down", func
 {
 var down = props.globals.getNode("controls/gear/gear-down").getBoolValue();
 if (!down and (getprop("gear/gear[0]/wow") or getprop("gear/gear[1]/wow") or getprop("gear/gear[2]/wow")))
  {
  props.globals.getNode("controls/gear/gear-down").setBoolValue(1);
  }
 });
 
setlistener("/sim/signals/fdm-initialized", func {	
  	itaf.ap_init();			
	var autopilot = gui.Dialog.new("sim/gui/dialogs/autopilot/dialog", "Aircraft/A350XWB/Systems/autopilot-dlg.xml");
	setprop("/it-autoflight/settings/retard-enable", 1);  # Enable or disable automatic autothrottle retard.
	setprop("/it-autoflight/settings/retard-ft", 20);     # Add this to change the retard altitude, default is 50ft AGL.
	setprop("/it-autoflight/settings/land-flap", 0.645);  # Define the landing flaps here. This is needed for autoland, and retard.
	setprop("/it-autoflight/settings/land-enable", 0);    # Enable or disable automatic landing.
});