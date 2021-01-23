tool
class_name MitigateIK3D
extends Position3D

export var IK_target := NodePath("..") # The node the SkeletonIK node targets
export var active := false setget set_active # Whether or not this node's active


func set_active(val):
	active = val
	set_process(val)


func _process(_delta):
	var global_scale := get_global_transform().basis.get_scale()
	var target_node := get_node(IK_target) as Spatial
	var pos : Transform = get_global_transform()
	var p_pos := get_parent_spatial().get_global_transform().origin
	if get_parent_spatial():
		pos.origin -= p_pos
	pos.origin /= global_scale
	if get_parent_spatial():
		pos.origin += p_pos
	target_node.set_global_transform(pos)
