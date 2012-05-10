define_actor :alien_missile do
  has_behavior in_bounds_or_death: {bounds: [0,0,:viewport_width,:viewport_height]}
  has_behavior projectile: {speed: 0.3, direction: vec2(0, 1)}
  has_behavior :collidable => {:shape => :polygon,
                               :cw_local_points => [[0,0],[8,0],[4,10]]}

  view do
    draw do |target, x_offset, y_offset, z|
      target.fill(actor.x, actor.y, actor.x+actor.radius/2.0, actor.y-actor.radius*2, [0xff, 0xff, 0xff], z)
    end
  end
end
