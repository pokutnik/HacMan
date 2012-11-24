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

    var world = new World(myMap);
    
    world.addShape({type: 'pacman', map_ref: myMap});
    
    MAX_GHOSTS = 2;
    
    for(var i = 0; i < MAX_GHOSTS; i++) {
      world.addShape({type: 'ghost', map_ref: myMap});
    }
    var bounds = [];
    for(var i = 0; i < world.shapes.length; i++) {
      bounds.push(world.shapes[i].get_coordinates);
    }
    myMap.setBounds(bounds);
  });
});
