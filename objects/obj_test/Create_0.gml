/// @description Testing Code.
jen_grid_basic();
jen_grid_custom_functions();

global.mainGrid = new JenGrid(40, 20, ".");
//global.mainGrid.scatter(".", "O", 25);

//global.mainGrid.scatter(".", "O", 100, jen_customA);
//global.mainGrid.replace(".", "O", jen_horizontal_sin);

global.mainGrid.rectangle(3, 3, 36, 16, all, "O", false, 100, jen_rectangle_custom);