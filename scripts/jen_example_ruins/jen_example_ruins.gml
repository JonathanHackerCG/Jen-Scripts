/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func jen_example_ruins
/// @desc Scattered ruins of a stone structure.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_ruins(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_grass);
	
	#region Making a base ruin.
	var _ruin = jen_grid_create(5, 5, noone);
	jen_rectangle(_ruin, 0, 0, 4, 4, all, obj_stone, 1);
	
	#endregion
	#region First Layer (Terrain)
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, all, obj_borderstone, 1);
	jen_rectangle(_terrain, 1, 1, _cellsw - 2, _cellsh - 2, all, obj_borderstone, 1, 50);
	
	jen_grid_apply(_terrain, _ruin, obj_grass, 0, 0, 80);
	
	//Instantiate the first layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	#endregion
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
	jen_grid_destroy(_ruin);
}