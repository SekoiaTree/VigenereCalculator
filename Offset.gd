extends VBoxContainer

onready var error_message = self.get_parent().get_child(1)

func _ready():
	pass # Replace with function body.

func convert_text_to_vals(x : String):
	var array : PoolIntArray = []
	for i in x:
		array.append(ord(i)-0x61)
	return array

func convert_vals_to_text(x: PoolIntArray):
	var text = ""
	for i in x:
		text += char(i+0x61)
	return text

func convert_vals_to_indices(x : PoolIntArray):
	var text = ""
	for i in x:
		text += str(i)+" "
	return text.substr(0, text.length()-1)

func convert_indices_to_vals(x: String):
	var split = x.split(" ")
	var array : PoolIntArray = []
	for i in split:
		array.append(int(i))
	return array


func calculate_text():
	error_message.text = ""
	var ciphervals : PoolIntArray = $Ciphertext.indices
	var offsets : PoolIntArray = $Offsets.indices
	var text_indices = []
	for i in ciphervals.size():
		text_indices.append((ciphervals[i]-offsets[i%offsets.size()]+26)%26)
	$Text.indices = text_indices
	$Text/TextEdit.text = convert_vals_to_text(text_indices)
	$Text/TextEdit2.text = convert_vals_to_indices(text_indices)
	clear_edits()


func calculate_offsets():
	var text_indices : PoolIntArray = $Text.indices
	var ciphervals : PoolIntArray = $Ciphertext.indices
	if text_indices.size() != ciphervals.size():
		error_message.text = "Text and cipher are not the same size!"
		return
	else:
		error_message.text = ""
	var offsets = []
	for i in text_indices.size():
		offsets.append((ciphervals[i]-text_indices[i]+26) % 26)
	$Offsets.indices = offsets
	$Offsets/TextEdit.text = convert_vals_to_text(offsets)
	$Offsets/TextEdit2.text = convert_vals_to_indices(offsets)
	clear_edits()


func calculate_ciphertext():
	error_message.text = ""
	var text_indices : PoolIntArray = $Text.indices
	var offsets : PoolIntArray = $Offsets.indices
	var ciphervals = []
	for i in text_indices.size():
		ciphervals.append((text_indices[i]+offsets[i % offsets.size()]) % 26)
	$Ciphertext.indices = ciphervals
	$Ciphertext/TextEdit.text = convert_vals_to_text(ciphervals)
	$Ciphertext/TextEdit2.text = convert_vals_to_indices(ciphervals)
	clear_edits()

func clear_edits():
	$Text.clear_edits()
	$Ciphertext.clear_edits()
	$Offsets.clear_edits()
