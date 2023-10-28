/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

function jen_example_dungeon_init()
{
	//Called once at game start to capture data in rm_example_dungeon.
	
	//Go to copy room and delay 1 frame to allow everything to load.
	room_goto(rm_example_dungeon);
	call_later(1, time_source_units_frames, function()
	{
		
		var cellsw = room_width / JEN_CELLW;
		var cellsh = room_height / JEN_CELLH;
		global.dungeon_data = jen_grid_copy_instances(0, 0, cellsw, cellsh, function(_inst)
		{
			return (_inst.object_index == obj_wall);
		});
		
		room_goto(rm_main); //Return to main room.
	});
}

/// @func jen_example_autotiles
/// @desc Autotiles, basically.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_dungeon(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh);
	jen_grid_paste(_terrain, global.dungeon_data, 0, 0, all);
	
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
}