define_actor :alien do
  has_attributes action: :march, view: :graphical_actor_view


  has_behavior animated: {:frame_update_time => 900}
  has_behavior collidable: {shape: :polygon, cw_local_points: [[4,4],[44,4],[44,44],[4,44]]}
  has_behavior projectile: {speed: 0.01, direction: vec2(1,0)}
  has_behavior :reversable_direction
  has_behavior increasing_speed: { accel: 0.001 }
  has_behavior drops: { fall_amount: 25}
  has_behavior shooter: {shoots: :alien_missile, direction: vec2(0,-1)}

end
