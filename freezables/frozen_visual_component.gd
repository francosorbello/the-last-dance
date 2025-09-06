extends Node

@export var material : ShaderMaterial
@export var visual : CanvasItem

var _material_instance : ShaderMaterial

var is_setup : bool = false
signal setup_finished

func _ready() -> void:
	await get_tree().process_frame
	if visual.material == null:
		_material_instance = material.duplicate()
		visual.material = _material_instance
	else:
		_material_instance = visual.material
	setup_finished.emit()
	is_setup = true
	disable_visual()

func enable_visual():
	_material_instance.set_shader_parameter("enabled",true)

func disable_visual():
	_material_instance.set_shader_parameter("enabled",false)

func override_param(param_name : String, value : Variant):
	_material_instance.set_shader_parameter(param_name,value)
