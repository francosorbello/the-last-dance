extends PlayerState

func enter():
    player.play_idle_anim()

## Update the state on the physics stage.
func physics_update(delta: float):
    player.velocity.y += player.jump_data.get_fall_gravity() * delta
    player.move_and_slide()
    
    if not player.is_on_floor():
        state_machine.transition_to("FallingState")
    elif Input.is_action_just_pressed("jump"):
        state_machine.transition_to("JumpingState")
    elif Input.get_axis("move_left","move_right") != 0:
        state_machine.transition_to("MovingState")

