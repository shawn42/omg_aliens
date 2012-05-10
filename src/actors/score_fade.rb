define_actor :score_fade do
  # label fader behavior
  behavior do
    requires :director, :stage
    setup do
      actor.has_attributes initial_ttl: actor.ttl,
                           label: stage.create_actor(:label, actor.attributes.merge(text: actor.score, layer: 99))

      director.when :update do |time|
        actor.ttl -= time
        if actor.ttl <= 0
          actor.remove 
        else
          percent_time_left = actor.ttl / actor.initial_ttl.to_f
          color_val = 255 * percent_time_left
          actor.label.color = Color.new color_val, color_val, color_val, color_val
        end
      end
      actor.when :remove_me do
        director.unsubscribe_all self
        actor.label.remove
      end
    end
    
  end
end

