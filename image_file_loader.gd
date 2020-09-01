tool
extends ResourceFormatLoader
class_name ImageFileLoader

var official_image_file_endings = ["bmp", "dds", "exr", "hdr", "jpg", "jpeg", "png", "tga", "svg", "svgz", "webp"]

func handles_type(typename: String):
	return typename == "ImageTexture"

func load(path, _original_path):
	var image = Image.new()
	var texture = ImageTexture.new()
	var err = image.load(path)
	if err != OK:
		printerr("Can't load image.")
		return err
	else:
		texture.create_from_image(image)
		texture.take_over_path(path) # this makes sure the RichTextLabel code finds the image resource it needs already loaded
		return texture

func get_resource_type(path):
	if path.get_extension() in official_image_file_endings:
		return "ImageTexture"
	else:
		return ""

func get_recognized_extensions():
	return PoolStringArray(official_image_file_endings)
