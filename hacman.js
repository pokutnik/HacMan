if (Meteor.isClient) {
    Template.navbar.menu = [
        {'title': 'Game',
         'page': 'main'},
        {'title': 'Rating',
         'page': 'rating'},
        ];
    Session.set('page', 'main');
    Template.navbar.events({
        'click a.pagechange': function() {
            Session.set('page', this.page);
        },
    })
    Template.navbar.isPage = Template.main.isPage = function(name) {
        return Session.equals('page', name);
    }
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
