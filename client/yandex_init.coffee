Meteor.startup ->
  ymaps.ready ->
    myMap = new ymaps.Map('myMap', {
      center: [50.442638,30.543365],
      zoom: 15,
      behaviors: ['drag', 'scrollZoom']
    })

    myMap.controls.add(new ymaps.control.ZoomControl())

    world = new World(myMap)

    shapes = Player.find({}, {reactive:false}).fetch()
    for shape in shapes
      options = _.extend({type: 'pacman', map_ref: myMap}, shape)
      console.log(shape, options)
      s = world.addShape(options)

    myMap.events.add('click', ->
        console.log(e)
    )
