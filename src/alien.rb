require 'actor'

class Alien < Actor
  attr_reader :direction
  has_behavior :animated => {:frame_update_time => 900}, :collidable => {:shape => :circle, :radius => 20}

  RIGHT = 1
  LEFT = -1

  def setup
    self.action = :march
    @direction = RIGHT
    @initial_x = opts[:x]
    @speed = 1 * 0.01
    @speed_up = 0.001 * stage.backstage[:wave]
  end

  def update(time)
    super
    @x += @speed * @direction * time
  end

  def reverse_and_drop
    increase_speed
    drop_down
    reverse_direction!
  end

  def increase_speed
    @speed += @speed_up
  end

  def drop_down
    @y += 25
  end

  def reverse_direction!
    @direction *= -1
  end

  def shoot
    spawn :alien_missile, :x => @x + (image.width/2), :y => @y
  end
end
