class Player < Actor
  
  attr_accessor :move_left, :move_right, :can_shoot
  has_behaviors :graphical, :updatable, :audible, 
    :collidable => {:shape => :circle, :radius => 20}

  def setup
    @can_shoot = true

    i = input_manager
    i.reg :keyboard_down, KbSpace do
      shoot if @can_shoot
    end

    i.while_pressed KbLeft, self, :move_left
    i.while_pressed KbRight, self, :move_right
  end

  def shoot
    play_sound :shoot
    @can_shoot = false
    laser = spawn :frickin_laser, :x => self.x + (image.width/2), :y => self.y
    laser.when :remove_me do 
      @can_shoot = true
    end
  end
  
  def update(time_delta)
    velocity = 0.14 * time_delta
    self.x += velocity if @move_right
    self.x -= velocity if @move_left

    stage_left = 0
    stage_right = stage.viewport.width-20 

    if self.x > stage_right
      self.x = stage_right 
    elsif self.x < stage_left
      self.x = stage_left 
    end
  end
    
end
