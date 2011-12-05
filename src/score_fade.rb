class ScoreFadeView < ActorView
  def draw(target,x_off,y_off, z)
    actor.font.draw actor.score.to_s, actor.x, actor.y, z, 
      1,1,   # x factor, y factor
      actor.color
  end
end

class ScoreFade < Label
  
  attr_reader :score
  has_behavior :updatable

  def setup
    @initial_ttl = opts[:ttl]
    @ttl = opts[:ttl]
    @score = opts[:score]
    super
  end

  def update(time)
    @ttl -= time
    remove_self if @ttl <= 0
    color_val = 255 * percent_time_left
    @color = Color.new color_val, color_val, color_val, color_val
  end

  def percent_time_left
    @ttl/@initial_ttl.to_f
  end

end

