# OMG Aliens

## generate the app

1. gem install gamebox
1. gamebox new omg_aliens
1. cd omg_aliens
1. bundle
1. rake

The game should run with a small red box being drawn. Hit ESC to exit.


## create the player:
#### demo_stage.rb
        define_stage :demo do
          setup do
            @player = create_actor :player, x: 200, y: 550
          end
        end

This code defines a stage called `:demo` and creates the player actor. `x` and `y` will be added to player as observable attributes and will have the initial values specified.        
        

#### player.rb

        define_actor :player do
          has_behaviors do
            graphical
          end
        end

Here we are defining the `:player` actor. We can setup attributes and behaviors here. We have specified that this actor has only the `graphical` behavior. `graphical` ships with Gamebox and just draws an image at the location of this actor. It looks for `data/graphics/{actor_type}.png` to draw. So, place `player.png` in `data/graphics`.  
The game should run and there should be a ship that does nothing near the bottom of the screen.


## player movement

To make the player move, we will need to collect input and update the player's position. Let's start off by creating `mover` behavior in `src/behaviors`.

#### mover.rb

        define_behavior :mover do
          requires :input_manager
            setup do
              actor.has_attributes :move_left, :move_right
              input_manager.while_pressed KbLeft, actor, :move_left
              input_manager.while_pressed KbRight, actor, :move_right
             end
          end
        end





### add aliens
### make the aliens move
### player shoots (collisions)
### aliens shoot (timers)
### lose conditions
### score
### sounds effects and music
### handle waves (backstage)
### win conditions
### UFO (advance sounds)




