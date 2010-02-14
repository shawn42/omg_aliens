require 'actor'

class Ufo < Actor
  has_behavior :graphical, :audible, :updatable, :collidable => {:shape => :circle, :radius => 10}
  RIGHT = 1
  LEFT = -1
  
  def setup
    @speed = 12 * 0.01
    @dir = opts[:dir]
    @dir ||= RIGHT
    play_sound :ufo_flying, :repeats => -1
    self.when :remove_me do
      stop_sound :ufo_flying
    end
  end

  def update(time_delta)
    @x += @speed*@dir*time_delta
    remove_self if @x > stage.viewport.width
  end

end
