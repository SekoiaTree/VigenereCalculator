extends TextEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var regex = RegEx.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("text_changed", self, "text_changed")
	regex.compile("[0-9 ]")

func text_changed():
	var cursor_column = cursor_get_column()
	var i = 0
	var final_text = ""
	for x in text:
		if regex.search(x) != null:
			final_text += x
		elif i <= cursor_get_column():
				cursor_column -= 1
		i += 1
	text = final_text
	cursor_set_column(cursor_column)
