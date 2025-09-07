extends CharacterBody2D
class_name APlayer

signal dead

@export var jump_data : JumpData
@export var player_data : PlayerData

@export var debug_jump_enabled : bool = false
@export var flip_h : bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var checkpoint_manager : Node

var _initial_pos : Vector2

func _ready():
	$Sprite2D.flip_h = flip_h
	checkpoint_manager = get_tree().get_first_node_in_group("checkpoint_manager")
	if not checkpoint_manager:
		_initial_pos = global_position
	
	await get_tree().create_timer(0.1).timeout
	global_position = _get_respawn_point()	

func _unhandled_input(event):
	if event.is_action_pressed("jump") and debug_jump_enabled:
		$StateMachine.transition_to("JumpingState")
	if event.is_action_pressed("freeze"):
		do_freeze()

func _physics_process(_delta: float) -> void:
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

func get_gravity_data():
	if gravity < 0:
		return jump_data.get_jump_gravity()
	
	return jump_data.get_fall_gravity()

func do_freeze():
	$FreezeSound.play()
	for freezable in get_tree().get_nodes_in_group("freezable"):
		if freezable.has_method("toggle_freeze"):
			freezable.toggle_freeze()

func do_jump():
	$StateMachine.transition_to("JumpingState")

func can_be_attached() -> bool:
	return true

func attach_to_belt():
	$StateMachine.transition_to("BeltingState")

func detach_from_belt():
	$StateMachine.transition_to("FallingState")

#region Animations
func play_idle_anim():
	$AnimationPlayer.play("idle")

func play_jump_anim():
	$AnimationPlayer.play("jump")

func play_fall_anim():
	$AnimationPlayer.play("fall")

func play_run_anim():
	$AnimationPlayer.play("run")
#endregion

func die():
	_on_hurt_area_damage_taken()

func _on_hurt_area_damage_taken() -> void:
	global_position = _get_respawn_point()
	$DeadAnimPlayer.play_anim($Sprite2D)
	$DeadSound.play()
	dead.emit()
	pass # Replace with function body.

func _get_respawn_point():
	if checkpoint_manager:
		return checkpoint_manager.get_checkpoint_position()
	return _initial_pos
