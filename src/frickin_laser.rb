require 'actor'

class FrickinLaserView < ActorView
  def draw(target, x_offset, y_offset)
    target.draw_box_s([actor.x, actor.y], [actor.x+actor.radius/2.0, actor.y-actor.radius*2], [0xff, 0xff, 0xff])
  end
end

class FrickinLaser < Actor
  has_behavior :updatable, :collidable => {:shape => :circle, :radius => 4}
  attr_accessor :length
  
  def update(time_delta)
    velocity = 4*0.1*time_delta
    @y -= velocity
    
    remove_self if @y < 30
  end
end
