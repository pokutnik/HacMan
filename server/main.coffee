ORIGIN_X = 50.442638
ORIGIN_Y = 30.543365

get_random_coordinates = ->
  random_x = ORIGIN_X + (Math.random() / 500.0)
  random_y = ORIGIN_Y + (Math.random() / 500.0)
  return [random_x, random_y]

get_random_street = ->
  Meteor.http.get('http://geocode-maps.yandex.ru/1.x/?geocode=' + get_random_coordinates() +   '&kind=street&spn=0.00005,0.00005&rspn=1&results=1&format=json', {}, (err, response) ->
    try
      debugger
      pos = response["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"]
      point = pos.split(' ')
      console.log(point)
      c = Player.insert({
        x: parseFloat(point[1]),
        y: parseFloat(point[0]),
        status: 'alive',
        color: colors[Math.floor(Math.random()*colors.length)],
        kind: kinds[Math.floor(Math.random()*kinds.length)],
      })
      user.c_id = c
      user.score = 0
      return user
    catch e
      console.log('error in get_random_street')
      console.log(e)
      get_random_street()
  )

Accounts.onCreateUser (options, user)->
  get_random_street

NewCollection = new Meteor.Collection('new_collection')


Meteor.startup ->
  # setup DB
  unless NewCollection.findOne()
    NewCollection.insert({version: 1})
