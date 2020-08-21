/// @description Setting up things.
randomize();

gridA = jen_grid_create(25, 25, ".");
gridB = jen_grid_create(5, 5, "X");

jen_ellipse(gridA, 10, 10, 5, 8, all, "O", 45, true, 75);