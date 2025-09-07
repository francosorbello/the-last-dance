extends Node

@export var only_active_when_visible : bool
@export var start_frozen : bool
@export var debug : bool

var frozen : bool = false

signal on_freeze_toggle(is_frozen : bool)

var _frozen_visual_component : Node
var _on_screen_notifier : VisibleOnScreenNotifier2D

var _can_be_activated : bool = true:
	set(value):
		_can_be_activated = value
		if debug:
			print("---- %s ----"%value)
			print_stack()
			print("-----------")

func _ready():
	for child in get_children():
		if child.has_method("enable_visual"):
			_frozen_visual_component = child
			_frozen_visual_component.setup_finished.connect(_on_visual_setup_finished)
		if child is VisibleOnScreenEnabler2D and child.name != "VOSEnableAndDisappear" and only_active_when_visible:
			_setup_screen_notifier.call_deferred(child)

func _on_visual_setup_finished():
	if start_frozen:
		_can_be_activated = true
		toggle_freeze()
		_can_be_activated = !only_active_when_visible


func _setup_screen_notifier(notifier : VisibleOnScreenNotifier2D):
	_can_be_activated = false            
	_on_screen_notifier = notifier
	_on_screen_notifier.screen_entered.connect(_on_screen_entered)
	_on_screen_notifier.screen_exited.connect(_on_screen_exited)
	_on_screen_notifier.global_position = get_parent().global_position

func _on_screen_entered():
	_can_be_activated = true

func _on_screen_exited():
	_can_be_activated = false

func restart():
	frozen = true
	_can_be_activated = true
	toggle_freeze()
	_can_be_activated = _on_screen_notifier.is_on_screen()	

func toggle_freeze():
	if debug:
		print("toggle freeze on %s"%get_parent().name)
		print(_can_be_activated,",",frozen)
	if not _can_be_activated:
		return

	frozen = !frozen
	on_freeze_toggle.emit(frozen)
	if _frozen_visual_component:
		if frozen:
			_frozen_visual_component.enable_visual()
		else:
			_frozen_visual_component.disable_visual()
