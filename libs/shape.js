function Shape(options) {
	ORIGIN_X = 50.442638;
	ORIGIN_Y = 30.543365;

	var x = options.x || ORIGIN_X, // // instead of latitude and longitude
			y = options.u || ORIGIN_Y,
			world_ref = options['world_ref'],
			map_ref = options['map_ref'],
			username = options['name'],
			kind = options['kind'],
			color = options['color'],
            element,
			placemark;

  var _pic = function(direction){
    return kind + '-' + direction + '-' + color + '.gif'
  }

	this.move = function(options, callback) {
		if(!placemark) return;
    var x = options['x'],
        y = options['y'],
        old = placemark.geometry.getCoordinates()[1],
        diff = y - old;
    if (diff > 0.0000001){
      placemark.options.set('iconImageHref', _pic('right'));
    } else {
      if (diff < -0.0000001) {
        placemark.options.set('iconImageHref', _pic('left'));
      }
    }
    placemark.geometry.setCoordinates([x, y]);
		if(callback) {
			this.apply(callback);
		}
	}

	this.can_move = function(options) {
		var move_to_x = options['x'],
		    move_to_y = options['y'];
				// maps.api
		return true;
	}

	this.draw = function() {
		if(typeof placemark == "undefined") {
      var pic = _pic('left');
			console.log('adding placemark', pic);
      placemark = new ymaps.Placemark([x, y], {
              balloonContent: username,
              iconContent: 'current_placeholder',
          }, {
              iconImageHref: pic,
              iconImageSize: [25, 25],
              iconImageOffset: [-13, -13],
              draggable: true
          });
          map_ref.geoObjects.add(placemark);
          $('ymaps.ymaps-point-overlay ymaps.ymaps-image-with-content ymaps ymaps').each(function() {
            var el = $(this);
            if(el.text() == 'current_placeholder') {
                el.text('');
                element = el.parent().parent().parent();
            }
          });
          element.css('webkitTransition', "left 0.3s linear, top 0.3s linear");
      }

	}
  this.draw();

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

	//this.get_random_street();
}
