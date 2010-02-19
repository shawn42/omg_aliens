require 'actor'

class Player < Actor
  
  attr_accessor :move_left, :move_right, :can_shoot
  has_behavior :graphical, :updatable, :audible, 
    :collidable => {:shape => :circle, :radius => 20}

  def setup
    @can_shoot = true

    i = input_manager
    i.reg KeyPressed, :space do
      shoot if @can_shoot
    end

    i.while_key_pressed :left, self, :move_left
    i.while_key_pressed :right, self, :move_right
  end

  def shoot
    play_sound :shoot
    @can_shoot = false
    laser = spawn :frickin_laser, :x => @x + (image.width/2), :y => @y
    laser.when :remove_me do 
      @can_shoot = true
    end
    fire :shoot_laser, laser
  end
  
  def update(time_delta)
    velocity = 0.14 * time_delta
    @x += velocity if @move_right
    @x -= velocity if @move_left

    stage_left = 0
    stage_right = stage.viewport.width-20 

    if @x > stage_right
      @x = stage_right 
    elsif @x < stage_left
      @x = stage_left 
    end
  end
    
end
