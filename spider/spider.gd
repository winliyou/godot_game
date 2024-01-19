extends Node2D

var spider_sprite : Sprite2D
var spider_position : Vector2
var last_spider_position : Vector2
var direction : Vector2
var speed : float
var press_start : bool
var r : float
var g : float
var b : float
var fps_counter : int
var fps_value : int
var last_second_time : int
var elapsed_time : float
var spider_path_layer : SubViewport


# 这些参数必须在发出信号时传递。
signal draw_spider_path(last_spider_position:Vector2, current_spider_position:Vector2, line_color:Color)
signal update_fps(fps_value:int, x_delta:int, y_delta:int, color:Color)

@onready var hide_hud : bool = false
@onready var x_delta : int = 1
@onready var y_delta : int = 1

func _ready():
	spider_sprite=Sprite2D.new()
	spider_sprite.texture = preload("res://assets/image/spider.png")
	spider_position = Vector2(spider_sprite.texture.get_width()/2, spider_sprite.texture.get_height()/2)
	add_child(spider_sprite)
	spider_sprite.position = Vector2(spider_sprite.texture.get_width()/2, spider_sprite.texture.get_height()/2)
	direction = Vector2(1, 1)
	speed = 1.0
	press_start = false
	r = 0
	g = 1.0
	b = 0
	fps_counter = 0
	fps_value = 0
	last_second_time = 0
	elapsed_time = 0
	#DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	get_window().size = Vector2(1920,1080)
	spider_path_layer = get_node("/root/MainUi/SpiderPathLayer")

func _process(delta: float) -> void:
	elapsed_time += delta
	# 处理输入事件
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	# 处理按键事件
	if Input.is_action_just_pressed("start"):
		print("speace is pressed")
		press_start = not press_start
	if Input.is_action_just_pressed("change_color"):
		changeColor()
	if Input.is_action_just_pressed("accelerate_x"):
		print("x presed , x_delta: ",x_delta)
		if Input.is_key_pressed(KEY_SHIFT):
			x_delta += 1
		else:
			x_delta -= 1
	if Input.is_action_just_pressed("accelerate_y"):
		print("y is pressed , y_delta: ",y_delta)
		if Input.is_key_pressed(KEY_SHIFT):
			y_delta += 1
		else:
			y_delta -= 1
	if Input.is_action_just_pressed("hide_hud"):
		print("s is pressed , hide_hud: ",hide_hud)
		hide_hud = !hide_hud

	# 更新纹理位置
	if press_start:
		last_spider_position = spider_position		
		spider_position += Vector2(x_delta*direction.x,y_delta*direction.y)
		
		# 边界检测
	if spider_position.x > get_viewport_rect().size.x or spider_position.x < 0:
		direction.x *= -1
	if spider_position.y > get_viewport_rect().size.y or spider_position.y < 0:
		direction.y *= -1
	draw_spider_path.emit(last_spider_position,spider_position,Color(r,g,b,1.0))


	# 更新FPS计数器
	fps_counter += 1
	if elapsed_time > 1:
		fps_value = fps_counter
		fps_counter = 0
		elapsed_time -= 1
		update_fps.emit(fps_value, x_delta, y_delta,Color(r,g,b,1.0))
	queue_redraw()


func _draw():
	# 绘制线条
	var subviewport_texture = spider_path_layer.get_viewport().get_texture()
	draw_texture(subviewport_texture,Vector2(0,0))
	
	# 绘制纹理
	var rotate_angle = last_spider_position.angle_to_point(spider_position)
	spider_sprite.rotation = PI/2 + rotate_angle
	spider_sprite.position = spider_position
	#draw_texture(texture, spider_position)

func changeColor():
	r = randf_range(0.0,1.0)
	g = randf_range(0.0,1.0)
	b = randf_range(0.0,1.0)

func _on_main_ui_update_your_size(rect: Vector2):
	print("rect: ",rect)
	if spider_position.x > rect.x:
		spider_position.x = rect.x
	if spider_position.y > rect.y:
		spider_position.y = rect.y
	if last_spider_position.x > rect.x:
		last_spider_position.x = rect.x
	if last_spider_position.y > rect.y:
		last_spider_position.y = rect.y




func _on_set_random_color_timer_timeout():
	Input.action_press("change_color")
