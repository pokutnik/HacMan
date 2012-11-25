Player = new Meteor.Collection('player')
Route = new Meteor.Collection('route')

Meteor.methods {
  set_route: (route) ->
    user = Meteor.user()
    Route.update({c_id: user.c_id}, {$set: {route: route}})


  }
