extends PlayerState

var launch_velocity : Vector2 = Vector2(1,0)

func enter():
    $AudioStreamPlayer.play()
    $Timer.start(0.23)
    player.velocity.y += player.jump_data.get_jump_velocity() / 4
    player.velocity.x = player.player_data.move_speed * 1.2
    # state_machine.transition_to("FallingState")

func exit():
    $Timer.stop()
    player.velocity = Vector2.ZERO

func physics_update(_delta):
    player.velocity.y += player.jump_data.get_fall_gravity() * _delta
    player.move_and_slide()
#     player.velocity += launch_velocity * player.player_data.move_speed
#     player.move_and_slide()

func _on_timer_timeout() -> void:
    state_machine.transition_to("FallingState")
    pass # Replace with function body.
