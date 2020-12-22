tool
class_name MitigateIK3D
extends Position3D

export var IK_target := NodePath("..")
export var active := false setget set_active
export var scene_root := NodePath("..")


func set_active(val):
	active = val
	set_process(val)

func _process(delta):
	var root = get_node(scene_root) as Spatial
	var root_rotation = root.rotation
	root.rotation = Vector3.ZERO
	var target_node = get_node(IK_target) as Spatial
	var pos = get_transform()
	pos.origin += root.get_global_transform().origin
	target_node.set_global_transform(pos)
	root.rotation = root_rotation
