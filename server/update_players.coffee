Meteor.startup ->
  Meteor.setInterval ->
    angle = age() / 1000
    console.log("CALCULATING")
    curtime = Date.now()
    SPEED = 0.000001  # degrees per millisecond
    for player in Player.find({route: {$exists: true}}).fetch()
        past = curtime - player.timestamp
        s = player.route[0]
        f = player.route[1]
        dx = f[0] - s[0]
        dy = f[1] - s[1]
        len = Math.sqrt(dx*dx + dy*dy)
        past_dist = SPEED*past
        if past_dist > len
            # finish step
            x = f[0]
            y = f[1]
            if player.route.length > 2
                player.route.shift()
                Player.update({_id: player._id}, {$set: {
                    x: x,
                    y: y,
                    timestamp: curtime,  # slightly inacurate
                    route: player.route,
                    }})
            else
                Player.update({_id: player._id}, {$set: {
                    x: x,
                    y: y,
                    }, $unset: {
                    route: 1,
                    timestamp: 1,
                    }})
        else
            x = s[0] + dx/len*past_dist
            y = s[1] + dy/len*past_dist
            Player.update({_id: player._id}, {$set: {
                x: x,
                y: y,
                }})
        console.log("PLAYER", player.color, past, past_dist, s, f, x, y)
    return
  , 300
