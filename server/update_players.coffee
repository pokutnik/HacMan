Meteor.startup ->
  Meteor.setInterval ->
    angle = age() / 1000
    for player in Player.find().fetch()
      x = player.x + 0.001 * Math.sin(angle)
      y = player.y + 0.001 * Math.cos(angle)
      Player.update({_id: player._id}, {$set: {x: x, y: y}})
    for player in Player.find().fetch()
      console.log(player._id, player.x, player.y)
    return
  , 300
