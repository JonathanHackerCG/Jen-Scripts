/// @desc Initialize
randomize();

room_goto(rm_main);
jen_example_dungeon_init();

function clear_room()
{
	with (all)
	{
		if (!persistent)
		{
			instance_destroy();
		}
	}
	
	var _tilemap = layer_get_id("Tiles");
	_tilemap = layer_tilemap_get_id(_tilemap);
	tilemap_clear(_tilemap, 0);
	
	var _background = layer_background_get_id(layer_get_id("Background"));
	layer_background_blend(_background, c_black);
}

maze = noone;