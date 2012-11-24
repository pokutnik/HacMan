time = Date.now

startTime = time()

age = ->
  console.log(time)
  time() - startTime
