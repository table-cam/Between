extends CanvasLayer

var INVSIZE = 18

var itemLoad = [
	"res://Items/Sword.tres",
	"res://Items/Bow.tres"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in INVSIZE:
		var slot := InventorySlot.new()
		slot.init(Vector2(64, 64))
		%items.add_child(slot)
		
	for i in itemLoad.size():
		var item := InventoryItem.new()
		item.init(load(itemLoad[i]))
		%items.get_child(i).add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
