/// These scripts are compatability scripts, for every old [Jen_script] function.

//Initialization/Settings
#region jen_grid_create
/// @function jen_grid_create(width, height, [cleared]);
/// @description Creates a new grid, filled with a given value.
/// @param width
/// @param height
/// @param [cleared]
function jen_grid_create(_width, _height, _cleared)
{
	show_debug_message("[Jen_scripts] WARNING: Using compatability script jen_grid_create.");
	if (is_undefined(_cleared)) { _cleared = noone; }
	return new JenGrid(_width, _height, _cleared);
}
#endregion

//Other Grid Functions
#region jen_replace
/// @function jen_replace(grid, replace, value)
/// @description Replaces all of one value with another.
/// @param grid
/// @param replace
/// @param value
function jen_replace(_grid, _replace, _value)
{
	show_debug_message("[Jen_scripts] WARNING: Using compatability script jen_replace.");
	_grid.replace(_replace, _value);
}
#endregion

//Basic Shapes
#region jen_rectangle
/// @function jen_rectangle(grid, x1, y1, x2, y2, replace, value, outline, [chance], [function]);
/// @description Creates a rectangle between two points.
/// @param grid
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param replace
/// @param value
/// @param outline
/// @param [chance]
/// @param [function]
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _replace, _value, _outline, _chance, _function)
{
	show_debug_message("[Jen_scripts] WARNING: Using compatability script jen_rectangle.");
	if (is_undefined(_chance)) { _chance = 100; }
	if (!is_undefined(_function)) { show_debug_message("[Jen_scripts] WARNING: jen_rectangle [function] parameter is not backwards compatible."); }
	_grid.rectangle(_x1, _y1, _x2, _y2, _replace, _value, _outline, _chance);
}
#endregion

//Basic Distribution
#region jen_scatter
/// @function jen_scatter(grid, replace, value, [chance], [function]);
/// @description Changes a percentage of one value to another value.
/// @param grid
/// @param replace
/// @param value
/// @param [chance]
/// @param [function]
function jen_scatter(_grid, _replace, _value, _chance, _function)
{
	show_debug_message("[Jen_scripts] WARNING: Using compatability script jen_scatter.");
	if (is_undefined(_chance)) { _chance = 100; }
	if (!is_undefined(_function)) { show_debug_message("[Jen_scripts] WARNING: jen_scatter [function] parameter is not backwards compatible."); }
	_grid.scatter(_replace, _value, _chance);
}
#endregion