extends Node

@export var first_room : String

@export var room_list : Array[PackedScene]

var current_room : Node
var current_room_name : String 
var current_room_scene : PackedScene

signal room_changed(from : String, to :String)

func _ready() -> void:
    await get_tree().process_frame
    if not first_room.is_empty():
        switch_to(first_room)
    pass

func switch_to(room : String):
    var room_scene = get_room(room)
    if not room_scene:
        push_error("No room named %s"%room)
        return
    
    var prev_room_name := ""
    if current_room:
        current_room.queue_free()
        prev_room_name = current_room_name
    
    current_room_name = room
    room_changed.emit(prev_room_name,current_room_name)
    spawn_room.call_deferred(room_scene)

func spawn_room(room_scene):
    current_room = room_scene.instantiate()
    get_tree().root.add_child(current_room)    

    for child in current_room.get_children():
        if child is SwitchRoomArea:
            child.on_switch_to.connect(_on_switch_to)
    teleport_player()

func teleport_player():
    var spawn_pos : SpawnPosition
    for child in current_room.get_children():
        if child.is_in_group("spawn_position"):
            spawn_pos = child
    
    if spawn_pos:
        var a_player = get_tree().get_first_node_in_group("player") as APlayer
        a_player.global_position = spawn_pos.global_position
        if spawn_pos.use_jump:
            a_player.do_jump()

# func setup_room():
#     for child in current_room.get_children():
#         if child is SwitchRoomArea

func get_room(room_name : String) -> PackedScene:
    for room in room_list:
        if get_name_from_path(room.resource_path) == room_name:
            return room
    return null

func get_name_from_path(path : String) -> String:
    var split_path = path.split("/")
    var resource_name = split_path[split_path.size()-1]
    var split_resouce_name = resource_name.rstrip(".tscn")
    return split_resouce_name 

func _on_switch_to(room_name : String):
    switch_to(room_name)