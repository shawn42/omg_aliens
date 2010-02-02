require 'stage'
require 'ftor'
class DemoStage < Stage
  attr_reader :score

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
        @aliens << spawn(:alien, :x => 20+i*60, :y => 40+j*60)
      end
    end

    sound_manager.play_music :rush_remix

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

  def laser_hits?(actor)
    actor.x < @laser.x && actor.x+actor.image.width > @laser.x &&
      actor.y < @laser.y && actor.y+actor.image.height > @laser.y
  end

  def update(time)
    super

    rebuild_bounding_box
    unless @laser.nil?
      dead_aliens = []
      @aliens.each do |alien|
        if laser_hits? alien
            alien.remove_self
            @laser.remove_self
            @score.score += 100
            dead_aliens << alien
            break
        end
      end
      @aliens -= dead_aliens
    end

    unless @ufo.nil?
      if @laser && laser_hits?(@ufo)
        @ufo.remove_self
        @score.score += 1000
      elsif @ufo.x > viewport.width
        @ufo.remove_self
      end
    end

    if @ufo.nil?
      if rand(200) == 0
        @ufo = spawn :ufo, :x => 100, :y => 20 
        @ufo.when :remove_me do
          @ufo = nil
        end
      end
    end

    if @aliens.empty?
      puts "YOU WIN #{@score.score}"
      fire :next_stage 
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

