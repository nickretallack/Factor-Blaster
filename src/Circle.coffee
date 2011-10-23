Circle = (I) ->
  Object.reverseMerge I,
    radius:10


  self = GameObject(I).extend
    center: -> Point(I.x, I.y)

  self.attrAccessor 'radius'

  self.unbind 'draw'
  self.bind 'draw', (canvas) ->
    canvas.fillCircle 0,0,self.radius(),I.color

  self.bind 'draw', (canvas) ->
    canvas.fillColor '#000'
    canvas.fillText ''+I.value, -count_digits(I.value)*3,3


  return self

count_digits = (number) ->
  (''+number).length