Meteor.startup ->
  Meteor.setInterval ->
    angle = age() / 1000
    #for player in Player.find().fetch()
      #x = player.x + 0.0001 * Math.sin(angle)
      #y = player.y + 0.0001 * Math.cos(angle)
      #Player.update({_id: player._id}, {$set: {x: x, y: y}})
    return
  , 300
