extends Node

@export var important_scenes : Dictionary[String, PackedScene]
var collectables : Array[String]

func add_collectable(collectable : String):
    if not collectables.has(collectable):
        collectables.append(collectable)

func switch_to_scene(scene_name : String):
    if important_scenes.has(scene_name):
        get_tree().change_scene_to_packed(important_scenes[scene_name])
    else:
        push_error("No scene named %s"%scene_name)