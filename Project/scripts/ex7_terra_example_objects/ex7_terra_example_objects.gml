/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func terra_example_TerraObjects
/// @desc ???
/// @arg	cellsw
/// @arg	cellsh
function terra_example_TerraObjects(_cellsw, _cellsh, _x1, _y1)
{
	var _T1_chest = new TerraObject(obj_chest, {
		reward: "1",
		image_blend: c_white
	});
	var _T2_chest = new TerraObject(obj_chest, {
		reward: "2",
		image_blend: c_aqua
	});
	var _T3_chest = new TerraObject(obj_chest, {
		reward: "3",
		image_blend: c_lime
	});
	
	
	//Create a new TerraGrid to store the terrain.
	var _terrain = terra_grid_create(_cellsw, _cellsh, noone);
	
	terra_scatter(_terrain, noone, _T1_chest, 50);
	terra_scatter(_terrain, _T1_chest, _T2_chest, 50);
	terra_scatter(_terrain, _T2_chest, _T3_chest, 50);
	
	terra_grid_instantiate_layer(_terrain, _x1, _y1, "Instances_1");
	
	//Cleaning up.
	terra_grid_destroy(_terrain);
}