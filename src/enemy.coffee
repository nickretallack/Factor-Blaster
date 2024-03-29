window.circular_collision23 = (a, b) ->
  r = a.radius() + b.radius()
  dx = b.x - a.x
  dy = b.y - a.y

  result = r * r >= dx * dx + dy * dy
  console.log result
  result

window.circular_collision = (a,b) ->
  a.center().distance(b.center()) < a.radius() + b.radius()

Enemy = (I) ->
  # Default values that can be overriden when creating a new player.
  Object.reverseMerge I,
    speed: 3
    value: 2
    radius: 12
    color:'#eee'

  self = Circle(I)
  self.attrAccessor 'value'

  self.radius = ->
    10 + Math.log(I.value) *1.1

  self.bind 'update', ->
    # combine
    for enemy in engine.find "Enemy"
      if enemy != self
        if circular_collision self, enemy
          self.merge enemy
          console.log "yeah"

    # chase player
    player = engine.find('Player')[0]
    player_direction = player.center().subtract(self.center()).norm()
    velocity = player_direction

    I.x += velocity.x
    I.y += velocity.y

  self.hit = (value) ->
    if I.value % value == 0
      I.value /= value
      if I.value is 1
        self.destroy()
        window.kills += 1

  self.merge = (other) ->
    I.value *= other.value()
    other.destroy()

  return self
