Meteor.startup ->
  ymaps.ready ->
    myMap = new ymaps.Map('myMap', {
      center: [50.442638,30.543365],
      zoom: 15,
      behaviors: ['drag', 'scrollZoom']
    })

    myMap.controls.add(new ymaps.control.ZoomControl())

    world = new World(myMap)
    window.world = world

    shapes = Player.find({}, {reactive:false}).fetch()
    
    for shape in shapes
      options = _.extend({type: 'pacman', map_ref: myMap}, shape)
      console.log(shape, options)
      s = world.addShape(options)

    myMap.events.add('click', (e) ->
      coords = e.get('coordPosition')
      y = coords[0].toPrecision(6)
      x = coords[1].toPrecision(6)
      
      ymaps.route([[shapes[0][0], shapes[0][1]], [x, y]], {
        mapStateAutoApply: true
      }).then((route) ->
        route.getPaths().options.set({
          strokeColor: '0000ffff',
          opacity: 0.9
        })
        myMap.geoObjects.add(route)
        _.each(shapes, (shape) ->
          console.log(shape)
          shape.move({x: x, y: x})
        )
      )
    )
