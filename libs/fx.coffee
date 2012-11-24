emit = (text, cls, x, y) ->
    el = $('<div>')
    el.text(text || cls || '<empty>')
    el.addClass(cls || 'flying_death')
    el.appendTo(document.body)
    el.bind("transitionend webkitTransitionEnd mozTransitionEnd"
            +"oTransitionEnd msTransitionEnd",
        -> el.remove())
    el.css(
        left: x + 'px'
        top: y + 'px'
        )
    console.log(el)
    setTimeout((-> el.addClass('after')), 100)
