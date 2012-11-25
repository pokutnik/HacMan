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

    # add shapes to map
    shapes = Player.find({}, {reactive:false}).fetch()
    for shape in shapes
      if not shape.profile
        shape.profile = {}
      options = _.extend({
        name: shape.profile.name || 'guest',
        kind: shape.profile.kind || 'pacman',
        color: shape.profile.color || 'blue',
        map_ref: myMap,
        }, shape)
      console.log(shape, options)
      s = world.addShape(options)

    # select current shape
    player_shape_id = Meteor.user().c_id
    console.log(player_shape_id)
    if (player_shape_id != undefined)
      Session.set('player_shape_id', player_shape_id)
      player_shape = world.findShape(player_shape_id)

      myMap.events.add('click', (e) ->
        coords = e.get('coordPosition')
        y = coords[0].toPrecision(6)
        x = coords[1].toPrecision(6)
        ymaps.route([[shapes[0]['x'], shapes[0]['y']],[y, x]]).then( (route) ->
          points = route.getWayPoints()
          route_pairs_list = []  ## list of route points
          Meteor.call('set_route', route_pairs_list)
          points.each((p) ->
            _.each(shapes, (shape) ->
              p_coords = p.geometry.getCoordinates()
              console.log(p_coords)
              world.findShape(shape._id).move({x: p_coords[0], y: p_coords[1]})
            )
          )
          #myMap.geoObjects.add(route)
        )
      )
