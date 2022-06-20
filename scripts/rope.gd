extends Node2D

var _rope_piece =  preload("res://scenes/rope_end_piece.tscn")
var piece_length := 0.4

onready var rope_start_piece = $RopeStartPiece
onready var rope_end_piece = $RopeEndPiece

var rope_parts := []

var rope_close_tolerence := 0.4

func spanw_rope(start_pos: Vector2, end_pos: Vector2) -> void:
	rope_start_piece.global_position = start_pos
	rope_end_piece.global_position = end_pos

	start_pos = rope_start_piece.get_node("CollisionShape2D/PinJoint2D").global_position
	end_pos = rope_end_piece.get_node("CollisionShape2D/PinJoint2D").global_position

	var distance := start_pos.distance_to(end_pos)
	var pieces_amount = round(distance / piece_length)
	var spawn_angle = (end_pos - start_pos).angle() - PI / 2
	create_rope(pieces_amount, rope_start_piece, end_pos, spawn_angle)


func create_rope(piece_amount, parent: Object, end_pos: Vector2, spawn_angle: float) -> void:
	for i in piece_amount:
		parent = add_piece(parent, i, spawn_angle)
		parent.set_name("rope_piece_" + str(i))
		rope_parts.append(parent)

		var joint_pos = parent.get_node("CollisionShape2D/PinJoint2D").global_position
		if joint_pos.distance_to(end_pos) < rope_close_tolerence:
			break
	
	rope_end_piece.get_node("CollisionShape2D/PinJoint2D").node_a = rope_end_piece.get_path()
	rope_end_piece.get_node("CollisionShape2D/PinJoint2D").node_b = rope_parts[-1].get_path()


func add_piece(parent: Object, id: int, spawn_angle: float) -> Object:
	var joint = parent.get_node("CollisionShape2D/PinJoint2D")
	var piece: Object = _rope_piece.instance() as Object
	piece.position = joint.global_position
	piece.rotation = spawn_angle
	piece.parent = self
	piece.id = id
	add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	return piece
