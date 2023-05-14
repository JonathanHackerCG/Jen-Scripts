/// @desc 

#region T - Manual Testing
if (keyboard_check_pressed(ord("T")))
{
	//Terrain Properties
	jen_grid_cellsize(16, 16);
	var w = 38; var h = 21;

	//Building Grid
	terrain = jen_grid_create(w, h, obj_grass);
	//jen_rectangle(terrain, 0, 0, w / 4, h - 1, obj_grass, obj_stone);
	
	//jen_rectangle(terrain, 3,  3, w - 4, h - 4, all, obj_stone, 2);
	//jen_rectangle(terrain, 11, 7, w - 1, h - 1, obj_grass, obj_dirt, 0);
	//jen_rectangle(terrain, 18, 0, 0, 18, [obj_dirt, obj_grass], [obj_water_light, obj_water], 5);
	//jen_rectangle(terrain, 0,  0, w - 1, h - 1, [obj_dirt, obj_grass, obj_water], [obj_stone, obj_wall], 0, 50, jen_function_sin);
	
	//jen_replace(terrain, [obj_dirt, obj_grass], [obj_water_light, obj_water]);
	//jen_replace_not(terrain, [obj_dirt, obj_grass, obj_water], obj_tree);
	
	//Instantiate Grid
	show_debug_message(jen_grid_string(terrain));
	jen_grid_instantiate_depth(terrain, 16, 8, 0);
	jen_grid_destroy(terrain);
}
#endregion
#region R - Restart
if (keyboard_check_pressed(ord("R")))
{
	room_restart();
}
#endregion
#region ESC - Close
if (keyboard_check_pressed(vk_escape))
{
	game_end();
}
#endregion
