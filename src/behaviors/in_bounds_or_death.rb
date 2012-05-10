define_behavior :in_bounds_or_death do
  requires :director, :viewport
  setup do

    bounds = opts[:bounds].map do |v| 
      if v == :viewport_width
        viewport.width
      elsif v == :viewport_height
        viewport.height
      else
        v
      end
    end

    actor.has_attributes safe_bounds: Rect.new(bounds)

    director.when :update do |time|
      actor.remove unless actor.safe_bounds.collide_point? actor.x, actor.y
    end
    actor.when :remove_me do
      director.unsubscribe_all self
    end
  end
end
