/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func jen_example_caves
/// @desc A natural looking cave.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_caves(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_cobbles);
	
	#region First Layer (Ground)
	//Generating small lakes.
	jen_scatter(_terrain, obj_cobbles, obj_water_shallow, 0.5);
	jen_near(_terrain, obj_water_shallow, obj_cobbles, obj_water_shallow, 2.0, 50);
	jen_near(_terrain, obj_water_shallow, obj_cobbles, obj_water_shallow, 1.5, 100);
	
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	#endregion
	#region Second Layer (Walls)
	//Converting first layer.
	jen_replace(_terrain, obj_water_shallow, "water");
	jen_replace(_terrain, obj_cobbles, noone);
	jen_scatter(_terrain, noone, obj_cliff, 35);
	
	//Generating cliff walls.
	repeat (2) { jen_example_caves_iterate(_terrain); }
	
	//Generating ore veins.
	jen_scatter(_terrain, obj_cliff, obj_cliff_copper, 3);
	jen_near(_terrain, obj_cliff_copper, obj_cliff, obj_cliff_copper, 1, 50);
	jen_scatter(_terrain, obj_cliff, obj_cliff_iron, 3);
	jen_near(_terrain, obj_cliff_iron, obj_cliff, obj_cliff_iron, 1, 50);
	
	//Generating torches.
	jen_scatter(_terrain, noone, obj_torch, 1);
	
	//Generating monsters.
	jen_scatter(_terrain, [noone, "water"], obj_slime, 1);
	jen_near(_terrain, obj_slime, [noone, "water"], obj_slime, 2, 10);
	
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_2);
	#endregion
	
	return _terrain; //Return for iteration.
	//Must be instantiated separately.
}

function jen_example_caves_iterate(_terrain)
{
	jen_automata(_terrain, obj_cliff, noone, true, [0, 1, 2], [4, 5, 6, 7, 8]);
	return _terrain; //Return for iteration.
	//Must be instantiated separately.
}