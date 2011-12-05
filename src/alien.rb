require 'actor'

class Alien < Actor
  attr_reader :direction
  has_behavior :animated => {:frame_update_time => 900}, 
    :collidable => {:shape => :polygon,
               :cw_local_points => [[4,4],[44,4],[44,44],[4,44]]}

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
    self.x += @speed * @direction * time
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
    self.y += 25
  end

  def reverse_direction!
    @direction *= -1
  end

  def shoot
    spawn :alien_missile, :x => self.x + (image.width/2), :y => self.y
  end
end
