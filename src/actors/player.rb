define_actor :player do
  has_behaviors do
    graphical #anchor: :top_left
    audible
    keyboard_movement
    keyboard_shooting

    collidable shape: :circle, :radius => 15
    shooter    shoots: :frickin_laser, direction: vec2(0,1)
    mover      speed: 0.24
  end
end
