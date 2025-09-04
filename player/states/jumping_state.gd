extends PlayerState


func enter():
    player.velocity.y = player.jump_data.get_jump_velocity()
    player.play_jump_anim()

func physics_update(delta : float):
    # print(player.velocity.y)
    player.velocity.y += player.jump_data.get_jump_gravity() * delta
    if player.velocity.y > 0:
        state_machine.transition_to("FallingState")
        return
    
    var direction = Input.get_axis("move_left","move_right")
    if direction:
        player.velocity.x = direction * player.player_data.move_speed
    else:
        player.velocity.x = move_toward(player.velocity.x,0,player.player_data.move_speed)

    player.move_and_slide()


