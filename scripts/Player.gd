extends KinematicBody2D

onready var anim = $AnimatedSprite

var velocity = Vector2()
export var speed = 500
export var gravity = 500
export var impulse = -500
var is_jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	_ctrl_player()
	velocity = move_and_slide(velocity,Vector2(0,-1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_anim_player()

func _anim_player():
	if Input.is_action_pressed("ui_select") and is_on_floor():
		anim.play("jump")
		is_jumping = true
	elif is_jumping and !is_on_floor():
		anim.play("jumping")
	elif is_jumping and is_on_floor():
		anim.play("land")
		is_jumping = false
	elif Input.is_action_pressed("ui_left"):
		anim.play("run")
	elif Input.is_action_pressed("ui_right"):
		anim.play("run")
	else:
		anim.play("idle")

func _ctrl_player():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_select")
	
	velocity.x = 0
	if right:
		velocity.x += speed
		anim.flip_h = false
	if left:
		velocity.x -= speed
		anim.flip_h = true
	if jump and is_on_floor():
		velocity.y = impulse



