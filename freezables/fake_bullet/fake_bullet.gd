extends Node2D

@export var speed : float = 10


func _do_setup() -> void:
	if not GlobalData.first_play:
		# $FreezableComponent.toggle_freeze()
		$FreezableComponent/FrozenVisualComponent.enable_visual()
		global_position = GlobalData.bullet_pos
		$Label.visible = false
		$FreezableComponent.queue_free()
	else:
		$Sprite2D.play()

func _on_toggle_freeze(_value):
	if GlobalData.first_play:
		GlobalData.bullet_pos = global_position
		GlobalData.first_play = false
	$Sprite2D.stop()


func _on_area_2d_body_entered(body:Node2D) -> void:
	if not get_node_or_null("FreezableComponent"):
		return

	if $FreezableComponent and $FreezableComponent.frozen:
		return
	
	if body is APlayer:
		body.die()
	pass # Replace with function body.
