extends Node2D

func _ready() -> void:
    if GlobalData.first_play:
        $GunSound.play()
    
    if GlobalData.collectables.has("corsier"):
        $GraySamuraiInteractable/BetterInteractableComponent2.is_interactable = false
        $GunInteractable/BetterInteractableComponent.is_interactable = true
    
    if GlobalData.collectables.has("gun"):
        $GunInteractable/BetterInteractableComponent.is_interactable = false
        $LoverInteractable/BetterInteractableComponent.is_interactable = true
        
