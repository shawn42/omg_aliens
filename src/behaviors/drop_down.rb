define_behavior :drops do
  setup do
    actor.has_attributes fall_amount: opts[:fall_amount]
    reacts_with :drop_down
  end

  helpers do
    def drop_down
      actor.y += actor.fall_amount
    end
  end
end
