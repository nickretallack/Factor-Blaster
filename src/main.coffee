window_size = Point 480,320

# Create the engine
window.engine = Engine
  backgroundColor: Color("white")
  canvas: $("canvas").powerCanvas()

# Add the player object to the engine
engine.add
  class: "Player"
  x: window_size.x/2
  y: window_size.y
  color: "#F00"

random_multiple = (factor_limit) ->
  factors = random_integer 1,factor_limit
  value = 1
  for factor in [1..factors]
    value *= random_in primes
  value

random_in = (list) ->
  index = random_integer 0, primes.length
  return list[index]

random_integer = (lower, upper) ->
  Math.floor random_between(lower, upper)

random_between = (lower,upper) ->
  Math.random() * (upper-lower) + lower

variance = 0.5
max_spawn_delay = 150

window.kills = 0
spawn_counter = 0
engine.bind 'update', ->
  spawn_counter -= 1
  if spawn_counter <= 0
    spawn_counter = random_between(1-variance, variance)*max_spawn_delay
    #spawn_distance = Point(200/2.0,0)
    #random_angle = Math.random() * 2 * Math.PI
    #dude_position = Matrix.rotation(random_angle).transformPoint(spawn_distance)
    engine.add
      class:"Enemy"
      x: 200
      y: 0
      value: random_multiple(5)

engine.bind 'draw', (canvas) ->
  canvas.fillColor '#000'
  canvas.centerText "Kills: #{kills}", 10

# Start the engine
engine.start()

