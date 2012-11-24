
Accounts.onCreateUser (options, user)->
  console.log(options,user)
  Circle.insert({
    userId: user._id,
    username: user.username,
    x: 50.442638,
    y: 30.543365,
  })

