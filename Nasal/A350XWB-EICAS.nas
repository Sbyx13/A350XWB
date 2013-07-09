EICAS = {};

EICAS.new = func {
  var obj = {
    parents : [EICAS],
  };

   obj.init();
   return obj;
};

EICAS.init = func {
  me.counter=0;
  me.startcanvas();
  #me.inherit_system('/systems/eicas');
}

EICAS.startcanvas = func {
me.eicas_canvas = canvas.new({
    "name": "EICAS",   # The name is optional but allow for easier identification
    "size": [1024, 1024], # Size of the underlying texture (should be a power of 2, required) [Resolution]
    "view": [768, 1024],  # Virtual resolution (Defines the coordinate system of the canvas [Dimensions]
                          # which will be stretched the size of the texture, required)
    "mipmapping": 1       # Enable mipmapping (optional)
  });
  me.eicas_canvas.addPlacement({"node": "EICAS Screen"});
  me.eicas_canvas.setColorBackground(1,0,0,1);
  me.canvasgroup = me.eicas_canvas.createGroup();
  me.canvastext = me.canvasgroup.createChild("text", "optional-id-for element")
                .setTranslation(30, 30)      # The origin is in the top left corner
                .setAlignment("left-center") # All values from osgText are supported (see $FG_ROOT/Docs/README.osgtext)
                .setFont("LiberationFonts/LiberationSans-Regular.ttf") # Fonts are loaded either from $AIRCRAFT_DIR/Fonts or $FG_DATA/Fonts
                .setFontSize(50)        # Set fontsize and optionally character aspect ratio
                .setColor(0,0,0);             # Text color
  me.canvastext.setText("Count " ~ me.counter);
  print("Created Canvas");
}

EICAS.schedule = func {
  #We will do the animation calls in here
  me.counter=me.counter+1;
  me.canvastext.setText("Count " ~ me.counter);
}

