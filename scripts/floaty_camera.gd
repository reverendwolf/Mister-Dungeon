extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const LOOK_SPEED = 0.5

var c_look = Vector2.ZERO

var savePosition = Vector3.ZERO
var saveRotation = Quaternion.IDENTITY

func _ready():
	save_current_position()

func _physics_process(delta):
	var move_input = Input.get_vector("left","right","forward","backward")
	var look_input = Input.get_vector("lookLeft","lookRight","lookUp","lookDown")
	
	if Input.is_action_just_pressed("savePos"):
		save_current_position()
		
	if Input.is_action_just_pressed("loadPos"):
		load_saved_position()
		
	var speed = SPEED * 3 if Input.is_action_pressed("run") else SPEED
	
	if look_input:
		c_look.x = clamp(c_look.x + look_input.x * delta, -1.0,1.0);
		c_look.y = clamp(c_look.y + look_input.y * delta, -1.0,1.0);
	else:
		c_look.x = lerp(c_look.x, 0.0, delta)
		c_look.y = lerp(c_look.y, 0.0, delta)
		
	if c_look:
		rotate(Vector3.UP, deg_to_rad(-c_look.x) * LOOK_SPEED)
		rotate(transform.basis.x, deg_to_rad(-c_look.y) * LOOK_SPEED)

	rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))

	if move_input:
		velocity += ((transform.basis.z * move_input.y) + (transform.basis.x * move_input.x)) * speed * delta
#		velocity += transform.basis.x * move_input.x * SPEED * delta
	else:
		velocity = lerp(velocity, Vector3.ZERO, delta * 4.0)

	move_and_slide()

func save_current_position():
	savePosition = position
	saveRotation = rotation
	
func load_saved_position():
	position = savePosition
	rotation = saveRotation
	velocity = Vector3.ZERO
	c_look = Vector2.ZERO
