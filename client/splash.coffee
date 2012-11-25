Meteor.startup(->
    $('.splash1, .splash2, .splash31, .splash32').bind('webkitAnimationEnd', ->
        $(this).hide()
        )
    $('.splash32').bind('webkitAnimationEnd', ->
        if PLAYER_SHAPE
            offset = PLAYER_SHAPE.get_pixel()
            emit("Your player", "flying_you", offset.left, offset.top)
        )
    )
