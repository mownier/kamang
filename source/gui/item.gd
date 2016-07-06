
extends TextureFrame

var drag_enabled = true

func _ready():
	pass

func enable_drag(enable):
	drag_enabled = enable

func get_drag_data(pos):
	if drag_enabled:
		var icon = TextureFrame.new()
		var image = get_texture().get_data()
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		icon.set_texture(texture)
		set_drag_preview(icon)
		return self

func can_drop_data(pos, data):
	return true

func drop_data(pos, data):
	var pos = get_pos()
	set_pos(data.get_pos())
	data.set_pos(pos)
	
	var p1 = get_parent()
	var p2 = data.get_parent()
	if p1.get_name() != p2.get_name():
		p1.remove_child(self)
		p2.remove_child(data)
		p1.add_child(data)
		p2.add_child(self)
		
		var menu = p1.get_parent()
		menu.on_change_item(self, data)
