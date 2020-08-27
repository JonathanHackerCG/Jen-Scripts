/// @description Setting up things.
randomize();

jen_grid_cellsize(16, 16);

var width = room_width / global.jen_xcell;
var height = room_height / global.jen_ycell;
gridA = jen_grid_create(width, height, ".");

tree_list = ds_list_create();
repeat(5)
{
	var tree = jen_grid_create(5, 6, noone);
	jen_line(tree, 2, irandom_range(2, 4), 2, 5, noone, "O");
	jen_scatter_offset(tree, "O", 0, -1, noone, "X");
	jen_near(tree, "X", noone, "X", 1, 25);
	jen_near(tree, "X", noone, "X", 1);
	ds_list_add(tree_list, tree);
}

jen_number_apply_list(gridA, tree_list, ".", -2, -5, ".", 4);

heightmapA = jen_heightmap_gradient(40, 40, 5, 0.25);