extends RichTextLabel

# needs a new variable so the setter is called (you can't override parent setters in Godot)
export(String, MULTILINE) var bbcode_with_images = "" setget set_bbcode_with_images
var textures = []

# the setter loads the images and sets bbcode_text afterwards
func set_bbcode_with_images(value):
	bbcode_with_images = value
	# loading all necessary images needs to be done before setting the bbcode_text
	load_images_in_text()
	# setting the bbcode_text makes the RichTextLabel try and load necessary images
	bbcode_text = value

func load_images_in_text():
	var re = RegEx.new()
	# this finds all img tags in the bbcode and makes the image path easily accessible in code
	re.compile("\\[img.*\\](?P<path>.*)\\[\\/img\\]")
	var imgs = re.search_all(bbcode_with_images)
	for img in imgs:
		var path = img.get_string("path")
		# check that file exists
		var file = File.new()
		if not file.file_exists(path):
			continue
		# this calls our custom loader to load the image resource into the resource cache
		var texture = ResourceLoader.load(path, "ImageTexture")
		if texture is ImageTexture:
		# the resource seems to need to be persistent, so we store it in the textures attribute
			textures.append(texture)
