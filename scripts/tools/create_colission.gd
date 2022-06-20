extends Polygon2D
tool

export(bool) var update = false setget set_collision_polygon

func set_collision_polygon(value) -> bool:
	if value:
		value = false
		var collision_polygon = get_child(0).get_child(0) as CollisionPolygon2D
		var data = self.polygon
		collision_polygon.polygon = data;
		print(data)
	return false
