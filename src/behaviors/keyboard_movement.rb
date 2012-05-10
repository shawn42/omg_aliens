define_behavior :keyboard_movement do
  requires :input_manager
  setup do
    actor.has_attributes :move_left, :move_right
    i = input_manager
    i.while_pressed KbLeft, actor, :move_left
    i.while_pressed KbRight, actor, :move_right
  end
end
