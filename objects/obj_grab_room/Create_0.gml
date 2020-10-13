/// @description Create lists for each of the prebuilt rooms.
jen_grid_cellsize(16, 16);
global.list_U = jen_grid_room_array(0, 0, 7, 7, 3, 1, 1, 1);
global.list_L = jen_grid_room_array(0, 8, 7, 7, 3, 1, 1, 1);
global.list_I = jen_grid_room_array(0, 16, 7, 7, 3, 1, 1, 1);
global.list_T = jen_grid_room_array(0, 24, 7, 7, 3, 1, 1, 1);
global.list_O = jen_grid_room_array(0, 32, 7, 7, 3, 4, 1, 1); //3, 1 instead for example.
alarm[0] = 1;