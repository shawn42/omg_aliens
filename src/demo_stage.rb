require 'stage'
require 'ftor'
class DemoStage < Stage
  def setup
    super
    @player = spawn :player, :x => 200, :y => 400

    @score = spawn :score, :x => 10, :y => 10
    spawn :logo, :x => 480, :y => 360

    @player.when :shoot_laser do |laser|
      @laser = laser
      @laser.when :remove_me do 
        @laser = nil
      end
    end

    @aliens = []
    8.times do |i|
      3.times do |j|
        @aliens << spawn(:alien, :x => 20+i*60, :y => 30+j*60)
      end
    end

    @stars = []
    20.times { @stars << Ftor.new(rand(viewport.width),rand(viewport.height)) }
  end

  def rebuild_bounding_box
    alien_x_values = @aliens.collect{|a|a.x}
    alien_y_values = @aliens.collect{|a|a.y}
    min_x = alien_x_values.min
    max_x = alien_x_values.max
    max_y = alien_y_values.max

    if max_x > viewport.width-20-@aliens.first.image.width
      @aliens.each{|a|a.reverse_and_drop}
    elsif min_x < 20
      @aliens.each{|a|a.reverse_and_drop}
    end

    if max_y > @player.y 
      fire :prev_stage
    end
  end

  def update(time)
    super

    rebuild_bounding_box
    unless @laser.nil?
      dead_aliens = []
      @aliens.each do |alien|
        if alien.x < @laser.x && alien.x+alien.image.width > @laser.x 
          if alien.y < @laser.y && alien.y+alien.image.height > @laser.y
            alien.remove_self
            @laser.remove_self
            @score.score += 100
            dead_aliens << alien
            break
          end
        end
      end
      @aliens -= dead_aliens
    end

  end

  def draw(target)
    target.fill [25,25,25,255]
    for star in @stars
      target.draw_circle_s([star.x,star.y],1,[255,255,255,255])
    end
    super
  end
end

