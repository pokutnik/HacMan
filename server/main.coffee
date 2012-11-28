ORIGIN_X = 50.442638
ORIGIN_Y = 30.543365

get_random_coordinates = ->
  random_x = ORIGIN_X + (Math.random() / 500.0)
  random_y = ORIGIN_Y + (Math.random() / 500.0)
  return random_y+","+random_x

set_random_place_for = (c)->
  Meteor.http.get('http://geocode-maps.yandex.ru/1.x/?geocode=' + get_random_coordinates() +   '&kind=street&spn=0.00005,0.00005&rspn=1&results=1&format=json', {}, (err, response) ->
    content = Function("return " + response.content)() # poor-man's json parser
    try
      pos = content["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"]
      point = pos.split(' ')
      p = Player.update({_id: c}, {$set: {
                    x: parseFloat(point[1]),
                    y: parseFloat(point[0])
                    }})
    catch e
      console.log('error in get_random_street')
      console.log(e)
      set_random_place(c)
  )

Accounts.onCreateUser (options, user)->
  c = Player.insert({x: 50.442638, y: 30.543365, status: 'alive', color: colors[Math.floor(Math.random()*colors.length)], kind: kinds[Math.floor(Math.random()*kinds.length)]})
  user.c_id = c
  user.score = 0
  set_random_place_for(c)
  return user

NewCollection = new Meteor.Collection('new_collection')

Meteor.startup ->
  # setup DB
  unless NewCollection.findOne()
    NewCollection.insert({version: 1})
