Template.positions.players = ->
  Player.find()

Meteor.startup ->
  ymaps.ready ->
    Meteor.autorun ->
      p = Player.find().fetch()
      console.log(p)
      world.update_shape(p)

