extends PlayerState

var _anchor_point : Node2D:
	set(value):
		_anchor_point = value

func receive_message(msg : Dictionary):
	if msg.has("anchor_point"):
		_anchor_point = msg["anchor_point"]
	

func enter():
	player.velocity = Vector2.ZERO
	player.play_fall_anim()

func exit():
	_anchor_point = null

func physics_update(_delta: float):
	if _anchor_point != null:
		player.global_position = _anchor_point.global_position
