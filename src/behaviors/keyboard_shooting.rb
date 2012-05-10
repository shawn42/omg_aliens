define_behavior :keyboard_shooting do
  requires :input_manager
  setup do
    input_manager.reg :keyboard_down, KbSpace do
      actor.react_to :shoot
    end
  end
end
