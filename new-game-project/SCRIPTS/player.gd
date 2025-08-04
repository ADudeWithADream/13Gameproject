extends CharacterBody3D

@onready var TransitionCamera: Camera3D = $TransitionCamera
@onready var selected_camera: Camera3D = $Camera01

var TransitionTween: Tween
var TransitionFOVTween: Tween
var SpecializedTransition = false

var LightOn = false

func _ready() -> void:
	$TransitionCamera.make_current()
	_change_camera($Camera01)


func _input(event: InputEvent) -> void:

	
	if Input.is_action_just_pressed("ui_flashlight") and LightOn == false:
		$TransitionCamera/FLASHLIGHT.visible = true
	elif Input.is_action_just_pressed("ui_flashlight") and LightOn == true:
		$TransitionCamera/FLASHLIGHT.visible = false
		
	if $TransitionCamera/FLASHLIGHT.visible == true:
		LightOn = true
	elif $TransitionCamera/FLASHLIGHT.visible == false:
		LightOn = false
	



func _change_camera(desired_camera: Camera3D) -> void:
	
	_toggle_flashlight(false)
	
	if TransitionTween and SpecializedTransition == false:
		TransitionTween.kill()
	TransitionTween = create_tween()
	var target_transform: Transform3D = desired_camera.global_transform
	TransitionTween.tween_property(TransitionCamera, "global_transform", target_transform, 0.5).set_trans(Tween.TRANS_SINE)
	TransitionTween.tween_callback(_toggle_flashlight.bind(true))
	
	if TransitionFOVTween and SpecializedTransition == false:
		TransitionFOVTween.kill()
	TransitionFOVTween = create_tween()
	var target_FOV: float = desired_camera.fov
	TransitionFOVTween.tween_property(TransitionCamera, "fov", target_FOV, 0.5).set_trans(Tween.TRANS_SINE)
	
	if SpecializedTransition == true:
		TransitionTween.tween_property(TransitionCamera, "global_transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
		TransitionFOVTween.tween_property(TransitionCamera, "fov", target_FOV, 0.2).set_trans(Tween.TRANS_SINE)
	
	selected_camera = desired_camera

	


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_left") and selected_camera == $Camera01:
		SpecializedTransition = true
	elif Input.is_action_just_pressed("ui_right") and selected_camera == $Camera02:
		SpecializedTransition = true
	else:
		SpecializedTransition = false
	
	if Input.is_action_just_pressed("ui_left"):
		if selected_camera == $Camera01:
			_change_camera($Camera02)
		elif selected_camera == $Camera03:
			_change_camera($Camera01)
		elif selected_camera == $Camera02:
			_change_camera($Camera04)
		
	if Input.is_action_just_pressed("ui_right"):
		if selected_camera == $Camera01:
			_change_camera($Camera03)
		elif selected_camera == $Camera02:
			_change_camera($Camera01)
		elif selected_camera == $Camera04:
			_change_camera($Camera02)
		
	if Input.is_action_just_pressed("ui_down"):
		if selected_camera == $Camera01:
			_change_camera($Camera04)
		elif selected_camera == $Camera02:
			_change_camera($Camera04)
		elif selected_camera == $Camera04:
			_change_camera($Camera01)


func _toggle_flashlight(state: bool):
	$TransitionCamera/FLASHLIGHT.visible = state
	LightOn = state
