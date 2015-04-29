define_behavior :keyboard_shooting do
  requires :input_manager, :director
  setup do
    actor.has_attributes should_shoot: false
    input_manager.while_pressed KbSpace, actor, :should_shoot
    # input_manager.reg :keyboard_down, KbSpace do
    #   actor.react_to :shoot
    # end
    director.when :update do |time|
      # TODO add sleep counter here
      actor.react_to :shoot if actor.should_shoot
    end
  end

  remove do
    director.unsubscribe_all self
  end
end
