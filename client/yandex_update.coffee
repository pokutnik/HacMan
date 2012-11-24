Template.positions.circles = ->
  Circle.find({})

Meteor.startup ->
  ymaps.ready ->
    Meteor.autorun ->
      c = Circles.find({})
      console.log(c)

