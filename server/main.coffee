Accounts.onCreateUser (options, user)->
  c = Player.insert({
    x: 50.442638,
    y: 30.543365,
    type: 'pacman',
    status: 'alive',
  })
  user.c_id = c
  user.score = 0
  return user

NewCollection = new Meteor.Collection('new_collection')


Meteor.startup ->
  # setup DB
  unless NewCollection.findOne()
    NewCollection.insert({version: 1})
