extends Node
signal game_button_pressed(game_button)
signal game_button_released(game_button)

func emit_game_button_pressed(game_button: GameButton) -> void:
	emit_signal("game_button_pressed", game_button)


func emit_game_button_released(game_button: GameButton) -> void:
	emit_signal("game_button_released", game_button)