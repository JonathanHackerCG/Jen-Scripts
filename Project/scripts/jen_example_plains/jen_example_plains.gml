/// THIS EXAMPLE IS FINISHED

/// @func jen_example_plains
/// @desc A field with boulders, trees, and flowers.
/// @arg	cellsw
/// @arg	cellsh
function jen_example_plains(_cellsw, _cellsh, _x1, _y1)
{
	//Create a new JenGrid to store the terrain.
	var _terrain = jen_grid_create(_cellsw, _cellsh, TILE.GRASS);
	
	#region Layer 1 (Tiles - Ground)
	//Add some patches of dirt.
	jen_scatter(_terrain, TILE.GRASS, TILE.DIRT, 5);
	jen_near(_terrain, TILE.DIRT, TILE.GRASS, TILE.DIRT, 2, 40);
	
	//Instantiate the first layer of the terrain.
	jen_grid_instantiate_tiles(_terrain, _x1, _y1, "Tiles_1");
	#endregion
	#region Layer 2 (Instances - Trees/Rocks)
	//Add borderstone wall.
	jen_rectangle(_terrain, 0, 0, _cellsw - 1, _cellsh - 1, 1, all, obj_borderstone);
	jen_rectangle(_terrain, 1, 1, _cellsw - 2, _cellsh - 2, 1, all, obj_borderstone, 50);
	
	//Categorize grass and dirt as ground.
	jen_replace(_terrain, [TILE.GRASS, TILE.DIRT], "ground");
	
	//Generating 3 clumps of stone.
	jen_number(_terrain, 3, "ground", obj_cliff);
	jen_near(_terrain, obj_cliff, "ground", obj_cliff, 2, 50);
	jen_near(_terrain, obj_cliff, "ground", obj_cliff, 1, 50);
	jen_near(_terrain, obj_cliff, "ground", obj_cliff, 1, 100);
	
	//Generating some rare copper and iron veins.
	jen_scatter(_terrain, obj_cliff, [obj_cliff_copper, obj_cliff_iron], 2);
	if (jen_grid_count(_terrain, obj_cliff_copper) == 0)	{ jen_number(_terrain, 1, obj_cliff, obj_cliff_copper); }
	if (jen_grid_count(_terrain, obj_cliff_iron) == 0)		{ jen_number(_terrain, 1, obj_cliff, obj_cliff_iron);		}
	jen_near(_terrain, obj_cliff_copper, obj_cliff, obj_cliff_copper, 2, 20);
	jen_near(_terrain, obj_cliff_iron, obj_cliff, obj_cliff_iron, 2, 20);
	
	//Generating a scattering of trees and branches.
	jen_scatter(_terrain, "ground", obj_tree, 25);
	jen_number_offset(_terrain, obj_tree, 0, 1, 5, "ground", obj_branch);
	
	//Instantiate the instance layer of the terrain.
	jen_grid_instantiate_depth(_terrain, _x1, _y1, DEPTH_LAYER_2);
	#endregion
	#region Layer 3 (Tiles - Flowers)
	jen_replace_not(_terrain, "ground", TILE.NONE);
	jen_scatter(_terrain, "ground", TILES_FLOWERS, 5);
	jen_near(_terrain, TILES_FLOWERS, "ground", TILES_FLOWERS, 2, 50);
	
	//Instantiate the second tile layer of the terrain.
	jen_grid_instantiate_tiles(_terrain, _x1, _y1, "Tiles_2", function(_data)
	{
		_data = tile_set_mirror(_data, irandom(1));
		return _data;
	});
	#endregion
	
	//Cleaning up.
	jen_grid_destroy(_terrain);
}