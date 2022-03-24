extends HBoxContainer

var indices = []
onready var parent = self.get_parent()
onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func raw_text_changed():
	indices = parent.convert_text_to_vals($TextEdit.text)
	$TextEdit2.text = parent.convert_vals_to_indices(indices)
	if not label.text.ends_with("*"):
		label.text += "*"


func indices_changed():
	indices = parent.convert_indices_to_vals($TextEdit2.text)
	$TextEdit.text = parent.convert_vals_to_text(indices)
	if not label.text.ends_with("*"):
		label.text += "*"

func clear_edits():
	if label.text.ends_with("*"):
		label.text = label.text.substr(0, label.text.length()-1)
