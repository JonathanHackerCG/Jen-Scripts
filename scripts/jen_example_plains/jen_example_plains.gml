/// @func jen_example_plains
/// @desc A field with boulders and flowers.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_plains(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new Jen-Grid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_grass);
	
	//Creating walls around the border.
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, all, obj_borderstone, true);
	jen_rectangle(_terrain, 1, 1, _cellsw - 2, _cellsh - 2, all, obj_borderstone, true, 50);
	
	//Instantiate the terrain.
	jen_grid_instantiate_layer(_terrain, _x1, _y1, "Instances");
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
}