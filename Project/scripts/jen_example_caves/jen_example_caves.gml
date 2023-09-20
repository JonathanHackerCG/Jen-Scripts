/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func jen_example_caves
/// @desc A natural looking cave.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_caves(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_dirt);
	
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, obj_dirt, obj_stone, 1);
	jen_scatter(_terrain, obj_dirt, obj_stone, 35);
	
	//Intantiation Example:
	//repeat (3)
	//{
	//	jen_example_caves_iterate(_terrain);
	//}
	//jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	
	return _terrain; //Return for iteration.
	//Must be instantiated separately.
}

function jen_example_caves_iterate(_terrain)
{
	jen_automata(_terrain, obj_stone, obj_dirt, true, [0, 1, 2], [4, 5, 6, 7, 8]);
	return _terrain; //Return for iteration.
	//Must be instantiated separately.
}