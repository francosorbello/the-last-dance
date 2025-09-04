extends PlayerState

func physics_update(delta : float):
    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("JumpingState")
        return
    if player.velocity.y > 0:
        state_machine.transition_to("FallingState")
        return
    
    player.velocity.y += player.jump_data.get_fall_gravity() * delta
    
    var direction = Input.get_axis("move_left","move_right")
    if direction:
        player.velocity.x = direction * player.player_data.move_speed
    else:
        player.velocity.x = move_toward(player.velocity.x,0,player.player_data.move_speed)

    player.move_and_slide()

    if is_equal_approx(player.velocity.x,0.0):
        state_machine.transition_to("IdleState") 
        return
