require 'actor'

class Alien < Actor
  attr_reader :direction
  has_behavior :animated, :updatable, :collidable => {:shape => :circle, :radius => 20}

  RIGHT = 1
  LEFT = -1

  def setup
    @direction = RIGHT
    @initial_x = opts[:x]
    @speed = 2 * 0.01
    @speed_up = 0.005
  end

  def update(time)
    @x += @speed * @direction * time
  end

  def reverse_and_drop
    # increase speed
    @speed += @speed_up
    # drop down
    @y += 25
    # reverse direction!!
    @direction *= -1
  end
end
