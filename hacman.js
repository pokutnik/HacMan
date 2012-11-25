if (Meteor.isClient) {
    Template.navbar.menu = [
        {'title': 'Game',
         'page': 'main'},
        {'title': 'Rating',
         'page': 'rating'},
        {'title': 'Profile',
         'page': 'profile'},
        ];
    if(Session.get('page') == null) {
        Session.set('page', 'profile');
    }
    Template.navbar.events({
        'click a.pagechange': function() {
            Session.set('page', this.page);
        },
    })
    Template.navbar.isPage = Template.main.isPage = function(name) {
        return Session.equals('page', name);
    }
}
