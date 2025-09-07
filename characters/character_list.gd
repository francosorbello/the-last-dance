extends Resource
class_name CharacterList

@export var characters : Array[CharacterInfo]
@export var blank_portrait : Texture

func get_portrait_for(character : String) -> Texture:
    for ch in characters:
        if ch.character_name == character or ch.code_name == character:
            return ch.portrait
    
    return blank_portrait

func get_voice_for(character : String) -> AudioStream:
    for ch in characters:
        if ch.character_name == character or ch.code_name == character:
            return ch.voice
    return null