/// @description Testing Code.
jen_grid_basic();
jen_grid_template();

global.mainGrid = new JenGrid(40, 20, ".");
//global.mainGrid.scatter(".", "O", 25);

global.mainGrid.scatter(".", "O", 100, jen_customA);