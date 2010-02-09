require 'actor'

class Ufo < Actor
  has_behavior :graphical, :updatable, :collidable => {:shape => :circle, :radius => 10}
  RIGHT = 1
  LEFT = -1
  
  def setup
    @speed = 12 * 0.01
    @dir = opts[:dir]
    @dir ||= RIGHT
  end

  def update(time_delta)
    @x += @speed*@dir*time_delta
    remove_self if @x > stage.viewport.width
  end
end
