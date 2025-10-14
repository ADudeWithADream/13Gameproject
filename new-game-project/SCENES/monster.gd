extends StaticBody3D

@export var array_parent: Node3D
var arr: Array[Node3D] = []
var idx = randi_range(0, arr.size() - 1)


#Runs through the data of each child node of the Node3D and adding them to the variable arr array.
func _ready() -> void:
	for point in array_parent.get_children():
		arr.append(point)


func _process(delta: float) -> void:
	#position = global_position == arr[idx].global_position
	pass


#every time the timer timesout it chooses the 
func _on_timer_timeout() -> void:
 # Replace with function body.
	idx = randi_range(0, arr.size() - 1)
	global_position = arr[idx].global_position
	rotation = arr[idx].rotation
	print("did it")
