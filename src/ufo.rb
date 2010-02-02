require 'actor'

class Ufo < Actor
  has_behavior :graphical, :updatable
  RIGHT = 1
  LEFT = -1
  
  def setup
    @speed = 12
    @dir = opts[:dir]
    @dir ||= RIGHT
  end

  def update(time_delta)
    @x += @speed*@dir*0.01*time_delta
  end
end
