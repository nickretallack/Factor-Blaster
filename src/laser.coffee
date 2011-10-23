Laser = (I) ->
  # Default values that can be overriden when creating a new player.
  Object.reverseMerge I,
    color:'#f00'
    origin: Point(0,0)
    target: Point(0,0)
    hit: false
    duration:3
    value:2

  direction = I.target.subtract(I.origin).norm()
  distant_target = I.origin.add(direction.scale(1000))

  potential_victims = engine.find('Enemy').select (enemy) ->
    Collision.rayCircle I.origin, direction, enemy

  potential_victims.sort (first, second) ->
    Point.distance(first.center(), I.origin) - Point.distance(second.center(), I.origin)

  hit_victim = if potential_victims.length then potential_victims[0] else null

  if hit_victim
    hit_victim.hit I.value

  self = GameObject(I).extend
    draw: (canvas) ->
      canvas.strokeColor I.color
      if hit_victim
        log "YEAH"
        canvas.drawLine I.origin, hit_victim.center(), 2
      else
        canvas.drawLine I.origin, distant_target, 2

  return self
