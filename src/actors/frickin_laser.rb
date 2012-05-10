define_actor :frickin_laser do
  has_behavior projectile: {speed: 0.4, direction: vec2(0, -1)}
  has_behavior collidable: {:shape => :circle, :radius => 4}
  has_behaviors in_bounds_or_death: {bounds: [0,30,:viewport_width,:viewport_height]}

  view do
    draw do |target, x_offset, y_offset, z|
      target.fill(actor.x, actor.y, actor.x+actor.radius/2.0, actor.y-actor.radius*2, [0xff, 0xff, 0xff], z)
    end
  end
end
