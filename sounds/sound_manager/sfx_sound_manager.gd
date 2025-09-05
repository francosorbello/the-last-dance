extends Node

func play_sfx(stream : AudioStream):
    $AudioStreamPlayer.stream = stream
    $AudioStreamPlayer.play()