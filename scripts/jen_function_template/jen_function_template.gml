// A template function for use in the option [function] parameter.

/// @description This function will be applied at a position instead of simply writing a value.
/// This function will be provided the grid, and the x/y position and values currently being changed.
function jen_function_template(grid, xx, yy, replace, new_value)
{
	//Example: This would be the default behavior when no function is provided.
	jen_set(grid, xx, yy, replace, new_value); //Replace with your own code.
}

/// @description This is an example function, calculating a chance based on a sin wave.
/// The new values will be more dense along a vertical line down the center of the grid.
function jen_function_sin(grid, xx, yy, replace, new_value)
{
	var width = jen_grid_width(grid);
	var chance = sin((pi * xx) / width) * 100;
	if (random(100) < chance)
	{
		jen_set(grid, xx, yy, replace, new_value);
	}
}

/// @description This is another example function, of a different application of custom functions.
/// This function will add the point to a list. For instance, it may be used with jen_number.
global.output_list = ds_list_create();
function jen_function_log(grid, xx, yy, replace, new_value)
{
	//Create a struct storing the position this change was made.
	var pos = { x1 : xx, y1 : yy}
	ds_list_add(global.output_list, pos);
	
	//Then set the value normally.
	jen_set(grid, xx, yy, replace, new_value);
}