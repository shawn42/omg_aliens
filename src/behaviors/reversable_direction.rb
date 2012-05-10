define_behavior :reversable_direction do
  setup do
    actor.has_attributes direction: vec2(0,0)
    reacts_with :reverse_direction
  end

  helpers do
    def reverse_direction
      # Ftor#reverse!
      actor.direction.reverse!
    end
  end
end
