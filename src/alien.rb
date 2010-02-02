require 'actor'

class Alien < Actor

  has_behavior :animated, :updatable

  RIGHT = 1
  LEFT = -1

  def setup
    @direction = RIGHT
    @initial_x = opts[:x]
    @speed = 5
  end

  def update(time)
    @x += (@speed * @direction)*0.01*time
  end

  def reverse_and_drop
    # increase speed
    @speed += 1
    # drop down
    @y += 25
    # reverse direction!!
    @direction *= -1
  end
end
