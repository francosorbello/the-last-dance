extends CharacterBody2D
class_name APlayer

@export var jump_data : JumpData
@export var player_data : PlayerData

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _unhandled_input(event):
	if event.is_pressed() and not event is InputEventMouse and event.keycode == KEY_J:
		$StateMachine.disabled = !$StateMachine.disabled

func _physics_process(_delta: float) -> void:
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

func get_gravity_data():
	if gravity < 0:
		return jump_data.get_jump_gravity()
	
	return jump_data.get_fall_gravity()

#region Animations
func play_idle_anim():
	$AnimationPlayer.play("idle")

func play_jump_anim():
	$AnimationPlayer.play("jump")

func play_fall_anim():
	$AnimationPlayer.play("fall")

func play_run_anim():
	$AnimationPlayer.play("run")
