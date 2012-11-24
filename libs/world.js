function World(mapobj) {
	var map_ref = mapobj, shapes = [];
	
	this.addShape = function(options) {
		var shape = new Shape(options);
		shapes.push(shape);
	}
	
	this.fit_map_to_shapes = function() {
		var bounds = [];
		for(var i = 0; i < shapes.length; i++) {
		  bounds.push(shapes[i].get_coordinates);
	  }
		map_ref.setBounds(bounds);
	}
	
	this.draw = function() {
		for (var i = 0; i < shapes.length; i++) {
		  shapes[i].draw();
		}
	}
}