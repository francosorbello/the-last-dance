extends Node

@export var material : ShaderMaterial
@export var visual : CanvasItem
@export var override_params : Dictionary[String,Variant]

var _material_instance : ShaderMaterial

var is_setup : bool = false
signal setup_finished

func _ready() -> void:
	await get_tree().process_frame
	if visual.material == null:
		_material_instance = material.duplicate()
		visual.material = _material_instance
	else:
		_material_instance = visual.material.duplicate()
		visual.material = _material_instance
	_set_overriden_params()
	disable_visual()
	setup_finished.emit()
	is_setup = true

func _set_overriden_params():
	for key in override_params.keys():
		override_param(key,override_params[key])

func enable_visual():
	_material_instance.set_shader_parameter("enabled",true)

func disable_visual():
	_material_instance.set_shader_parameter("enabled",false)

func override_param(param_name : String, value : Variant):
	_material_instance.set_shader_parameter(param_name,value)
	# visual.material = _material_instance
