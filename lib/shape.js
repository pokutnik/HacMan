function Shape(options) {
	var x = options['x'], // // instead of latitude and longitude
			y = options['y'],
			map_ref = options['map_ref'],
			type = options['type'],
			placemark;
			
	
	this.move = function(options) {
		var move_to_x = options['to_lat'],
		    move_to_y = options['to_lng'];
		if(can_move(options)) {
			// move
		}
	}
	
	this.can_move = function(options) {
		var move_to_x = options['to_lat'],
		    move_to_y = options['to_lng'];
		// maps.api
	}
	
	this.draw = function() {
		console.log('draw');
		console.log(placemark);
		if(typeof placemark == "undefined") {
			console.log('adding placemark');
		  placemark = new ymaps.Placemark([x, y]);
		  map_ref.geoObjects.add(placemark);
		}/* else {
			this.placemark.properties.set('balloonContent', [this.x, this.y]);
		}*/
	}
}