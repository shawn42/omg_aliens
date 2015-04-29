define_behavior :shooter do
  requires :input_manager, :stage
  requires_behaviors :positioned
  setup do
    actor.has_attributes can_shoot: true
    reacts_with :shoot
  end

  helpers do
    def shoot
      if actor.can_shoot?
        actor.can_shoot = false

        actor.react_to :play_sound, :shoot
        ammunition = stage.create_actor opts[:shoots], x: actor.x, y: actor.y
        ammunition.when :remove_me do 
          actor.can_shoot = true
        end

      end
    end
  end
end
