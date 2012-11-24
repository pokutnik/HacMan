Meteor.methods
    setProfileName: (name) ->
        user = Meteor.user()
        Meteor.users.update({_id: user._id}, {$set: {'profile.name': name}})

if Meteor.isClient

    Template.profile.user = ->
        return Meteor.user()

    Template.profile.events({
        "click button": ->
            Meteor.call("setProfileName", $("#pro_name").val())
        })
