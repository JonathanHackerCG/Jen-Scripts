/// NOTE TO SELF: When finishing an example script, check off "test cases" for all the functions used.

/// @func jen_example_ruins
/// @desc Scattered ruins of a stone structure.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_ruins(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, obj_grass);
	
	#region Making Ruins
	var _ruins_w = 5;
	var _ruins_h = 5;
	var _n = 5;
	var _ruins_array = [];
	
	repeat (_n)
	{
		var _ruin = jen_grid_create(_ruins_w, _ruins_h, noone);
		jen_rectangle(_ruin, 0, 0, _ruins_w - 1, _ruins_h - 1, 1, all, obj_wall, 80);
		jen_set(_ruin, 2, 2, noone, obj_chest);
		jen_scatter(_ruin, noone, [obj_spike, obj_torch], 25);
		
		array_push(_ruins_array, _ruin);
	}
	#endregion
	#region First Layer (Terrain)
	//Add some patches of dirt.
	jen_scatter(_terrain, obj_grass, obj_dirt, 5);
	jen_near(_terrain, obj_dirt, obj_grass, obj_dirt, 2, 40);
	
	//Instantiate the first layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	#endregion
	#region Second Layer (Walls and Ruins)
	//Add borderstone wall.
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, 1, all, obj_borderstone);
	jen_rectangle(_terrain, 1, 1, _cellsw - 2, _cellsh - 2, 1, all, obj_borderstone, 50);
	
	//Categorize grass and dirt as ground.
	jen_replace(_terrain, [obj_grass, obj_dirt], "ground");
	jen_scatter(_terrain, all, "ruins", 100, function(grid, xx, yy, replace, new_value)
	{
		if ((xx - 2) % 6 == 0 && (yy - 2) % 6 == 0)
		{
			jen_set(grid, xx, yy, replace, new_value);
		}
	});
	
	//Add ruins around.
	jen_scatter_paste(_terrain, _ruins_array, "ruins", -2, -2, 20, "ground", 100);
	//jen_number_paste(_terrain, _ruins_array, "ruins", -2, -2, 3, "ground");
	
	//Instantiate the second layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_2);
	#endregion
	#region Testing lines.
	//var n = 1;
	//repeat (n)
	//{
	//	var x1 = irandom_range(0, _cellsw);
	//	var y1 = irandom_range(0, _cellsh);
	//	var x2 = irandom_range(0, _cellsw);
	//	var y2 = irandom_range(0, _cellsh);
	//	jen_line(_terrain, x1, y1, x2, y2, obj_grass, obj_dirt, 90);
	//}
	
	//jen_obfuscate(_terrain, obj_dirt, obj_grass, 100);
	//jen_near(_terrain, obj_dirt, obj_grass, obj_dirt, 1, 20);
	//jen_near(_terrain, obj_dirt, obj_grass, obj_sand, 1);
	
	//Instantiate the first layer of the terrain.
	//jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_1);
	#endregion
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
	for (var i = 0; i < _n; i++)
	{
		jen_grid_destroy(_ruins_array[i]);
	}
}