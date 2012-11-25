Player = new Meteor.Collection('player')

Meteor.methods {
  set_route: (route) ->
    user = Meteor.user()
    Player.update({_id: user.c_id}, {$set: {
        timestamp: Date.now(),
        route: route,
        }})
  }
