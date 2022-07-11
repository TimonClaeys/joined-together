extends Line2D

export(NodePath) onready var player = get_node(player) as Player
export(NodePath) onready var object = get_node(object) as RigidBody2D

func _process(delta):
	set_point_position(0, player.global_position)
	set_point_position(1, object.global_position)
	var distance := get_point_position(0).distance_to(get_point_position(1))
	if distance > 1000:
		GameEvents.emit_signal("too_far")
