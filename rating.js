Meteor.methods({
    incrementScore: function(value) {
        var user = Meteor.user();
        Meteor.users.update({_id: user._id}, {$inc: {score: value}});
    }
})

if(Meteor.isServer) {

    Meteor.publish("userData", function () {
      return Meteor.users.find({}, {fields: {'score': 1}});
    });

    Meteor.publish("allUserData", function () {
      return Meteor.users.find({}, {fields: {'score': 1}});
    });

}

if(Meteor.isClient) {

    Meteor.subscribe("userData");

    Template.rating.user_ratings = function() {
        var values = Meteor.users.find({},  {
            sort: {score: -1},
            fields: {'_id': 1, 'score': 1},
            }).fetch();
        for(var i = 0, ni = values.length; i < ni; ++i) {
            if(values[i].profile) {
                values[i].name = values[i].profile.name;
            } else {
                var id = values[i]._id;
                values[i].name = 'guest' + id.substr(0, id.indexOf('-'));
            }
        }
        return values;
    }
}
