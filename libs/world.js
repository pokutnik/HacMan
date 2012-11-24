function World(mapobj) {
	var map_ref = mapobj, shapes = [];
	
	this.addShape = function(options) {
		var shape = new Shape(options);
		shapes.push(shape);
	}
	
	this.draw = function() {
		for (var i = 0; i < shapes.length; i++) {
		  shapes[i].draw();
		}
	}
}