primes = [2,3,5,7]

# Player class constructor
Player = (I) ->

  # Default values that can be overriden when creating a new player.
  Object.reverseMerge I,
    speed: 3
    value: 2

  # The player is a GameObject
  self = Circle(I).extend
    center: -> Point(I.x, I.y)

  create_weapon_select_handlers = ->
    wheel_position = 0
    wheel_insensitivity = 200
    window.addEventListener 'mousewheel', (event) ->
      wheel_position += event.wheelDeltaY
      wheel_position = wheel_position.clamp(0, (primes.length-1) * wheel_insensitivity)
      I.value = primes[Math.floor(wheel_position / wheel_insensitivity) % primes.length]

    window.addEventListener 'keydown', (event) ->
      number = event.which - 48
      if number in primes
        I.value = number        
  create_weapon_select_handlers()


  self.bind "update", ->

    enemies = engine.find "Enemy"
    for enemy in enemies
      if circular_collision self, enemy
        console.log "whaaaat"

    if Mouse.was_pressed "left"
      engine.add
        class:'Laser'
        origin:self.center()
        target:Mouse.location
        value:I.value

  # We must return a reference to self from the constructor
  return self


player_movement = (I) ->
    # Handle player movement in response to arrow keys
    if keydown.left or keydown.a
      I.x -= I.speed

    if keydown.right or keydown.d or keydown.e
      I.x += I.speed

    if keydown.up or keydown.w or keydown[',']
      I.y -= I.speed

    if keydown.down or keydown.s or keydown.o
      I.y += I.speed

    # Clamp the player's position to be within the screen
    I.x = I.x.clamp(0, App.width)
    I.y = I.y.clamp(0, App.height)

### OBSOLETE
    if keydown[2]
      self.value = 2
    if keydown['3']
      self.value = 3
    if keydown['5']
      self.value = 5
    if keydown[7]
      self.value = 7
###


