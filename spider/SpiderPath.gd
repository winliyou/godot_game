extends Node2D

var last_spider_position : Vector2
var current_spider_position : Vector2
var line_color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_line(last_spider_position,current_spider_position,line_color,1.0)

func _on_spider_layer_draw_spider_path(last_position:Vector2, current_position:Vector2, line_color:Color):
	#print("last_position: {} , current_position: {}".format([last_position,current_position],"{}"))
	self.last_spider_position = last_position
	self.current_spider_position = current_position
	self.line_color = line_color

