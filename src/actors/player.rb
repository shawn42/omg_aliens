define_actor :player do
  has_behaviors do
    graphical
    audible
    keyboard_movement
    keyboard_shooting

    collidable shape: :circle, :radius => 20
    shooter    shoots: :frickin_laser, direction: vec2(0,1)
    mover      speed: 0.14
  end
end
