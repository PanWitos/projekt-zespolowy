extends CenterContainer

export var id = 0

func _on_TextureRect_mouse_entered():
	SignalBus.emit_signal("AbilityMouseOver", id)
