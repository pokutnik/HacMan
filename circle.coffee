Player = new Meteor.Collection('player')

Meteor.methods {
  set_route: (route) ->
    user = Meteor.user()
    console.log("SAVING ROUTE", route)
    Player.update({_id: user.c_id}, {$set: {
        timestamp: Date.now(),
        route: route,
        }})
  }
