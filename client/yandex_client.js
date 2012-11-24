Meteor.startup(function(){
  ymaps.ready(function () {
    var myMap = new ymaps.Map('myMap', {
      center: [50.442638,30.543365],
      zoom: 15,
      behaviors: ['drag', 'scrollZoom']
    });

    myMap.controls.add(
      new ymaps.control.ZoomControl()
    );

    var world = new World(myMap), s;
    
    shapes = Player.find({}, {reactive:false}).fetch()
    for(var i = 0; i < shapes.length; i++) {
      shape = shapes[i];
      options = _.extend({type: 'players', map_ref: myMap}, shape)
      console.log(shape, options);
      s = world.addShape(options);
    }
    
    //world.addShape({type: 'pacman', map_ref: myMap});
    
    //MAX_GHOSTS = 3;
    
    //for(var i = 0; i < MAX_GHOSTS; i++) {
      //world.addShape({type: 'ghost', map_ref: myMap});
    //}
  });
});
