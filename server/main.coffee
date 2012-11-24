
Accounts.onCreateUser (options, user)->
  c = Circle.insert({
    x: 50.442638,
    y: 30.543365,
  })
  user.c_id = c
  return user
