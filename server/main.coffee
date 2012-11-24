
Accounts.onCreateUser (options, user)->
  c = Circle.insert({
    x: 50.442638,
    y: 30.543365,
  })
  user.c_id = c
  return user

NewCollection = new Meteor.Collection('new_collection')

Meteor.startup ->
  unless NewCollection.findOne()
    NewCollection.insert({version: 1})
    c = Circle.insert({
      x: 50.402638,
      y: 30.503365,
    })
