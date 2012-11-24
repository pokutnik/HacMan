Player = new Meteor.Collection('player')

Meteor.methods {
  move_circle: (x,y) ->
    user = Meteor.user()
    o = Player.update(user.c_id, {$set: {
        x: x,
        y: y,
      }
    })
  }
