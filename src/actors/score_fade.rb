define_actor :score_fade do
  # label fader behavior
  behavior do
    requires :director, :stage
    setup do
      actor.has_attributes ttl: opts[:ttl],
                           initial_ttl: opts[:ttl],
                           label: stage.create_actor(:label, actor.attributes)

      director.when :update do |time|
        actor.ttl -= time
        actor.remove if actor.ttl <= 0
        percent_time_left = actor.ttl / actor.initial_ttl.to_f
        color_val = 255 * percent_time_left
        actor.label.color = Color.new color_val, color_val, color_val, color_val
      end
    end

    react_to do |msg, *args|
      @label.remove if msg == :remove
    end
    
  end
end

