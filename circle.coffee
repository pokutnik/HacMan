Circle = new Meteor.Collection('circle')

Meteor.methods {
  move_circle: (x,y) ->
    user = Meteor.user()
    o = Circle.update(user.c_id, {$set: {
        x: x,
        y: y,
      }
    })
  }
