extends Label

func _ready():
    if get_parent() is BetterInteractableComponent:
        get_parent().on_hover.connect(_on_hover)
        get_parent().on_leave.connect(_on_leave)
    visible = false

func _on_hover():
    visible = true
    pass

func _on_leave():
    visible = false
    pass
