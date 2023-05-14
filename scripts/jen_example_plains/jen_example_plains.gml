/// @func jen_example_plains
/// @desc A field with boulders and flowers.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_plains(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new Jen-Grid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_grass);
	
	#region First Layer (Terrain)
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, all, obj_borderstone, true);
	jen_rectangle(_terrain, 1, 1, _cellsw - 2, _cellsh - 2, all, obj_borderstone, true, 50);
	
	//Instantiate the first layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	#endregion
	#region Second Layer (Decorations)
	jen_replace_not(_terrain, obj_grass, noone); //Remove everything except grass.
	
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, obj_grass, obj_tree, false, 20);
	
	//Instantiate the second layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_2)
	#endregion
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
}