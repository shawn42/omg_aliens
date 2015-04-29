define_actor :ufo do
  has_behaviors do
    audible
    graphical          anchor: :top_left
    projectile         speed: 0.12, direction: vec2(1, 0)
    collidable         shape: :circle, radius: 10
    in_bounds_or_death bounds: [0,0,:viewport_width,:viewport_height]
    # TODO clean up viewport access?
  end

  behavior do
    setup do
      actor.react_to :play_sound, :ufo_flying, looping: true
      actor.when :remove_me do
        actor.react_to :stop_sound, :ufo_flying
      end
    end
  end
end
