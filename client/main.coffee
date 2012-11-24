Template.hello.greeting = ->
  "Welcome to hacman."
Template.hello.events -> {
  'click input' : ->
      console.log("You pressed the button")
  }


Template.t_circles.circles = ->
  Circle.find({})

Template.t_circles.events = {
  "click": (e) ->
    console.log(e)
    o = Meteor.call('move_circle', e.clientX, e.clientY)
    console.log(o)
}
