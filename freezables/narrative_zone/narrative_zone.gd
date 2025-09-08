extends Node2D

@export var dialogue : DialogueResource

var _balloon


func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass

func _on_dialogue_ended(resource : DialogueResource):
	if resource == dialogue:
		$FreezableComponent.toggle_freeze()

func _on_frozen_visual_component_setup_finished() -> void:
	$FreezableComponent/FrozenVisualComponent.override_param("effect_intensity",0.7)
	_force_frozen_state()

func _on_freezable_component_on_freeze_toggle(is_frozen:bool) -> void:
	if not dialogue:
		return
	if not is_frozen and $FreezableComponent/VisibleOnScreenEnabler2D.is_on_screen():
		$Bonfire.play()
		# await get_tree().create_timer(0.4).timeout
		_balloon = DialogueManager.show_dialogue_balloon(dialogue,"start")
	
func _force_frozen_state():
	await get_tree().process_frame
	$FreezableComponent.frozen = true
	$FreezableComponent/FrozenVisualComponent.enable_visual()

func _on_freezable_component_on_restart() -> void:
	_force_frozen_state()
	pass # Replace with function body.
