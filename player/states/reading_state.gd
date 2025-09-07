extends PlayerState

func enter():
    player.velocity = Vector2.ZERO
    player.play_idle_anim()
    player.get_node("Sprite2D").modulate = Color.from_string("3e3e3e", Color.RED)

func exit():
    player.get_node("Sprite2D").modulate = Color.WHITE


