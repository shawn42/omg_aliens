require 'stage'
require 'ftor'
class DemoStage < Stage

  def setup
    super

    @player = spawn :player, :x => 200, :y => 400

    @score = spawn :score, :x => 10, :y => 10
    spawn :logo, :x => 480, :y => 360

    @aliens = []
    8.times do |i|
      3.times do |j|
        alien = spawn :alien, :x => 20+i*60, :y => 40+j*60
        alien.when :remove_me do
          if @aliens.size % 5 == 0
            spawn :ufo, :x => 100, :y => 20 
          end
        end

        @aliens << alien
      end
    end

    on_collision_of :ufo, :frickin_laser do |ufo,laser|
      ufo.remove_self
      laser.remove_self
      @score += 1000
      @ufo = nil
    end

    on_collision_of :alien, :frickin_laser do |alien,laser|
      alien.remove_self
      laser.remove_self
      @score += 100
      @aliens.delete alien
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
    dir = @aliens.first.direction

    if max_x > viewport.width-20-@aliens.first.image.width and dir == Alien::RIGHT
      puts "swarm hit the right"
      @aliens.each{|a|a.reverse_and_drop}
    elsif min_x < 20 and dir == Alien::LEFT
      puts "swarm hit the left"
      @aliens.each{|a|a.reverse_and_drop}
    end

    if max_y > @player.y 
      fire :prev_stage
    end
  end

  def update(time)
    super

    rebuild_bounding_box
    find_collisions

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

