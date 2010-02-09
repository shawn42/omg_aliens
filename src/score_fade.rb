class ScoreFadeView < ActorView
  def draw(target,x_off,y_off)
    text = @actor.score.to_s

    font = @stage.resource_manager.load_font 'Asimov.ttf', 20
    value = 255 * @actor.percent_time_left
    text_image = font.render text, true, [value]*4

    x = @actor.x
    y = @actor.y

    text_image.blit target.screen, [x,y]
  end
end

class ScoreFade < Actor
  
  attr_reader :score
  has_behavior :updatable

  def setup
    @initial_ttl = opts[:ttl]
    @ttl = opts[:ttl]
    @score = opts[:score]
  end

  def update(time)
    @ttl -= time
    remove_self if @ttl <= 0
  end

  def percent_time_left
    @ttl/@initial_ttl.to_f
  end

end
