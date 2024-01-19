extends Label

var fps_value:int
var x_delta:int
var y_delta:int
var color:Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "fps: {}, x_delta: {}, y_delta: {}".format([fps_value,x_delta,y_delta],"{}")
	add_theme_color_override("font_color",color)
	var new_sb = StyleBoxFlat.new()
	new_sb.bg_color = Color.BLACK
	add_theme_stylebox_override("normal", new_sb)

func _on_spider_layer_update_fps(fps_value_in, x_delta_in, y_delta_in, color_in):
	fps_value = fps_value_in
	x_delta = x_delta_in
	y_delta = y_delta_in
	color = color_in
