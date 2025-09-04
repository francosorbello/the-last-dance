extends CharacterBody2D
class_name APlayer

@export var jump_data : JumpData
@export var player_data : PlayerData

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _unhandled_input(event):
	if event.is_pressed() and not event is InputEventMouse and event.keycode == KEY_J:
		$StateMachine.disabled = !$StateMachine.disabled

func _physics_process(delta: float) -> void:
	if not $StateMachine.disabled:
		return
	# Add the gravity.
	# if not is_on_floor():
	velocity.y += get_gravity_data() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_data.get_jump_velocity()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * player_data.move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_data.move_speed)

	move_and_slide()

func get_gravity_data():
	if gravity < 0:
		return jump_data.get_jump_gravity()
	
	return jump_data.get_fall_gravity()
