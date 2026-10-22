extends Node
class_name Global
enum directions {LEFT, RIGHT, UP, DOWN}
enum colors {GREEN, RED, YELLOW}

func is_node_of_class(node: Node, class_string: String) -> bool:
	var is_instance := false
	if node.get_script():
		if node.get_script().get_global_name() == class_string:
			is_instance = true
	if node.is_class(class_string): # Keep this check in for built-in classes
		is_instance = true
	return is_instance
