[RichTextLabels in Godot don't support loading images from the filesystem out of the box](https://github.com/godotengine/godot-proposals/issues/89).
This repo contains example code how to do this in GDScript.

First, a new [resource loader is registered](./image_file_loader.gd).
Then, [RichTextLabel is extended](./main.gd) such that when it's new attribute `bbcode_with_images` is set, all images are loaded using the above loader and only then the original `bbcode_text` attribute is set.
This way, the `bbcode_text` handler can find the loaded resources and displays them correctly.
