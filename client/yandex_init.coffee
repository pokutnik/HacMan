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
      s = world.addShape(options)

    # select current shape
    player_shape_id = Meteor.user().c_id
    if (player_shape_id != undefined)
      Session.set('player_shape_id', player_shape_id)
      p = Player.findOne(player_shape_id)

      myMap.events.add('click', (e) ->
        coords = e.get('coordPosition')
        y = coords[0].toPrecision(6)
        x = coords[1].toPrecision(6)
        go = [[p.x, p.y],[y, x]]
        console.log('go', go)
        ymaps.route(go).then( (route) ->
          points = route.getPaths()
          route_pairs_list = []  ## list of route points
          points.each((p) ->
            p_coords = p.geometry.getCoordinates()
            for o in p_coords
              route_pairs_list.push(o)
          )
          console.log('route_list', route_pairs_list)
          Meteor.call('set_route', route_pairs_list)
          myMap.geoObjects.add(route)
        )
      )
