/// @description Setting up things.
randomize();

jen_grid_cellsize(16, 16);

var width = room_width / global.jen_xcell;
var height = room_height / global.jen_ycell;
gridA = jen_grid_create(width, height, ".");

jen_wander_line(gridA, 0, irandom_range(3, height - 4), width, irandom_range(3, height - 4), 5, 10, 3, 10, 50, ".", "X");

mazeA = jen_maze_prim(10, 10);
jen_maze_exits(mazeA, 1, 1, 100, 2, 2, 2);