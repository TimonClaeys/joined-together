extends StaticBody2D
class_name GameButton

func _ready():
	var _discard = GameEvents.connect("game_button_pressed", self, "on_game_button_pressed")
	_discard = GameEvents.connect("game_button_released", self, "on_game_button_released")

func _on_Area2D_body_entered(body:Node) -> void:
	var _body = body
	GameEvents.emit_game_button_pressed(self)

func on_game_button_pressed(button: GameButton) -> void:
	if button == self:
		print("pressed")
		$AnimationPlayer.play("pressed")


func _on_Area2D_body_exited(body:Node) -> void:
	var _body = body
	GameEvents.emit_game_button_released(self)


func on_game_button_released(button: GameButton):
	if button == self:
		print("released")
		$AnimationPlayer.play("released")
