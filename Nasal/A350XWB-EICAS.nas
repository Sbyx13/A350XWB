EICAS = {};

EICAS.new = func {
  var obj = {
    TESTVARIABLE : testvalue,
  };

   obj.init();
   return obj;
};

EICAS.init = func {
  me.startcanvas();
  #me.inherit_system('/systems/eicas');
}

EICAS.startcanvas = func {
var eicas_canvas = canvas.new({
    "name": "EICAS",   # The name is optional but allow for easier identification
    "size": [1024, 1024], # Size of the underlying texture (should be a power of 2, required) [Resolution]
    "view": [768, 1024],  # Virtual resolution (Defines the coordinate system of the canvas [Dimensions]
                          # which will be stretched the size of the texture, required)
    "mipmapping": 1       # Enable mipmapping (optional)
  });
  eicas_canvas.addPlacement({"node": "EICAS Screen"});
  eicas_canvas.setColorBackground(1,0,0,1);
}

EICAS.schedule = func {
  #We will do the animation calls in here
}