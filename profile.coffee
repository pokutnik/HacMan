colors = [
    'blue',
    'green',
    'magenta',
    'red',
    ]
kinds = [
    'pacman',
    'ghost',
    ]

Meteor.methods {
    setProfileData: (data) ->
        user = Meteor.user()
        Meteor.users.update({_id: user._id}, {$set: {
            'profile.name': data.name,
            }})
        Player.update({_id: user.c_id}, {$set: {
            'color': data.color,
            'kind': data.kind,
            'name': data.name,
            }})
    }

if Meteor.isClient

    Template.profile.user = ->
        return Meteor.user()

    Template.profile.colors = ->
        return ({'color': color} for color in colors)

    Template.profile.kinds = ->
        return ({'kind': kind} for kind in kinds)

    Template.profile.myColor = ->
        user = Meteor.user()
        player = Player.findOne({_id: user.c_id}, {reactive:false})
        return player.color == this.color if player

    Template.profile.myKind = ->
        user = Meteor.user()
        player = Player.findOne({_id: user.c_id}, {reactive:false})
        return player.kind == this.kind if player

    Template.profile.events({
        "submit #profileform": (ev) ->
            ev.preventDefault()
            Meteor.call("setProfileData", {
                'name': $("#pro_name").val(),
                'kind': $("#pro_kind").val(),
                'color': $("#pro_color").val(),
                })
        })
