/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func jen_example_autotiles
/// @desc Autotiles, basically.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_autotiles(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, noone);
	jen_scatter(_terrain, noone, "tile", 50);
	jen_grid_scale(_terrain, 2, true);
	jen_grid_instantiate_autotile16(_terrain, _x1, _y1, "tile", true, "Tiles");
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
	
	var _background = layer_background_get_id(layer_get_id("Background"));
	layer_background_blend(_background, c_ltgray);
}