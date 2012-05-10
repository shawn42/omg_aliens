define_behavior :increasing_speed do
  requires :backstage
  setup do
    actor.has_attributes speed: 0, accel: 0
    reacts_with :increase_speed
  end

  helpers do
    def increase_speed
      actor.speed += actor.accel * backstage[:wave]
    end
  end
end
