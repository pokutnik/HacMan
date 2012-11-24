Template.positions.circles = ->
  Circle.find({})

Meteor.startup ->
  ymaps.ready ->
    Meteor.autorun ->
      c = Circle.find({})
      console.log(c)

