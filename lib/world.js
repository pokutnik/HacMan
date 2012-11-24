function World(mapobj) {
	var map_ref = mapobj, shapes = [];
	
	ORIGIN_X = 50.442638;
	ORIGIN_Y = 30.543365;
	
	this.addShape = function(shape) {
		shapes.push(shape);
	}
	
	this.get_random_street = function() {
		
	}
	
	this.draw = function() {
		for (var i = 0; i < shapes.length; i++) {
		  shapes[i].draw();
		}
	}
}