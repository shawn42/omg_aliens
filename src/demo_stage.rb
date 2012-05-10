class DemoStage < Stage

  def setup
    super
    backstage[:wave] ||= 0
    backstage[:wave] += 1

    @player = create_actor :player, x: 200, y: 550

    input_manager.reg :down, KbW do
      @aliens = []
    end

    @score = create_actor :score, x: 10, y: 10
    create_actor :fps, x: 400, y: 10
    create_actor :logo, x: 480, y: 460

    @aliens = []

    columns = 8
    rows = 2 + backstage[:wave]

    columns.times do |c|
      rows.times do |r|
        alien = create_actor :alien, x: 20+c*60, y: 40+r*60
        alien.when :remove_me do
          if @aliens.size % 3 == 0
            @aliens.each{|a|a.react_to :increase_speed}
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
      sound_manager.play_music :rush_remix
      sound_manager.play_sound :ufo_flying, repeats: -1 if @ufo
      @pause.remove
    end

    on_pause do
      sound_manager.stop_sound :ufo_flying if @ufo and @ufo.alive?
      sound_manager.pause_music :rush_remix
      sound_manager.play_sound :pause

      @pause = create_actor :label, text: "pause", x: 280, y: 300, size: 20
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
      @aliens[rand(@aliens.size)].react_to :shoot unless @aliens.empty?
    end

    add_timer :ufo_create_actor, 9_000 do
      if @ufo.nil?
        if (@aliens.size > 7)
          @ufo = create_actor :ufo, x: 10, y: 30 
          @ufo.when :remove_me do
            @ufo = nil
          end
        end
      end
    end

    sound_manager.play_music :rush_remix if backstage[:wave] == 1
  end

  def ufo_shot(ufo, laser)
    sound_manager.play_sound :ufo_death
    create_actor :score_fade, x: ufo.x, y: ufo.y, score: 1000, ttl: 1000
    ufo.remove
    laser.remove
    @score.react_to :add, 1000
    @ufo = nil
  end

  def alien_shot(alien, laser)
    create_actor :score_fade, x: alien.x, y: alien.y, score: 100, ttl: 1000
    @aliens.delete alien
    alien.remove
    laser.remove
    sound_manager.play_sound :death
    @score.react_to :add, 100
  end

  def rebuild_bounding_box
    return if @aliens.empty?

    alien_x_values = @aliens.collect{|a|a.x}
    alien_y_values = @aliens.collect{|a|a.y}
    min_x = alien_x_values.min
    max_x = alien_x_values.max
    max_y = alien_y_values.max+@aliens.first.image.height
    dir = @aliens.first.direction.x

    if (max_x > viewport.width-20-@aliens.first.image.width and dir == 1) or
       (min_x < 20 and dir == -1)
      @aliens.each{|a|
        a.react_to :increase_speed
        a.react_to :drop_down
        a.react_to :reverse_direction
      }
    end

    if max_y > @player.y 
      you_lose
    end
  end

  def you_lose
    if @player.alive?
      sound_manager.play_sound :player_death
      create_actor :label, :text => "YOU LOSE!", :x => 150, :y => 100, :size => 90
      @player.remove
      add_timer :you_lose, 1_500 do
        fire :prev_stage
      end
    end
  end

  def update(time)
    super
    rebuild_bounding_box

    if @aliens.empty?
      @player.remove
      if backstage[:wave] == 3
        fire :next_stage 
      else
        fire :restart_stage 
      end
    end
  end

  def add_timer(*args, &blk)
    timer_manager.add_timer *args, &blk
  end
end

