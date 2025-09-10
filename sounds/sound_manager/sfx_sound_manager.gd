extends Node

@export var gunshot_sound : AudioStream

func play_gunshot():
	play_sfx(gunshot_sound)

func play_sfx(stream : AudioStream):
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
