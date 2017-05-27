# ==============================================================================
# Boeing 747-400 pfd by Gijs de Rooy
# ==============================================================================

var roundToNearest = func(n, m) {
	var x = int(n/m)*m;
	if((math.mod(n,m)) > (m/2))
			x = x + m;
	return x;
}

var pfd_canvas = {};
var pfd_display = {};

var horizon = {};
var markerBeacon = {};
var markerBeaconText = {};
var speedText = {};
var machText = {};
var altText = {};
var selHdgText = {};
var fdX = {};
var fdY = {};
var curAlt1 = {};
var curAlt2 = {};
var curAlt3 = {};
var curAltBox = {};
var curSpd = {};
var curSpdTen = {};
var spdTrend = {};
var spdTrend_scale = {};
var v1 = {};
var vr = {};
var flaps0 = {};
var flaps1 = {};
var flaps5 = {};
var flaps10 = {};
var flaps20 = {};
var minSpdInd = {};
var maxSpdInd = {};
var spdTape = {};
var altTape = {};
var cmdSpd = {};
var dhText = {};
var radioAltInd = {};
var ilsId = {};
var ilsCourse = {};
var dmeDist = {};
var baroSet = {};
var vertSpdText = {};
var tenThousand = {};
var vsiNeedle = {};
var vsPointer = {};
var bankPointer = {};
var touchdownInd = {};
var atMode = {};
var rollMode = {};
var pitchMode = {};
var compass = {};
var risingRwy = {};
var risingRwyPtr = {};
var risingRwyPtr_scale = {};
var locPtr = {};
var locScale = {};
var locScaleExp = {};
var selAltPtr = {};
var gsScale = {};
var gsPtr = {};
var minimums = {};

