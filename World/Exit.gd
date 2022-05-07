extends Area2D

export var code = "00000"

func _on_Exit_body_entered(body):
	SignalBus.emit_signal("LevelChange", code)
