extends Node2D

@export var starting_dialogue : DialogueResource

func _ready():
    await get_tree().create_timer(.8).timeout
    DialogueManager.show_dialogue_balloon(starting_dialogue,"start",[self])

func play_shot_anim():
    # $AudioStreamPlayer.play()
    SfxSoundManager.play_gunshot()
    GlobalData.switch_to_scene("hub")
