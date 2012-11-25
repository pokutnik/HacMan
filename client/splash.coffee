Template.splash.events({
    "animationend div.splash1, webkitAnimationEnd div.splash1": ->
        $(".splash1").remove()
    "animationend div.splash2, webkitAnimationEnd div.splash2": ->
        $(".splash2").remove()
    "animationend .splash3, webkitAnimationEnd .splash3": ->
        $(".splash3").remove()
    })
