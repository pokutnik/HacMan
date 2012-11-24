function World(mapobj) {
	var map_ref = mapobj, shapes = [];
	
	
	this.addShape = function(shape) {
		shapes.push(shape);
	}
	
	this.draw = function() {
		for (var i = 0; i < shapes.length; i++) {
		  shapes[i].draw();
		}
	}
}