define_actor :player do
  has_behaviors :graphical, :audible
  has_behaviors :keyboard_movement, :keyboard_shooting

  has_behavior :collidable => {:shape => :circle, :radius => 20}
  has_behavior shooter: { shoots: :frickin_laser, direction: vec2(0,1)}
  has_behavior mover: { speed: 0.14 }
end
