Template.positions.players = ->
  Player.find()

Meteor.startup ->
  ymaps.ready ->
    Meteor.autorun ->
      for p in Player.find().fetch()
        world.update_shape(p)

