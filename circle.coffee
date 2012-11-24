Circle = new Meteor.Collection('circle')

Meteor.methods -> {
  move_circle: (x,y) ->
    console.log(x,y,this)
    Circle.update({
      owner: this.userId,
    },{
      owner: this.userId,
      x: x,
      y: y,
    })
}
