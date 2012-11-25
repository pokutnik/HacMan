Meteor.startup(->
    $('.splash1, .splash2, .splash31, .splash32').bind('webkitAnimationEnd', ->
        $(this).remove()
        )
    )
