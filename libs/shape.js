function Shape(options) {
	ORIGIN_X = 50.442638;
	ORIGIN_Y = 30.543365;
	
	var x, // // instead of latitude and longitude
			y,
			world_ref = options['world_ref'],
			map_ref = options['map_ref'],
			type = options['type'],
			placemark;
			
	this.move = function(options) {
		var x = options['to_lat'],
		    y = options['to_lng'];
		if(this.can_move(options)) {
		  placemark.geometry.setCoordinates([x, y]); // move
		}
	}

	this.can_move = function(options) {
		var move_to_x = options['to_lat'],
		    move_to_y = options['to_lng'];
				// maps.api
		return true;
	}

	this.draw = function() {
		if(typeof placemark == "undefined") {
			console.log('adding placemark');
		  placemark = new ymaps.Placemark([x, y], {
			  balloonContent: type
			}, {
			  iconImageHref: (type == 'pacman' ? 'pacman.png' : 'ghost.gif'), // картинка иконки
			  iconImageSize: [25, 25],
			  draggable: true
			});
		  map_ref.geoObjects.add(placemark);
		}
	}
			
	this.get_random_coordinates = function() {
		var random_x = ORIGIN_X - 0.02 + (Math.random() / 50.0),
			random_y = ORIGIN_Y - 0.02 + (Math.random() / 50.0);
		return random_y + "," + random_x;
	}

  this.get_coordinates = function() {
	  return [x, y];
  }

	this.get_random_street = function() {
		var shape = this;
		jQuery.get('http://geocode-maps.yandex.ru/1.x/?geocode=' + this.get_random_coordinates() +   '&kind=street&spn=0.00005,0.00005&rspn=1&results=1&format=json', function(response) {
			try {
				var pos = response["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"];
				var point = pos.split(' ');
				x = parseFloat(point[1]);
				y = parseFloat(point[0]);
			} catch(e) {
				console.log('error in get_random_street');
				console.log(e);
				shape.get_random_street();
			}
			shape.draw();
			world_ref.fit_map_to_shapes();
			return;
		});
	}
	
	this.get_random_street();
}
