/// These scripts are compatability scripts, for every old [Jen_script] function.
#region jen_grid_create
/// @function jen_grid_create(_width, _height, [_cleared]);
/// @description Creates a new grid, filled with a given value.
/// @param _width
/// @param _height
/// @param [_cleared]
function jen_grid_create(_width, _height, _cleared)
{
	if (is_undefined(_cleared)) { _cleared = noone; }
	return new JenGrid(_width, _height, _cleared);
}
#endregion
#region jen_scatter
/// @function jen_scatter(_grid, _replace, _value, [_chance], [_function]);
/// @description Changes a percentage of one value to another value.
/// @param _grid
/// @param _replace
/// @param _value
/// @param [_chance]
/// @param [_function]
function jen_scatter(_grid, _replace, _value, _chance, _function)
{
	if (is_undefined(_chance)) { _chance = 100; }
	if (!is_undefined(_function)) { show_debug_message("[Jen_scripts] WARNING: [_function] parameter is not backwards compatible. Please update to use method syntax."); }
	_grid.scatter(_replace, _value, _chance);
}
#endregion