
Accounts.onCreateUser (options, user)->
  Circle.insert({
    userId: user._id,
    username: user.username,
    x: 222,
    y: 100,
  })

