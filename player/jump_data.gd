extends Resource
class_name JumpData

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float


var _jump_velocity : float = 0 
var _jump_gravity : float = 0 
var _fall_gravity : float = 0 


func get_jump_velocity() -> float:
    if _jump_velocity == 0:
        _jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
    return _jump_velocity

func get_jump_gravity() -> float:
    if _jump_gravity == 0:
        _jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1.0
    return _jump_gravity

func get_fall_gravity() -> float:
    if _fall_gravity == 0:
       _fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1.0
    return _fall_gravity