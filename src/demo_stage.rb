class DemoStage < Stage

  def setup
    super
    backstage[:wave] ||= 0
    backstage[:wave] += 1

    @player = spawn :player, :x => 200, :y => 550

    input_manager.reg :down, KbW do
      @aliens = []
    end

    @score = spawn :score, :x => 10, :y => 10
    spawn :logo, :x => 480, :y => 460

    @aliens = []

    columns = 8
    rows = 2 + backstage[:wave]

    columns.times do |c|
      rows.times do |r|
        alien = spawn :alien, :x => 20+c*60, :y => 40+r*60
        alien.when :remove_me do
          if @aliens.size % 3 == 0
            @aliens.each{|a|a.increase_speed}
          end
        end

        @aliens << alien
      end
    end

    input_manager.reg :down, KbP do
      pause
    end

    on_unpause do
      sound_manager.play_sound :pause
      sound_manager.play_sound :ufo_flying, :repeats => -1 if @ufo
      @pause.remove_self
    end

    on_pause do
      sound_manager.stop_sound :ufo_flying if @ufo and @ufo.alive?
      sound_manager.play_sound :pause

      @pause = spawn :label, :text => "pause", :x => 280, :y => 300, :size => 20
      input_manager.reg :down, KbP do
        unpause
      end
    end

    on_collision_of :ufo, :frickin_laser do |ufo,laser|
      ufo_shot ufo, laser
    end

    on_collision_of :alien, :frickin_laser do |alien,laser|
      alien_shot alien, laser
    end

    on_collision_of :player, [:alien,:alien_missile] do |player,bad_thing|
      you_lose
    end

    add_timer :alien_shoot, (4-backstage[:wave])*1_000 do
      @aliens[rand(@aliens.size)].shoot unless @aliens.empty?
    end

    add_timer :ufo_spawn, 9_000 do
      if @ufo.nil?
        if (@aliens.size > 7)
          @ufo = spawn :ufo, :x => 10, :y => 30 
          @ufo.when :remove_me do
            @ufo = nil
          end
        end
      end
    end

    sound_manager.play_music :rush_remix if backstage[:wave] == 1

    # @stars ||= []
    # 20.times { @stars << Ftor.new(rand(viewport.width),rand(viewport.height)) }

  end

  def ufo_shot(ufo, laser)
    sound_manager.play_sound :ufo_death
    # spawn :score_fade, :x => ufo.x, :y => ufo.y, :score => 1000, :ttl => 1000
    ufo.remove_self
    laser.remove_self
    @score += 1000
    @ufo = nil
  end

  def alien_shot(alien, laser)
    # spawn :score_fade, :x => alien.x, :y => alien.y, :score => 100, :ttl => 1000
    @aliens.delete alien
    alien.remove_self
    laser.remove_self
    sound_manager.play_sound :death
    @score += 100
  end

  def rebuild_bounding_box
    return if @aliens.empty?

    alien_x_values = @aliens.collect{|a|a.x}
    alien_y_values = @aliens.collect{|a|a.y}
    min_x = alien_x_values.min
    max_x = alien_x_values.max
    max_y = alien_y_values.max+@aliens.first.image.height
    dir = @aliens.first.direction

    if max_x > viewport.width-20-@aliens.first.image.width and dir == Alien::RIGHT
      @aliens.each{|a|a.reverse_and_drop}
    elsif min_x < 20 and dir == Alien::LEFT
      @aliens.each{|a|a.reverse_and_drop}
    end

    if max_y > @player.y 
      you_lose
    end
  end

  def you_lose
    if @player.alive?
      sound_manager.play_sound :player_death
      spawn :label, :text => "YOU LOSE!", :x => 150, :y => 100, :size => 90
      @player.remove_self
      add_timer :ufo_spawn, 1_500 do
        fire :prev_stage
      end
    end
  end

  def update(time)
    super
    rebuild_bounding_box

    if @aliens.empty?
      @player.remove_self
      if backstage[:wave] == 3
        fire :next_stage 
      else
        fire :restart_stage 
      end
    end
  end
end

