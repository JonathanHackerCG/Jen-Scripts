/// @description Setting up things.
randomize();

jen_grid_cellsize(16, 16);

var width = room_width / global.jen_xcell;
var height = room_height / global.jen_ycell;
gridA = jen_grid_create(width, height, noone);

jen_scatter(gridA, all, obj_blue, 1);
jen_near(gridA, obj_blue, noone, obj_blue, 1, 30);
jen_near(gridA, obj_blue, noone, obj_blue, 2);
jen_scatter(gridA, noone, obj_red, 80);

jen_grid_instantiate_autotile(gridA, 0, 0, obj_red, true, "Tiles_1");
jen_grid_instantiate_autotile(gridA, 0, 0, obj_blue, true, "Tiles_1", 1);