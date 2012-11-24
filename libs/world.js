function World(mapobj) {
	var map_ref = mapobj, shapes_length	= 0, shapes = {};
	MAP_HEIGHT = 600;
	MAP_WIDTH = 1100;
	
	this.findShape = function(id) {
		return shapes[id];
	}
	
	this.addShape = function(options) {
		options['after_create_callback'] = this.fit_map_to_shapes;
		options['world_ref'] = this;
		var shape = new Shape(options);
		shapes[options['id']] = shape;
		shape_length += 1;
    return shape;
	}

  // TODO: implement move from server info
  this.updateShape = function(shape){
    shape._id // 
    shape.x // lat
    shape.y // lan
    shape.type
  }
	
	this.fit_map_to_shapes = function() {
		var shape_coords = [];
		_.each(shapes, function(id, shape) {
			var coords = shape.get_coordinates();
			if(typeof coords[0] != 'undefined') {
			  shape_coords.push(coords);
			}
	  });
	
		if(shape_coords.length < 2) return;
		
		var max_y = shape_coords[0][0], 
				min_y = shape_coords[0][0],
				min_x = shape_coords[0][1],
				max_x = shape_coords[0][1];
		
		for(var i = 1; i < shape_coords.length; i++) {
			if(shape_coords[i][0] > max_y) {
			  max_y = shape_coords[i][0];
			} else if(shape_coords[i][0] < min_y) {
				min_y = shape_coords[i][0];
			}
			
			if(shape_coords[i][1] > max_x) {
			  max_x = shape_coords[i][1];
			} else if(shape_coords[i][1] < min_x) {
				min_x = shape_coords[i][1];
			}
	  }
		var bounds = [[min_y, min_x], [max_y, max_x]];
	
		var center_and_zoom = ymaps.util.bounds.getCenterAndZoom(bounds, [MAP_WIDTH, MAP_HEIGHT]);

		map_ref.setCenter(center_and_zoom.center, center_and_zoom.zoom);
	}
}
