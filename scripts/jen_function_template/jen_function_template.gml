// A template function for use in the option [function] parameter.

/// @description This function will be applied at a position instead of simply writing a value.
/// This function will be provided the grid, and the x/y position currently being changed.
/// It will also be provided a struct containing all the other parameters of the base function.
function jen_function_template(grid, xx, yy, info)
{
	//Example: This would be the default behavior when no function is provided.
	jen_set(grid, xx, yy, info.replace, info.new_value); //Replace with your own code.
}

/// @description This is an example function, calculating a chance based on a sin wave.
/// The new values will be more dense along a vertical line down the center of the grid.
function jen_function_sin(grid, xx, yy, info)
{
	var width = ds_grid_width(grid);
	var chance = sin((pi * xx) / width) * 100;
	if (random(100) < chance)
	{
		jen_set(grid, xx, yy, info.replace, info.new_value);
	}
}