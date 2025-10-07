extends StaticBody3D

var arr = [$monsterposition1, $monsterposition2, $monsterposition3]
var idx = randi_range(0, arr.size() - 1)
print(arr[idx])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
