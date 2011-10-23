window.Mouse = 
  buttons: {}
  buttons_once: {}
  location: Point(0,0)
  was_pressed: (button_name) ->
    if @buttons_once[button_name]
      @buttons_once[button_name] = false
      true

$(document).mousemove (event) ->
  Mouse.location = Point(event.pageX, event.pageY)

buttons = [null, "left", "middle", "right"]

set_button = (index, state) ->
  if index < buttons.length
    button_name = buttons[index]
    Mouse.buttons[button_name] = Mouse.buttons_once[button_name] = state

$(document).mousedown (event) ->
  set_button event.which,true

$(document).mouseup (event) ->
  set_button event.which,false