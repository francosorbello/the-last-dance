extends State
class_name PlayerState

var player : APlayer

func setup(s_owner, s_machine):
    super(s_owner, s_machine)
    if s_owner is APlayer:
        player = s_owner as APlayer
    else:
        push_error("State owner is not a player")