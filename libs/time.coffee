time = ->
  +new Date()

startTime = time()

age = ->
  time() - startTime
