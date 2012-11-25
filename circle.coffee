Player = new Meteor.Collection('player')
Route = new Meteor.Collection('route')

Meteor.methods {
  set_route: (route) ->
    console.log(route)
  }
