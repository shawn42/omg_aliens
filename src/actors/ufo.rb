define_actor :ufo do
  has_behaviors :graphical, :audible
  has_behaviors projectile: { speed: 0.12, direction: vec2(1, 0) }
  has_behaviors collidable: {:shape => :circle, :radius => 10}
  # TODO clean up viewport access?
  has_behaviors in_bounds_or_death: {bounds: [0,0,:viewport_width,:viewport_height]}

  behavior do
    setup do
      actor.react_to :play_sound, :ufo_flying, repeat: -1
      actor.when :remove_me do
        actor.react_to :stop_sound, :ufo_flying
      end
    end
  end
end
