tool
class_name MitigateIK3D
extends Position3D

export var IK_target := NodePath("..") # The node the SkeletonIK node targets
export var active := false setget set_active # Whether or not this node's active
export var scene_root := NodePath("..") # The root of the scene (Usually where movement and rotation takes place)
export var model_root := NodePath("..") # (Optional) The model's root node, useful for if the model is rotated


func set_active(val):
	active = val
	set_process(val)

func _process(delta):
	var root = get_node(scene_root) as Spatial
	var root_rotation = root.rotation
	var model_rotation
	var mdl
	if not model_root.is_empty():
		mdl = get_node(model_root)
		model_rotation = mdl.rotation
		mdl.rotation = Vector3.ZERO
	root.rotation = Vector3.ZERO
	var target_node = get_node(IK_target) as Spatial
	var pos = get_transform()
	pos.origin += root.get_global_transform().origin
	target_node.set_global_transform(pos)
	root.rotation = root_rotation
	if not model_root.is_empty():
		mdl.rotation = model_rotation
