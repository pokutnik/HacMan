Template.positions.players = ->
  Player.find({})

Meteor.startup ->
  ymaps.ready ->
    Meteor.autorun ->
      p = Player.find({})
      console.log(p)