var canvas_PFD = {
	new: func(canvas_group)
	{
		var m = { parents: [canvas_PFD] };
		var pfd = canvas_group;
		var font_mapper = func(family, weight)
		{
			if( family == "Liberation Sans" and weight == "normal" )
				return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(pfd, "Aircraft/747-400/Models/Cockpit/Instruments/PFD/PFD.svg", {'font-mapper': font_mapper});
		
		horizon = pfd.getElementById("horizon").updateCenter();
		speedText = pfd.getElementById("speedText");
		markerBeacon = pfd.getElementById("markerBeacon");
		markerBeaconText = pfd.getElementById("markerBeaconText");
		machText = pfd.getElementById("machText");
		altText = pfd.getElementById("altText");
		selHdgText = pfd.getElementById("selHdgText");
		selAltPtr = pfd.getElementById("selAltPtr");
		fdX = pfd.getElementById("fdX");
		fdY = pfd.getElementById("fdY");
		curAlt1 = pfd.getElementById("curAlt1");
		curAlt2 = pfd.getElementById("curAlt2");
		curAlt3 = pfd.getElementById("curAlt3");
		vsPointer = pfd.getElementById("vsPointer");
		curAltBox = pfd.getElementById("curAltBox");
		curSpd = pfd.getElementById("curSpd");
		curSpdTen = pfd.getElementById("curSpdTen");
		spdTrend = pfd.getElementById("spdTrend");
		v1 = pfd.getElementById("v1");
		vr = pfd.getElementById("vr");
		dhText = pfd.getElementById("dhText");
		flaps0 = pfd.getElementById("flaps0");
		flaps1 = pfd.getElementById("flaps1");
		flaps5 = pfd.getElementById("flaps5");
		flaps10 = pfd.getElementById("flaps10");
		flaps20 = pfd.getElementById("flaps20");
		minSpdInd = pfd.getElementById("minSpdInd");
		maxSpdInd = pfd.getElementById("maxSpdInd");
		risingRwy = pfd.getElementById("risingRwy");
		risingRwyPtr = pfd.getElementById("risingRwyPtr");
		compass = pfd.getElementById("compass").updateCenter();
		touchdownInd = pfd.getElementById("touchdown");
		spdTape = pfd.getElementById("spdTape");
		altTape = pfd.getElementById("altTape");
		cmdSpd = pfd.getElementById("cmdSpd");
		radioAltInd = pfd.getElementById("radioAltInd");
		ilsId = pfd.getElementById("ilsId");
		ilsCourse = pfd.getElementById("ilsCourse");
		dmeDist = pfd.getElementById("dmeDist");
		baroSet = pfd.getElementById("baroSet");
		vertSpdText = pfd.getElementById("vertSpd");
		tenThousand = pfd.getElementById("tenThousand");
		vsiNeedle = pfd.getElementById("vsiNeedle").updateCenter();
		bankPointer = pfd.getElementById("bankPointer").updateCenter();
		atMode = pfd.getElementById("atMode");
		rollMode = pfd.getElementById("rollMode");
		pitchMode = pfd.getElementById("pitchMode");
		locPtr = pfd.getElementById("locPtr");
		locScale = pfd.getElementById("locScale");
		locScaleExp = pfd.getElementById("locScaleExp");
		gsScale = pfd.getElementById("gsScale");
		gsPtr = pfd.getElementById("gsPtr");
		minimums = pfd.getElementById("minimums");
		
		var c1 = spdTrend.getCenter();
		spdTrend.createTransform().setTranslation(-c1[0], -c1[1]);
		spdTrend_scale = spdTrend.createTransform();
		spdTrend.createTransform().setTranslation(c1[0], c1[1]);
		var c2 = risingRwyPtr.getCenter();
		risingRwyPtr.createTransform().setTranslation(-c2[0], -c2[1]);
		risingRwyPtr_scale = risingRwyPtr.createTransform();
		risingRwyPtr.createTransform().setTranslation(c2[0], c2[1]);
		
		horizon.set("clip", "rect(244, 705, 764, 230)");
		minSpdInd.set("clip", "rect(130, 1024, 896, 0)");
		maxSpdInd.set("clip", "rect(130, 1024, 896, 0)");
		spdTape.set("clip", "rect(130, 1024, 896, 0)");
		altTape.set("clip", "rect(130, 1024, 896, 0)");
		touchdownInd.set("clip", "rect(130, 1024, 896, 0)");
		minimums.set("clip", "rect(130, 1024, 896, 0)");
		cmdSpd.set("clip", "rect(130, 1024, 896, 0)");
		selAltPtr.set("clip", "rect(130, 1024, 896, 0)");
		vsiNeedle.set("clip", "rect(287, 1024, 739, 930)");
		compass.set("clip", "rect(700, 1024, 990, 0)");
		curAlt3.set("clip", "rect(464, 1024, 559, 0)");
		curSpdTen.set("clip", "rect(464, 1024, 559, 0)");
		
		return m;
	},
	update: func()
	{
		var radioAlt = getprop("position/altitude-agl-ft")-16.5;
		var alt = getprop("instrumentation/altimeter/indicated-altitude-ft");
		if (alt < 0)
			alt = 0;
		var apAlt = getprop("autopilot/settings/target-altitude-ft");
		var ias = getprop("velocities/airspeed-kt");
		var flaps = getprop("/controls/flight/flaps");
		var pitch = getprop("orientation/pitch-deg");
		var roll =  getprop("orientation/roll-deg");
		
		#10 deg = 105px
		horizon.setTranslation(0,pitch*10.5);
		horizon.setRotation(-roll*D2R);
		bankPointer.setRotation(-roll*D2R);
		compass.setRotation(-getprop("orientation/heading-deg")*D2R);
		
		# Flight director
		#if (getprop("autopilot/internal/target-pitch-deg") != nil)
		#	fdY.setTranslation(0,(getprop("autopilot/internal/target-pitch-deg")-pitch)*10.5);
		if (getprop("autopilot/internal/target-roll-deg") != nil) {
			var fdRoll = (roll-getprop("/autopilot/internal/target-roll-deg"))*10.5;
			if (fdRoll > 300)
				fdRoll = 300;
			elsif (fdRoll < -300)
				fdRoll = -300;
			fdX.setTranslation(-fdRoll,0);
		}
		
		speedText.setText(sprintf("%3.0f",getprop("autopilot/settings/target-speed-kt")));
		machText.setText(sprintf("%.3f",getprop("velocities/mach")));
		altText.setText(sprintf("%5.0f",apAlt));
		selHdgText.setText(sprintf("%3.0f",getprop("autopilot/settings/true-heading-deg")));
		
		curAlt1.setText(sprintf("%2.0f",math.floor(alt/1000)));
		curAlt2.setText(sprintf("%1.0f",math.mod(math.floor(alt/100),10)));
		curAlt3.setTranslation(0,(math.mod(alt,100)/20)*35);
		var curAltDiff = alt-apAlt;
		if (abs(curAltDiff) > 300 and abs(curAltDiff) < 900) {
			curAltBox.setStrokeLineWidth(5);
			if ((alt > apAlt and getprop("velocities/vertical-speed-fps") > 10) or (alt < apAlt and getprop("velocities/vertical-speed-fps") < 10))
				curAltBox.setColor(1,0,1);
			else
				curAltBox.setColor(1,1,1);
		} else {
			curAltBox.setStrokeLineWidth(2);
			curAltBox.setColor(1,1,1);
		}
		if (curAltDiff > 420)
			curAltDiff = 420;
		elsif (curAltDiff < -420)
			curAltDiff = -420;
		selAltPtr.setTranslation(0,curAltDiff*0.9);

		curSpd.setText(sprintf("%2.0f",math.floor(ias/10)));
		curSpdTen.setTranslation(0,math.mod(ias,10)*45);
		baroSet.setText(sprintf("%2.2f",getprop("instrumentation/altimeter/setting-inhg")));
		ilsCourse.setText(sprintf("CRS %3.0f",getprop("instrumentation/nav/radials/selected-deg")));
		dhText.setText(sprintf("DH%3.0f",getprop("instrumentation/mk-viii/inputs/arinc429/decision-height")));
		
		if (getprop("instrumentation/marker-beacon/outer")) {
			markerBeacon.show();
			markerBeaconText.setText("OM");
		} elsif (getprop("instrumentation/marker-beacon/middle")) {
			markerBeacon.show();
			markerBeaconText.setText("MM");
		} elsif (getprop("instrumentation/marker-beacon/inner")) {
			markerBeacon.show();
			markerBeaconText.setText("IM");
		} else {
			markerBeacon.hide();
		}
		
		if(getprop("instrumentation/nav/heading-needle-deflection-norm") != nil) {
			var deflection = getprop("instrumentation/nav/heading-needle-deflection-norm");
			locPtr.show();
			
			if (radioAlt < 2500) {
				risingRwy.show();
				risingRwyPtr.show();
				if (radioAlt< 200) {
					risingRwy.setTranslation(deflection*150,-(200-radioAlt)*0.682);
					risingRwyPtr_scale.setScale(1, ((200-radioAlt)*0.682)/11);
				} else {
					risingRwy.setTranslation(deflection*150,0);
					risingRwyPtr_scale.setScale(1, 1);
				}
			} else {
				risingRwy.hide();
				risingRwyPtr.hide();
			}
		
			if(abs(deflection) < 0.5) { # need to verify 0.5
				locPtr.setTranslation(deflection*300,0);
				risingRwyPtr.setTranslation(deflection*300,0);
				locScaleExp.show();
				locScale.hide();
			} else {
				locPtr.setTranslation(deflection*150,0);
				risingRwyPtr.setTranslation(deflection*150,0);
				locScaleExp.hide();
				locScale.show();
			}
		} else {
			locPtr.hide();
			locScaleExp.hide();
			locScale.hide();
			risingRwy.hide();
			risingRwyPtr.hide();
		}
		if (getprop("instrumentation/nav/nav-id") != nil)
			ilsId.setText(getprop("instrumentation/nav/nav-id"));
		if(getprop("instrumentation/nav/gs-needle-deflection-norm") != nil)
			gsPtr.setTranslation(0,-getprop("instrumentation/nav/gs-needle-deflection-norm")*150);
		
		if (alt < 10000)
			tenThousand.show();
		else 
			tenThousand.hide();
		if (getprop("velocities/vertical-speed-fps") != nil) {
			var vertSpd = getprop("velocities/vertical-speed-fps")*60;
			if (abs(vertSpd) > 400) {
				vertSpdText.setText(sprintf("%4.0f",roundToNearest(vertSpd,50)));
				vertSpdText.show();
			} else {
				vertSpdText.hide();
			}
			if (getprop("instrumentation/pfd/target-vs") != nil)
				vsPointer.setTranslation(0,-getprop("instrumentation/pfd/target-vs"));
		}
		if (radioAlt < 2500) {
			if (radioAlt > 500)
				radioAltInd.setText(sprintf("%4.0f",roundToNearest(radioAlt,20)));
			elsif (radioAlt > 100)
				radioAltInd.setText(sprintf("%4.0f",roundToNearest(radioAlt,10)));
			else
				radioAltInd.setText(sprintf("%4.0f",roundToNearest(radioAlt,2)));
			radioAltInd.show();
		} else {
			radioAltInd.hide();
		}
		#if (getprop("instrumentation/dme/in-range")) {
		if(getprop("instrumentation/nav/nav-distance") != nil)
			dmeDist.setText(sprintf("DME %2.1f",getprop("instrumentation/nav/nav-distance")*0.000539));
		#	dmeDist.show();
		#} else {
		#	dmeDist.hide();
		#}
		if (getprop("instrumentation/pfd/speed-trend-up") != nil)
			spdTrend_scale.setScale(1, (getprop("instrumentation/pfd/speed-lookahead")-getprop("/velocities/airspeed-kt"))/20);
		
		if (getprop("instrumentation/pfd/v1-diff") != nil) {
			var v1Diff = getprop("instrumentation/pfd/v1-diff");
			if (getprop("gear/gear/wow") and v1Diff != -1) {
				v1.show();
				v1.setTranslation(0,-v1Diff*380);
			} else {
				v1.hide();
			}
		} else {
			v1.hide();
		}
		if (getprop("instrumentation/pfd/vr-diff") != nil) {
			var vrDiff = getprop("instrumentation/pfd/vr-diff");
			if (getprop("gear/gear/wow") and abs(vrDiff) != 1) {
				vr.show();
				vr.setTranslation(0,-vrDiff*380);
			} else {
				vr.hide();
			}
		} else {
			vr.hide();
		}
		if (getprop("instrumentation/pfd/flaps-0-diff") != nil)
			flaps0.setTranslation(0,-getprop("instrumentation/pfd/flaps-0-diff")*380);
		if (getprop("instrumentation/pfd/flaps-1-diff") != nil)
			flaps1.setTranslation(0,-getprop("instrumentation/pfd/flaps-1-diff")*380);
		if (getprop("instrumentation/pfd/flaps-5-diff") != nil)
			flaps5.setTranslation(0,-getprop("instrumentation/pfd/flaps-5-diff")*380);
		if (getprop("instrumentation/pfd/flaps-10-diff") != nil)
			flaps10.setTranslation(0,-getprop("instrumentation/pfd/flaps-10-diff")*380);
		if (getprop("instrumentation/pfd/flaps-20-diff") != nil)
			flaps20.setTranslation(0,-getprop("instrumentation/pfd/flaps-20-diff")*380);
		
		flaps0.hide();
		flaps1.hide();
		flaps5.hide();
		flaps10.hide();
		flaps20.hide();
		if (alt < 20000) {
			if (flaps == 0.033) {
				flaps0.show(); flaps1.show();
			} elsif (flaps == 0.167) {
				flaps1.show(); flaps5.show();
			} elsif (flaps == 0.333) {
				flaps5.show(); flaps10.show();
			} elsif (flaps == 0.667) {
				flaps10.show(); flaps20.show();
			}
		}
		if (getprop("instrumentation/pfd/stallspeed-diff") != nil)
			minSpdInd.setTranslation(0,-getprop("instrumentation/pfd/stallspeed-diff")*380);
		if (getprop("instrumentation/pfd/overspeed-diff") != nil)
			maxSpdInd.setTranslation(0,-getprop("instrumentation/pfd/overspeed-diff")*380);
		if (getprop("instrumentation/pfd/minimums-diff") != nil)
			minimums.setTranslation(0,-getprop("instrumentation/pfd/minimums-diff"));
		if (getprop("instrumentation/pfd/touchdown-zone-diff") != nil) {
			touchdownInd.setTranslation(0,-getprop("instrumentation/pfd/touchdown-zone-diff"));
			touchdownInd.show();
		} else
			touchdownInd.hide();
		
		if(getprop("/gear/gear/wow")) {
			minSpdInd.hide();
			maxSpdInd.hide();
		} else {
			minSpdInd.show();
			maxSpdInd.show();
		}
		
		spdTape.setTranslation(0,ias*6);
		altTape.setTranslation(0,alt*0.9);
		if (getprop("autopilot/settings/target-speed-kt") != nil )
			cmdSpd.setTranslation(0,-(getprop("autopilot/settings/target-speed-kt")-ias)*6);
		
		if(getprop("instrumentation/pfd/vsi-needle-deg") != nil)
			vsiNeedle.setRotation(getprop("instrumentation/pfd/vsi-needle-deg")*D2R);
		
		var apSpd = getprop("/autopilot/locks/speed");
		if (apSpd == "speed-with-throttle-mach" or apSpd == "speed-with-throttle-ias")
			atMode.setText("SPD");
		elsif (apSpd ==  "speed-with-pitch-trim")
			atMode.setText("THR");
		else
			atMode.setText("");
		var apRoll = getprop("/autopilot/locks/heading");
		if (apRoll == "wing-leveler")
			rollMode.setText("HDG HOLD");
		elsif (apRoll ==  "dg-heading-hold")
			rollMode.setText("HDG SEL");
		elsif (apRoll ==  "nav1-hold")
			rollMode.setText("LNAV");
		else
			rollMode.setText("");
		vsPointer.hide();
		var apPitch = getprop("/autopilot/locks/altitude");
		if (apPitch == "vertical-speed-hold") {
			pitchMode.setText("V/S");
			vsPointer.show();
		} elsif (apPitch ==  "altitude-hold")
			pitchMode.setText("ALT");
		else
			pitchMode.setText("");
		
		settimer(func me.update(), 0.05);
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	pfd_display = canvas.new({
		"name": "PFD",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	pfd_display.addPlacement({"node": "pfdScreen"});
	var group = pfd_display.createGroup();
	pfd_canvas = canvas_PFD.new(group);
	pfd_canvas.update();
});

# The optional second arguments enables creating a window decoration
var showPfd = func() {
	var dlg = canvas.Window.new([400, 400], "dialog");
	dlg.setCanvas(pfd_display);
}