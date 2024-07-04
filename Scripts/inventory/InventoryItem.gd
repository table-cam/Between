class_name InventoryItem
extends TextureRect

@export var data: ItemData

# Called when the node enters the scene tree for the first time.
func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tooltip_text = "%s\n%s" % [data.name, data.description]

func init(new_data: ItemData):
	data = new_data
