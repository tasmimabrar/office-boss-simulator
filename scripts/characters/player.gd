extends CharacterBody3D

# ─── Constants ────────────────────────────────────────────────────────────────
const SPEED: float = 5.0
const SPRINT_SPEED: float = 9.0
const JUMP_VELOCITY: float = 4.5
const MOUSE_SENSITIVITY: float = 0.002
const MAX_LOOK_ANGLE: float = PI / 2.2  # ~81.8 deg — prevents full vertical flip

# ─── Node References ──────────────────────────────────────────────────────────
@onready var _head: Node3D = $Head
@onready var _camera: Camera3D = $Head/Camera3D

# ─── Cached Physics State ─────────────────────────────────────────────────────
# Read once in _ready so we never call ProjectSettings in a hot path.
var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	# Mouse look — only when pointer is captured.
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		_head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		_head.rotation.x = clamp(_head.rotation.x, -MAX_LOOK_ANGLE, MAX_LOOK_ANGLE)

	# Release pointer with Escape; recapture with a click.
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement()
	move_and_slide()


# ─── Private Helpers ──────────────────────────────────────────────────────────

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta


func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func _handle_movement() -> void:
	# get_vector batches four digital inputs into a single normalized 2D vector.
	# This avoids four separate Input.is_action_pressed() calls per frame.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")

	# Project the 2D input onto the character's horizontal facing plane.
	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	var speed := SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		# Decelerate smoothly instead of snapping to zero.
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)
