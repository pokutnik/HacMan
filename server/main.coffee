ORIGIN_X = 50.442638
ORIGIN_Y = 30.543365
	
get_random_coordinates = ->
	random_x = ORIGIN_X - 0.02 + (Math.random() / 50.0)
	random_y = ORIGIN_Y - 0.02 + (Math.random() / 50.0)
	random_y + "," + random_x

get_random_street = ->
	shape = this
	jQuery.get('http://geocode-maps.yandex.ru/1.x/?geocode=' + get_random_coordinates() +   '&kind=street&spn=0.00005,0.00005&rspn=1&results=1&format=json', (response) ->
		try
			pos = response["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"]
			point = pos.split(' ')
			x = parseFloat(point[1])
			y = parseFloat(point[0])
			return [x, y]
		catch e
			console.log('error in get_random_street')
			console.log(e)
			get_random_street()
	)
	
Accounts.onCreateUser (options, user)->
  coords = get_random_street
  c = Player.insert({
    x: coords[0],
    y: coords[1],
    status: 'alive',
    color: colors[Math.floor(Math.random()*colors.length)],
    kind: kinds[Math.floor(Math.random()*kinds.length)],
  })
  user.c_id = c
  user.score = 0
  return user

NewCollection = new Meteor.Collection('new_collection')


Meteor.startup ->
  # setup DB
  unless NewCollection.findOne()
    NewCollection.insert({version: 1})
