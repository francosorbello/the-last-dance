extends Node2D

@export var speed : float = 10


func _do_setup() -> void:
	if not GlobalData.first_play:
		$FreezableComponent.toggle_freeze()
		global_position = GlobalData.bullet_pos
		$Label.visible = false

func _on_toggle_freeze(_value):
	if GlobalData.first_play:
		GlobalData.bullet_pos = global_position
		GlobalData.first_play = false


func _physics_process(delta):
	if $FreezableComponent.frozen:
		return
	
	global_position.x += speed * delta



func _on_area_2d_body_entered(body:Node2D) -> void:
	if $FreezableComponent.frozen:
		return
	
	if body is APlayer:
		GlobalData.secret_ending()
	pass # Replace with function body.
