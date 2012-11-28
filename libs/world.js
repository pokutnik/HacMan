function World(mapobj) {
	var map_ref = mapobj, shapes = {};
	MAP_HEIGHT = 600;
	MAP_WIDTH = 1100;
	
	this.findShape = function(id) {
		return shapes[id];
	}
	
	this.addShape = function(options) {
		options['after_create_callback'] = this.fit_map_to_shapes;
		options['world_ref'] = this;
    options['map_ref'] = map_ref;
		var shape = new Shape(options);
		shapes[options['_id']] = shape;
		this.fit_map_to_shapes();
    return shape;
	}

  this.update_shape = function(options){
    var shape = this.findShape(options._id);
    if (typeof shape == 'undefined') {
      shape = this.addShape(options)
    }
    shape.move(options)
  }
	
	this.fit_map_to_shapes = function() {
		var shape_coords = [];
		if(!_.any(shapes)) return;

		_.each(shapes, function(shape, id) {
			var coords = shape.get_coordinates();
			if(typeof coords[0] != 'undefined') {
			  shape_coords.push(coords);
			}
	  });
	
		if(shape_coords.length < 1) return;
		
		if(shape_coords.length == 1) {
			map_ref.setCenter(shape_coords[0], 13);
			return;
		}
		
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
	
		var map_el = jQuery('#myMap');
		var center_and_zoom = ymaps.util.bounds.getCenterAndZoom(bounds, [map_el.width(), map_el.height()]);
    var zoom = (center_and_zoom.zoom > 17 ? 17 : center_and_zoom.zoom);
		map_ref.setCenter(center_and_zoom.center, zoom);
	}
}
