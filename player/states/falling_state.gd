extends PlayerState

func physics_update(delta : float):
	player.velocity.y += player.jump_data.get_fall_gravity() * delta
	
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		player.velocity.x = direction * player.player_data.move_speed
	else:
		player.velocity.x = move_toward(player.velocity.x,0,player.player_data.move_speed)
	
	player.move_and_slide()

	if player.is_on_floor():
		# jump buffer
		# if $JumpBufferTimer.time_left > 0:
		# 	state_machine.transition_to("JumpingState")
		# 	return
		if is_equal_approx(direction,0.0):
			state_machine.transition_to("IdleState")
		else:
			state_machine.transition_to("MovingState")