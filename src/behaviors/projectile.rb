define_behavior :projectile do
  requires_behaviors :positioned

  requires :director
  setup do
    actor.has_attributes direction: opts[:direction].dup,
                         speed: opts[:speed]

    director.when :update do |time|
      move_vector = actor.direction * time * actor.speed
      actor.x += move_vector.x
      actor.y += move_vector.y
    end
  end
end

