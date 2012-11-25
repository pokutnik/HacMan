Meteor.startup ->
  Meteor.setInterval ->
    curtime = Date.now()
    SPEED = 0.000001  # degrees per millisecond
    
    pacmans_coords = {}
    ghosts_coords = {}
    
    for player in Player.find({kind: 'pacman'}, {reactive: false}).fetch()
      pacmans_coords[player._id] = [player.x, player.y]
      
    for player in Player.find({kind: 'ghost'}, {reactive: false}).fetch()
      ghosts_coords[player._id] = [player.x, player.y]
    
    _.each(ghosts_coords, (ghost_coords, ghost_id) ->
      _.each(pacmans_coords, (pacman_coords, pacman_id) ->
        if(Math.abs(ghost_coords[0] - pacman_coords[0]) < 0.001) && (Math.abs(ghost_coords[1] - pacman_coords[1]) < 0.001)
          Player.update({_id: pacman_id}, {$set: {
                    x: 50.442638,
                    y: 30.543365
                    }})
      )
    )
          
    for player in Player.find({route: {$exists: true}}, {reactive: false}).fetch()
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
  , 100
