extends Node2D


signal update_your_size(rect:Vector2)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed",_on_item_rect_changed)
	update_your_size.emit(get_viewport_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()


func _on_item_rect_changed():
	update_your_size.emit(get_viewport_rect().size)
