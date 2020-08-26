/// @description Setting up things.
randomize();

jen_grid_cellsize(16, 16);

var width = room_width / global.jen_xcell;
var height = room_height / global.jen_ycell;
gridA = jen_grid_create(width, height, ".");

tree = jen_grid_create(3, 3, noone);
jen_line(tree, 0, 0, 2, 2, noone, "T");

jen_wander_line(gridA, 0, irandom_range(3, height - 4), width, irandom_range(3, height - 4), 5, 10, 3, 10, 50, ".", "X");
jen_scatter_offset(gridA, "X", 0, -1, ".", "^", 50);
jen_number_offset(gridA, "^", 0, -2, ".", "O", 3);

jen_number_apply(gridA, tree, ".", -1, -1, ".", 5);